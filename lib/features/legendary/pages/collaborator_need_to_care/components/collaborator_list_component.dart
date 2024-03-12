import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/dialogs/dialog_provider.dart';
import 'package:legend_mfast/features/legendary/cubit/collaborator_need_to_care/collaborator_need_to_care_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/collaborator_remove/collaborator_remove_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/collaborator_need_to_care/components/collaborator_need_to_care_filters_component.dart';
import 'package:legend_mfast/features/legendary/pages/collaborator_need_to_care/items/collaborator_depart_item.dart';
import 'package:legend_mfast/models/collaborator/collaborator_care_list_model.dart';
import 'package:legend_mfast/routes/routes.gr.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/enum/collaborator/collaborator_status.dart';
import '../../../../../common/styles.dart';
import '../../../../../common/widgets/checkbox.dart';
import '../../../../../common/widgets/empty_widget.dart';
import '../../../../../common/widgets/images.dart';
import '../../../../../common/widgets/loading.dart';
import '../../../../../common/widgets/loadmore_widget.dart';
import '../items/collaborator_working_item.dart';

class CollaboratorListComponent extends StatefulWidget {
  const CollaboratorListComponent({
    super.key,
    this.tabCode,
  });

  final String? tabCode;

  @override
  State<CollaboratorListComponent> createState() => _CollaboratorListComponentState();
}

class _CollaboratorListComponentState extends State<CollaboratorListComponent> {
  late final RefreshController refreshController;

