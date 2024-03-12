import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_popup/info_popup.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/bottom_sheet/bottom_sheet_provider.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/dialogs/dialog_provider.dart';
import 'package:legend_mfast/common/event_bus/event_bus.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/common/widgets/empty_widget.dart';
import 'package:legend_mfast/features/legendary/pages/rsm_push/components/rsm_push_full_user_component.dart';
import 'package:legend_mfast/features/legendary/pages/rsm_push/components/rsm_search_component.dart';
import 'package:legend_mfast/general_config.dart';
import 'package:legend_mfast/models/general_object.dart';

import '../../../../../common/widgets/buttons.dart';
import '../../../../../common/widgets/textfields.dart';
import '../../../../../models/collaborator/collaborator_rsm_push_model.dart';
import '../../../../../widgets/filter_widget.dart';
import '../../../cubit/rsm_push/rsm_push_user_cubit.dart';
import '../components/rsm_filter_component.dart';
import '../components/rsm_filter_tag.dart';
import '../components/rsm_push_remove_user_component.dart';
import '../items/rsm_push_user_item.dart';

@RoutePage()
class RSMPushUserPage extends StatefulWidget {
  const RSMPushUserPage({super.key});

  @override
  State<RSMPushUserPage> createState() => _RSMPushUserPageState();
}

class _RSMPushUserPageState extends State<RSMPushUserPage> {
  late TextEditingController _searchController;
  late TextEditingController _messageController;
  late FocusNode _focusNode;
  InfoPopupController? _searchPopupController;

