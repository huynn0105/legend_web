import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/dialogs/dialog_provider.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/toast/toast_provider.dart';
import 'package:legend_mfast/common/utils/count_down_util.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/common/widgets/appbar.dart';
import 'package:legend_mfast/common/widgets/avatar_widget.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/empty_widget.dart';
import 'package:legend_mfast/common/widgets/loading.dart';
import 'package:legend_mfast/common/widgets/loadmore_widget.dart';
import 'package:legend_mfast/features/legendary/cubit/collaborator_pending/collaborator_pending_cubit.dart';
import 'package:legend_mfast/models/collaborator/collaborator_pending_model.dart';

import '../../../../routes/routes.gr.dart';

@RoutePage()
class CollaboratorPendingPage extends StatefulWidget implements AutoRouteWrapper {
  const CollaboratorPendingPage({
    super.key,
    required this.userPending,
    required this.onUserPendingChange,
  });

  final int userPending;
  final Function(int userPending) onUserPendingChange;

  @override
  State<CollaboratorPendingPage> createState() => _CollaboratorPendingPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CollaboratorPendingCubit();
        cubit.getData();
        return cubit;
      },
      child: this,
    );
  }
}

class _CollaboratorPendingPageState extends State<CollaboratorPendingPage> {
  @override
  void initState() {
    context.read<CollaboratorPendingCubit>().updateUserPending(widget.userPending);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLayout(
        child: Column(
          children: [
            MFastSimpleAppBar(
              context: context,
              title: "Cộng tác viên chờ duyệt",
            ),
            Expanded(
              child: BlocConsumer<CollaboratorPendingCubit, CollaboratorPendingState>(
                listener: (context, state) {
                  if (state.confirmStatus.isSuccess) {
                    if (state.action == CollaboratorPendingAction.confirm) {
                      ToastProvider.instance.display('Đã đồng ý lời mời');
                    }
                    if (state.action == CollaboratorPendingAction.reject) {
                      ToastProvider.instance.display('Đã từ chối lời mời');
                    }
                    widget.onUserPendingChange.call(state.userPending);
                  }
                  if (state.confirmStatus.isFailure) {
                    DialogProvider.instance.showMascotErrorDialog(
                      context: context,
                      message: state.errorMessage,
                    );
                  }
                },
                builder: (context, state) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                              children: [
                                const TextSpan(text: 'Có '),
                                TextSpan(
                                    text: '${state.userPending}',
                                    style: UITextStyle.bold.copyWith(
                                      fontSize: 14,
                                      color: UIColors.grayBackground,
                                    )),
                                const TextSpan(text: ' cộng tác viên chờ bạn xác nhận'),
                              ],
                              style: UITextStyle.regular.copyWith(
                                fontSize: 14,
                                color: UIColors.grayBackground,
                              ),
                            )),
                            const SizedBox(height: 12),
                            Expanded(
                              child: state.status.isLoading
                                  ? const Center(child: CircularProgressIndicator())
                                  : LoadMoreWidget(
                                      onLoadMore: () async {
                                        context.read<CollaboratorPendingCubit>().loadmoreData();
                                      },
                                      onRefresh: () async {
                                        context.read<CollaboratorPendingCubit>().refreshData();
                                      },
                                      child: state.data.isNotEmpty
                                          ? ListView.separated(
                                              separatorBuilder: (_, __) => const SizedBox(height: 16),
                                              itemBuilder: (context, index) => _CollaboratorPendingItem(
                                                  collaborator: state.data[index],
                                                  onTap: () {
                                                    context.router.push(
                                                      CollaboratorPendingConfrimRoute(
                                                        id: state.data[index].id,
                                                        onRemoveItem: (id) {
                                                          context.read<CollaboratorPendingCubit>().onRemoveItem(id);
                                                          widget.onUserPendingChange.call(state.userPending);
                                                        },
                                                      ),
                                                    );
                                                  }),
                                              itemCount: state.data.length,
                                            )
                                          : const Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(top: 32),
                                                  child: EmptyWidget(
                                                    message: 'Không tìm thấy cộng tác viên chờ duyệt nào',
                                                    icon: 'ic_null',
                                                    iconWidth: 24,
                                                    iconHeight: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: state.confirmStatus.isLoading,
                        child: const LoadingWidget.dark(),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollaboratorPendingItem extends StatelessWidget {
  const _CollaboratorPendingItem({
    super.key,
    required this.collaborator,
    required this.onTap,
  });

  final CollaboratorPendingModel collaborator;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppSplashButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 12),
        decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarWidget(
                  url: collaborator.avatarImage,
                  size: 56,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              collaborator.fullName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: UITextStyle.medium.copyWith(
                                color: UIColors.lightBlack,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: UIColors.darkGray,
                            ),
                            margin: const EdgeInsets.only(left: 6, right: 6, top: 2),
                          ),
                          Text(
                            collaborator.level ?? '',
                            style: UITextStyle.medium.copyWith(
                              color: UIColors.darkBlue,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        CountDownUtil.formatDateAgo(DateTimeUtil.getRemainSeconds(
                          collaborator.createdDate,
                          format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
                          isFromUtc: false,
                        )),
                        style: UITextStyle.regular.copyWith(
                          color: UIColors.grayText,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.navigate_next,
                  size: 30,
                  color: UIColors.darkGray,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              collaborator.note ?? '',
              style: UITextStyle.regular.copyWith(
                fontSize: 13,
                color: UIColors.lightBlack,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {
                      context
                          .read<CollaboratorPendingCubit>()
                          .confirmCollaboratorPending(collaborator.id ?? '', CollaboratorPendingAction.reject);
                    },
                    borderColor: UIColors.grayBackground,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(24),
                    child: Text(
                      'Bỏ qua',
                      style: UITextStyle.regular.copyWith(
                        fontSize: 14,
                        color: UIColors.extraGrayText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      context
                          .read<CollaboratorPendingCubit>()
                          .confirmCollaboratorPending(collaborator.id ?? '', CollaboratorPendingAction.confirm);
                    },
                    title: 'Đồng ý',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