  @override
  void initState() {
    refreshController = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showRemoveCheckBox = widget.tabCode == CollaboratorStatus.can_remove.name;
    return Container(
      color: UIColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocConsumer<CollaboratorNeedToCareCubit, CollaboratorNeedToCareState>(
        listener: (context, state) {
          if (_getTabStatus(state).isLoading) {
            refreshController.resetNoData();
          }
        },
        builder: (context, state) {
          final data = _getCollaborators(state);
          return LoadMoreWidget(
            refreshController: refreshController,
            onLoadMore: () {
              return _onLoadMore(context);
            },
            child: BlocBuilder<CollaboratorRemoveCubit, CollaboratorRemoveState>(
              builder: (context, stateRemove) {
                bool hasSelected = stateRemove.selectedAll || stateRemove.selectedUserId.isNotEmpty;
                return CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 12),
                    ),
                    SliverToBoxAdapter(
                      child: RichText(
                        text: TextSpan(
                          style: UITextStyle.regular,
                          children: [
                            const TextSpan(text: "Danh sách "),
                            TextSpan(text: '${_getCollaboratorTotal(state)}', style: UITextStyle.bold),
                            TextSpan(text: " cộng tác viên ${state.selectedTab?.name?.toLowerCase()}"),
                          ],
                        ),
                      ),
                    ),
                    if (widget.tabCode == CollaboratorStatus.can_remove.name) ...[
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 4),
                      ),
                      SliverToBoxAdapter(
                        child: RichText(
                          text: TextSpan(
                            style: UITextStyle.regular.copyWith(
                              color: UIColors.grayText,
                            ),
                            children: [
                              const TextSpan(
                                text: '(Lưu ý: chỉ những ',
                              ),
                              TextSpan(
                                text: 'CTV tầng 1',
                                style: UITextStyle.semiBold.copyWith(
                                  color: UIColors.red,
                                ),
                              ),
                              const TextSpan(text: ' và không truy cập MFast từ '),
                              TextSpan(
                                text: '60 ngày liên tiếp',
                                style: UITextStyle.semiBold.copyWith(
                                  color: UIColors.red,
                                ),
                              ),
                              const TextSpan(text: ' trở lên mới có thể xóa)')
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 16),
                      ),
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            SplashButton(
                              onTap: () {
                                if (_getCollaboratorTotal(state) > 0) {
                                  context.read<CollaboratorRemoveCubit>().selectAllUser();
                                }
                              },
                              child: Row(
                                children: [
                                  AppCheckbox.rectangle(
                                    value: stateRemove.selectedAll,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Chọn tất cả',
                                    style: UITextStyle.semiBold.copyWith(
                                      color: UIColors.grayText,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            SplashButton(
                              onTap: hasSelected ? _removeCollaborator : null,
                              child: Row(
                                children: [
                                  Text(
                                    'Xóa CTV',
                                    style: UITextStyle.semiBold.copyWith(
                                      color: hasSelected ? UIColors.red : UIColors.gray,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SplashButton(
                                    child: AppImage.asset(
                                      asset: 'ic_delete',
                                      width: 24,
                                      height: 24,
                                      color: hasSelected ? UIColors.red : UIColors.gray,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Divider(height: 21, thickness: 1, color: UIColors.lightGray),
                      ),
                    ] else if (widget.tabCode != CollaboratorStatus.working.name) ...[
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 12),
                      ),
                      const SliverToBoxAdapter(
                        child: CollaboratorNeedToCareFiltersComponent(),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 12),
                      ),
                    ] else ...[
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 12),
                      ),
                    ],
                    if (_getTabStatus(state).isInitial || _getTabStatus(state).isLoading)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: LoadingWidget(),
                        ),
                      )
                    else if (data.isEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: EmptyWidget(
                            message: 'Không tìm thấy cộng tác viên nào',
                            icon: 'ic_null',
                            iconWidth: 24,
                            iconHeight: 24,
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.only(bottom: 24),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) {
                              final int itemIndex = index ~/ 2;
                              if (index.isEven) {
                                bool checked = stateRemove.selectedUserId.contains(data[itemIndex].userID);

                                return widget.tabCode == CollaboratorStatus.departed.name
                                    ? CollaboratorDepartItem(
                                        item: data[itemIndex],
                                        onTap: () {
                                          context.router.push(
                                            LegendaryHierCollaboratorRoute(userID: data[itemIndex].userID ?? ''),
                                          );
                                        },
                                      )
                                    : CollaboratorWorkingItem(
                                        type: widget.tabCode,
                                        item: data[itemIndex],
                                        showRemoveCheckBox: showRemoveCheckBox,
                                        checked: checked,
                                        selectedAll: stateRemove.selectedAll,
                                        onTapCheck: (value) {
                                          if (data[itemIndex].userID != null && !stateRemove.selectedAll) {
                                            context.read<CollaboratorRemoveCubit>().selectUser(data[itemIndex].userID!);
                                          }
                                        },
                                        onTap: () {
                                          context.router.push(
                                            LegendaryHierCollaboratorRoute(userID: data[itemIndex].userID ?? ''),
                                          );
                                        },
                                      );
                              }
                              return const Divider(height: 21, thickness: 1, color: UIColors.lightGray);
                            },
                            semanticIndexCallback: (Widget widget, int localIndex) {
                              if (localIndex.isEven) {
                                return localIndex ~/ 2;
                              }
                              return null;
                            },
                            childCount: data.length * 2 - 1,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  BlocStatus _getTabStatus(CollaboratorNeedToCareState state) {
    if (widget.tabCode == CollaboratorStatus.working.name) {
      return state.statusWorking;
    }
    if (widget.tabCode == CollaboratorStatus.follow.name) {
      return state.statusFollow;
    }
    if (widget.tabCode == CollaboratorStatus.can_leave.name) {
      return state.statusCanLeave;
    }
    if (widget.tabCode == CollaboratorStatus.can_remove.name) {
      return state.statusCanRemove;
    }
    return state.statusDeparted;
  }

  int _getCollaboratorTotal(CollaboratorNeedToCareState state) {
    if (widget.tabCode == CollaboratorStatus.working.name) {
      return state.totalUserWorking;
    }
    if (widget.tabCode == CollaboratorStatus.follow.name) {
      return state.totalUserFollow;
    }
    if (widget.tabCode == CollaboratorStatus.can_leave.name) {
      return state.totalUserCanLeave;
    }
    if (widget.tabCode == CollaboratorStatus.can_remove.name) {
      return state.totalUserCanRemove;
    }
    return state.totalUserDeparted;
  }

  List<CollaboratorCareModel> _getCollaborators(CollaboratorNeedToCareState state) {
    if (widget.tabCode == CollaboratorStatus.working.name) {
      return state.dataUserWorking;
    }
    if (widget.tabCode == CollaboratorStatus.follow.name) {
      return state.dataUserFollow;
    }
    if (widget.tabCode == CollaboratorStatus.can_leave.name) {
      return state.dataUserCanLeave;
    }
    if (widget.tabCode == CollaboratorStatus.can_remove.name) {
      return state.dataUserCanRemove;
    }
    return state.dataUserDeparted;
  }

  _onLoadMore(BuildContext context) {
    final cubit = context.read<CollaboratorNeedToCareCubit>();
    return cubit.loadmoreData();
  }

  _removeCollaborator() {
    final cubit = context.read<CollaboratorRemoveCubit>();
    final dataUserCanRemove = context.read<CollaboratorNeedToCareCubit>().state.dataUserCanRemove;
    final totalUserCanRemove = context.read<CollaboratorNeedToCareCubit>().state.totalUserCanRemove;
    final selectedUser = cubit.state.selectedAll
        ? null
        : dataUserCanRemove.firstWhereOrNull((e) => e.userID == cubit.state.selectedUserId.first);
    int ctvCount = cubit.state.selectedAll ? totalUserCanRemove : cubit.state.selectedUserId.length;
    DialogProvider.instance.showMascotDialog(
      context: context,
      asset: 'ic_mtrade_mascot_waiting',
      titleColor: UIColors.orange,
      messageColor: UIColors.defaultText,
      enableAutoPop: true,
      title: ctvCount > 1 ? 'Xác nhận xóa $ctvCount cộng tác viên' : 'Xác nhận xóa CTV ${selectedUser?.fullName ?? ''}',
      message:
          'Thông tin, quyền lợi từ cộng tác viên đã xóa sẽ không thể khôi phục. Vui lòng kiểm tra kĩ trước khi tiếp tục.',
      positiveTitle: 'Kiểm tra lại',
      negativeTitle: 'Xóa CTV',
      negativeCallback: () {
        context.read<CollaboratorRemoveCubit>().removeCollaborator();
      },
    );
  }
}
