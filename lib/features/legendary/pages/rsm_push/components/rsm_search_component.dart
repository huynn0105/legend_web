import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_popup/info_popup.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/checkbox.dart';
import 'package:legend_mfast/common/widgets/empty_widget.dart';
import 'package:legend_mfast/common/widgets/widget_layout.dart';
import 'package:legend_mfast/features/legendary/cubit/rsm_push/rsm_push_user_cubit.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/styles.dart';
import '../../../../../models/collaborator/collaborator_rsm_push_model.dart';

class RSMSearchComponent extends StatelessWidget {
  const RSMSearchComponent({
    super.key,
    required this.child,
    this.onFocus,
    this.onRemoveUser,
    this.onAddUser,
    this.onControllerCreated,
    this.onDismiss,
  });

  final Widget child;
  final Function()? onFocus;
  final Function(CollaboratorRsmPushModel?)? onRemoveUser;
  final Function(CollaboratorRsmPushModel?)? onAddUser;
  final OnControllerCreated? onControllerCreated;
  final Function()? onDismiss;

  @override
  Widget build(BuildContext context) {
    return InfoPopupWidget(
      onControllerCreated: onControllerCreated,
      enableHighlight: true,
      dismissTriggerBehavior: PopupDismissTriggerBehavior.manuel,
      contentMaxWidth: AppSize.instance.width - 32,
      arrowTheme: const InfoPopupArrowTheme(
        color: Colors.transparent,
        arrowDirection: ArrowDirection.up,
      ),
      highLightTheme: HighLightTheme(
        backgroundColor: UIColors.blurBackground,
        padding: const EdgeInsets.all(2),
        radius: BorderRadius.circular(4),
      ),
      indicatorOffset: const Offset(0, 0),
      contentOffset: const Offset(0, 0),
      customContent: () {
        final state = context.watch<RSMPushUserCubit>().state;
        if (!state.searchStatus.isSuccess && state.searchUsers.isEmpty) {
          return PrimaryButton(
            width: 200,
            height: 40,
            onPressed: () {
              onDismiss?.call();
            },
            title: 'Đóng',
          );
        }
        return WidgetLayout(
          child: Container(
            key: const ValueKey('RSMSearchUser'),
            width: double.infinity,
            decoration: BoxDecoration(
              color: UIColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: state.searchStatus.isLoading
                ? Column(
                    children: [
                      const CupertinoActivityIndicator(),
                      const SizedBox(height: 8),
                      Text(
                        'Đang tìm kiếm cộng tác viên',
                        style: UITextStyle.regular.copyWith(
                          fontSize: 13,
                          color: UIColors.grayText,
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Visibility(
                        visible: state.searchUsers.isNotEmpty,
                        replacement: const EmptyWidget(
                          message: 'Không tìm thấy cộng tác viên nào',
                          icon: 'ic_null',
                          iconWidth: 24,
                          iconHeight: 24,
                        ),
                        child: SizedBox(
                          height: AppSize.instance.height / 2 - 60,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              bool removed =
                                  state.removedUsers.map((e) => e.id).contains(state.searchUsers[index].id) == true;
                              return Row(
                                children: [
                                  ChatAvatar(
                                    url: state.searchUsers[index].avatarImage ?? '',
                                    name: state.searchUsers[index].fullName ?? '',
                                    size: 56,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.searchUsers[index].fullName ?? '',
                                          style: UITextStyle.medium.copyWith(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              'Mã MFast:',
                                              style: UITextStyle.regular.copyWith(
                                                fontSize: 13,
                                                color: UIColors.grayText,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              state.searchUsers[index].referralCode ?? '',
                                              style: UITextStyle.medium.copyWith(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    removed ? 'Thêm' : 'Đã thêm',
                                    style: UITextStyle.regular.copyWith(
                                      fontSize: 13,
                                      color: UIColors.grayText,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  AppCheckbox.circle(
                                    value: !removed,
                                    onChanged: (value) {
                                      if (removed) {
                                        onAddUser?.call(state.searchUsers[index]);
                                      } else {
                                        onRemoveUser?.call(state.searchUsers[index]);
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                            itemCount: state.searchUsers.length,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        width: 200,
                        height: 40,
                        onPressed: () {
                          onDismiss?.call();
                        },
                        title: 'Đóng',
                      )
                    ],
                  ),
          ),
        );
      },
      onLayoutMounted: (Size size) {
        onFocus?.call();
      },
      child: child,
    );
  }
}