  @override
  void initState() {
    _searchController = TextEditingController();
    _messageController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _messageController.dispose();
    _focusNode.dispose();
    _searchPopupController?.dismissInfoPopup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RSMPushUserCubit, RSMPushUserState>(
      listener: (context, state) {
        if (state.sendPushStatus.isSuccess) {
          _messageController.clear();
          DialogProvider.instance.showMascotDialog(
            context: context,
            asset: "ic_mtrade_mascot_success",
            title: "Gửi thông báo thành công",
            message:
            'MFast sẽ gửi thông báo lần lượt đến CTV trong danh sách. Quá trình này sẽ mất vài phút để hoàn thành.',
            barrierDismissible: false,
            titleColor: UIColors.accentGreen,
            messageAlign: TextAlign.center,
            positiveTitle: "Về trang CTV",
            positiveCallback: () {
              context.router.pop();
            },
            negativeTitle: "Lịch sử gửi",
            negativeCallback: () {
              eventBus.fire(const ChangeRSMPushTab(1));
            },
          );
        } else if (state.sendPushStatus.isFailure) {
          DialogProvider.instance.showMascotDialog(
            context: context,
            asset: 'ic_mtrade_mascot_error',
            titleColor: UIColors.red,
            messageColor: UIColors.defaultText,
            enableAutoPop: true,
            title: "Gửi thông báo thất bại",
            message: state.errMsg,
            messageAlign: TextAlign.left,
            negativeTitle: 'Đã hiểu',
          );
        }
      },
      builder: (context, state) {
        final List<CollaboratorRsmPushModel> displayUser = List.from(state.users);
        displayUser.addAll(state.addedUsers);
        displayUser.removeWhere((element) => state.removedUsers.map((e) => e.id).contains(element.id));
        int total = displayUser.length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Danh sách $total CTV muốn gửi thông báo',
                style: UITextStyle.medium.copyWith(color: UIColors.lightBlack.withOpacity(0.7)),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SplashButton(
                onTap: () {
                  _showFilterBottomSheet(context);
                },
                child: FilterWidget(
                  value: 'Đã lọc ${_filterOptionCount(state)} nhóm đối tượng',
                  icon: 'ic_filter',
                  suffixIcon: 'ic_dropdown',
                  borderColor: Colors.transparent,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RSMFilterTag(
                data: _filterOption(state),
                onDeleted: (value) {},
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SplashButton(
                onTap: () {
                  _focusNode.requestFocus();
                  if (_searchPopupController?.isShowing == false) {
                    _searchPopupController?.show();
                  }
                },
                child: RSMSearchComponent(
                  onControllerCreated: (controller) {
                    _searchPopupController = controller;
                  },
                  onFocus: () {
                    _focusNode.requestFocus();
                  },
                  onRemoveUser: (user) {
                    _removeUser(user);
                  },
                  onAddUser: (user) {
                    _addUser(user);
                  },
                  onDismiss: () {
                    _searchPopupController?.dismissInfoPopup();
                  },
                  child: IgnorePointer(
                    child: UISearchTextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      contentPadding: const EdgeInsets.only(right: 10, top: 11, bottom: 11),
                      hintText: 'Tìm theo nickname, mã MFast CTV',
                      inputBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      onChanged: context.read<RSMPushUserCubit>().searchUser,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (displayUser.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 60 / 86,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 3,
                        ),
                        itemBuilder: (context, index) {
                          return RSMPushUserItem(
                              item: displayUser[index],
                              onDelete: () {
                                _removeUser(displayUser[index]);
                              });
                        },
                        itemCount: displayUser.length > 10 ? 10 : displayUser.length,
                      )
                    else
                      const EmptyWidget(
                        iconWidth: 24,
                        iconHeight: 24,
                        icon: "ic_null",
                        message: "Chưa có cộng tác viên nào được chọn",
                      ),
                    if (displayUser.length > 10)
                      SplashButton(
                        onTap: () {
                          _viewAllUser();
                        },
                        child: Text(
                          'Xem tất cả',
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
              decoration: const BoxDecoration(
                color: UIColors.blackBlue,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nội dung thông báo',
                    style: UITextStyle.regular.copyWith(
                      color: UIColors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: UIColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: UITextField(
                      controller: _messageController,
                      requiredField: false,
                      showBorder: false,
                      hintText: 'Nhập nội dung',
                      minLines: 3,
                      maxLines: 3,
                      maxLength: 1000,
                      hintTextStyle: UITextStyle.regular.copyWith(
                        fontSize: 13,
                        color: UIColors.grayText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: PrimaryButton(
                      enabled: displayUser.isNotEmpty,
                      isLoading: state.sendPushStatus.isLoading,
                      onPressed: () => context.read<RSMPushUserCubit>().sendRsmNotification(_messageController.text),
                      title: 'Gửi thông báo',
                      width: 180,
                      height: 48,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _filterOptionCount(RSMPushUserState state) {
    int count = 0;
    if (state.selectedCollaboratorRSMLevel != null) {
      count++;
    }
    if (state.selectedCollaboratorRSMTop != null) {
      count++;
    }
    if (state.selectedCollaboratorRSMStatus != null) {
      count++;
    }
    return count;
  }

  List<GeneralObject> _filterOption(RSMPushUserState state) {
    List<GeneralObject> options = [];
    if (state.selectedCollaboratorRSMLevel != null) {
      options.add(GeneralObject(
        code: state.selectedCollaboratorRSMLevel?.value.toString(),
        name: state.selectedCollaboratorRSMLevel?.focusTitle,
      ));
    }
    if (state.selectedCollaboratorRSMTop != null) {
      options.add(GeneralObject(
        code: state.selectedCollaboratorRSMTop?.value.toString(),
        name: state.selectedCollaboratorRSMTop?.title,
      ));
    }
    if (state.selectedCollaboratorRSMStatus != null) {
      if (state.selectedCollaboratorRSMStatus != null) {
        options.add(GeneralObject(
          code: state.selectedCollaboratorRSMStatus?.value,
          name: state.selectedCollaboratorRSMStatus?.label,
        ));
      }
    }
    return options;
  }

  _showFilterBottomSheet(BuildContext context) {
    BottomSheetProvider.instance
        .show(
      context,
      title: 'Đối tượng muốn gửi',
      headerColor: UIColors.whiteSmoke,
      backgroundColor: UIColors.white,
      child: BlocProvider.value(
        value: context.read<RSMPushUserCubit>(),
        child: const RSMFilterComponent(),
      ),
    )
        .then((value) {
      if (value == true) {
        context.read<RSMPushUserCubit>().applyFilter();
      } else {
        context.read<RSMPushUserCubit>().resetFilter();
      }
    });
  }

  _viewAllUser() {
    BottomSheetProvider.instance.show(
      context,
      title: 'Cộng tác viên đã chọn',
      headerColor: UIColors.whiteSmoke,
      backgroundColor: UIColors.white,
      child: BlocProvider.value(
        value: context.read<RSMPushUserCubit>(),
        child: RSMPushFullUserComponent(
          onDelete: (user) {
            _removeUser(user);
          },
        ),
      ),
    );
  }

  _removeUser(CollaboratorRsmPushModel? user) {
    context.read<RSMPushUserCubit>().removeUser(user);
    // DialogProvider.instance.show(
    //   context: context,
    //   insetPadding: EdgeInsets.zero,
    //   child: RSMPushRemoveUserComponent(
    //     user: user,
    //     onRemoveUser: () {
    //       context.read<RSMPushUserCubit>().removeUser(user);
    //     },
    //   ),
    // );
  }

  _addUser(CollaboratorRsmPushModel? user) {
    context.read<RSMPushUserCubit>().addUser(user);
  }
}
