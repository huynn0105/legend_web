import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/bottom_sheet/bottom_sheet_provider.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/constants.dart';
import 'package:legend_mfast/common/dialogs/dialog_provider.dart';
import 'package:legend_mfast/common/enum/collaborator/collaborator_status.dart';
import 'package:legend_mfast/common/extension/list_extension.dart';
import 'package:legend_mfast/common/global_function.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/common/widgets/appbar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/common/widgets/loading.dart';
import 'package:legend_mfast/features/legendary/cubit/collaborator_remove/collaborator_remove_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/collaborator_need_to_care/components/collaborator_list_component.dart';
import 'package:legend_mfast/features/legendary/pages/collaborator_need_to_care/components/tab_select_component.dart';
import 'package:legend_mfast/general_config.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../common/event_bus/event_bus.dart';
import '../../../../models/general_object.dart';
import '../../cubit/collaborator_need_to_care/collaborator_need_to_care_cubit.dart';

part 'components/conditions_for_leaving.dart';

@RoutePage()
class CollaboratorNeedToCarePage extends StatefulWidget implements AutoRouteWrapper {
  const CollaboratorNeedToCarePage({
    super.key,
    this.collaboratorStatus,
    @QueryParam('initIndex') this.initIndex,
  });

  final CollaboratorStatus? collaboratorStatus;
  final int? initIndex;

  @override
  State<CollaboratorNeedToCarePage> createState() => _CollaboratorNeedToCarePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    final status = collaboratorStatus ?? CollaboratorStatus.values.valueAt(initIndex) ?? CollaboratorStatus.working;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CollaboratorNeedToCareCubit()..fetchData(status)),
        BlocProvider(create: (_) {
          if (collaboratorStatus == CollaboratorStatus.can_remove) {
            return CollaboratorRemoveCubit()..checkExistRemoveAction();
          }
          return CollaboratorRemoveCubit();
        }),
      ],
      child: this,
    );
  }
}

class _CollaboratorNeedToCarePageState extends State<CollaboratorNeedToCarePage> {
  late final AutoScrollController tabController;

  late final PageController controller;

  @override
  void initState() {
    var tabIndex = (widget.initIndex ?? 0).clamp(0, CollaboratorStatus.values.length - 1);
    if (widget.collaboratorStatus == CollaboratorStatus.working) {
      tabIndex = CollaboratorStatus.working.index;
    }
    if (widget.collaboratorStatus == CollaboratorStatus.follow) {
      tabIndex = CollaboratorStatus.follow.index;
    }
    if (widget.collaboratorStatus == CollaboratorStatus.can_leave) {
      tabIndex = CollaboratorStatus.can_leave.index;
    }
    if (widget.collaboratorStatus == CollaboratorStatus.can_remove) {
      tabIndex = CollaboratorStatus.can_remove.index;
    }
    if (widget.collaboratorStatus == CollaboratorStatus.departed) {
      tabIndex = CollaboratorStatus.departed.index;
    }
    controller = PageController(initialPage: tabIndex);
    tabController = AutoScrollController();
    _scrollToIndex(tabIndex);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MFastSimpleAppBar(
                  context: context,
                  title: "CTV cần theo dõi",
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      style: UITextStyle.regular.copyWith(
                        color: UIColors.grayText,
                      ),
                      children: [
                        const TextSpan(
                          text: "Cộng tác viên của bạn có quyền tự rời đi nếu họ không nhận được sự hỗ trợ tối thiểu. ",
                        ),
                        TextSpan(
                          text: "Xem chi tiết >>>",
                          style: UITextStyle.bold.copyWith(
                            color: UIColors.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              BottomSheetProvider.instance.show(
                                context,
                                title: "Điều kiện để rời đi",
                                child: const _ConditionsForLeaving(),
                              );
                            },
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TabSelectComponent(
                  tabController: tabController,
                  onSelectedTab: (int index) {
                    _scrollToIndex(index);
                    controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    if (index == CollaboratorStatus.can_remove.index) {
                      context.read<CollaboratorRemoveCubit>().checkExistRemoveAction();
                    }
                  },
                ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    onPageChanged: (int index) {
                      _scrollToIndex(index);
                      context.read<CollaboratorNeedToCareCubit>().selectTabOption(
                            GeneralObject(
                              code: CollaboratorStatus.values[index].name,
                              name: CollaboratorStatus.values[index].title,
                            ),
                          );
                    },
                    children: [
                      CollaboratorListComponent(
                        tabCode: CollaboratorStatus.working.name,
                      ),
                      CollaboratorListComponent(
                        tabCode: CollaboratorStatus.follow.name,
                      ),
                      CollaboratorListComponent(
                        tabCode: CollaboratorStatus.can_leave.name,
                      ),
                      CollaboratorListComponent(
                        tabCode: CollaboratorStatus.departed.name,
                      ),
                      if (AppConstants.visibleCollaboratorCanRemove)
                        CollaboratorListComponent(
                          tabCode: CollaboratorStatus.can_remove.name,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          BlocConsumer<CollaboratorRemoveCubit, CollaboratorRemoveState>(
            listener: (context, state) {
              if (state.statusRemove.isSuccess) {
                if (state.removeType == 'waiting') {
                  DialogProvider.instance.showMascotDialog(
                    context: context,
                    asset: 'ic_mtrade_mascot_happy_waiting2',
                    titleColor: UIColors.orange,
                    messageColor: UIColors.defaultText,
                    enableAutoPop: true,
                    title: 'Thành công!!!',
                    message: state.msgRemove,
                    messageAlign: TextAlign.left,
                    negativeTitle: 'Quay lại',
                  );
                } else {
                  context.read<CollaboratorNeedToCareCubit>().getAllCollaboratorsByFilter();
                  eventBus.fire(const RemoveCollaboratorEventBus());
                  DialogProvider.instance.showMascotDialog(
                    context: context,
                    asset: 'ic_mtrade_mascot_success',
                    titleColor: UIColors.green,
                    messageColor: UIColors.defaultText,
                    enableAutoPop: true,
                    title: 'Thành công!!!',
                    message: state.msgRemove,
                    messageAlign: TextAlign.left,
                    negativeTitle: 'Quay lại',
                  );
                }
              } else if (state.statusRemove.isFailure) {
                DialogProvider.instance.showMascotDialog(
                  context: context,
                  asset: 'ic_mtrade_mascot_error',
                  titleColor: UIColors.red,
                  messageColor: UIColors.defaultText,
                  enableAutoPop: true,
                  title: 'Thất bại!!!',
                  message: state.msgRemove,
                  messageAlign: TextAlign.left,
                  negativeTitle: 'Quay lại',
                );
              }
              if (state.statusCheckRemove.isSuccess && TextUtils.isNotEmpty(state.msgCheckRemove)) {
                DialogProvider.instance.showMascotDialog(
                  context: context,
                  asset: 'ic_mtrade_mascot_happy_waiting2',
                  titleColor: UIColors.boldBlue,
                  messageColor: UIColors.defaultText,
                  enableAutoPop: true,
                  title: 'Đang xóa cộng tác viên',
                  message: state.msgCheckRemove,
                  messageAlign: TextAlign.left,
                  positiveTitle: 'Đã hiểu và quay lại',
                );
              }
            },
            builder: (context, state) {
              return Visibility(
                visible: state.statusRemove.isLoading,
                child: const LoadingWidget.dark(),
              );
            },
          )
        ],
      ),
    );
  }

  _scrollToIndex(int index) {
    tabController.scrollToIndex(
      index,
      duration: const Duration(milliseconds: 300),
      preferPosition: AutoScrollPosition.begin,
    );
  }
}
