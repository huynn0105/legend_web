import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/dialogs/dialog_view/mascot_dialog_view.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/loading.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_change_supporter/legendary_change_supporter_cubit.dart';
import 'package:legend_mfast/general_config.dart';
import 'package:legend_mfast/models/collaborator/collaborator_supporter_model.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

import '../../../../../../../common/event_bus/event_bus.dart';

class LeaveSupporterComponent extends StatelessWidget {
  const LeaveSupporterComponent({super.key, this.supporter});

  final CollaboratorSupporterModel? supporter;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LegendaryChangeSupporterCubit, LegendaryChangeSupporterState>(
      listenWhen: (pre, cur) => pre.leaveStatus != cur.leaveStatus,
      listener: (context, state) {
        if (state.leaveStatus.isSuccess) {
          eventBus.fire(RefreshSupporterEventBus());
        }
      },
      child: BlocBuilder<LegendaryChangeSupporterCubit, LegendaryChangeSupporterState>(
        builder: (context, state) {
          if (state.leaveStatus.isSuccess || state.leaveStatus.isFailure) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  MascotDialogView(
                    asset: state.leaveStatus.isSuccess ? "ic_mtrade_mascot_success" : "ic_mtrade_mascot_error",
                    title: state.leaveStatus.isSuccess ? "Bỏ người dẫn dắt thành công" : "Bỏ người dẫn dắt thất bại",
                    message: state.leaveMessage,
                    titleColor: state.leaveStatus.isSuccess ? UIColors.accentGreen : UIColors.red,
                    messageColor: UIColors.defaultText,
                    positiveTitle: "Quay lại",
                    positiveCallback: () {
                      context.popRoute();
                    },
                    messageAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return SizedBox(
            height: AppSize.instance.height * 0.75,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: UIColors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 48,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: UITextStyle.medium.copyWith(
                                      fontSize: 16,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: "Xác nhận muốn bỏ ",
                                      ),
                                      TextSpan(
                                        style: UITextStyle.semiBold.copyWith(
                                          fontSize: 16,
                                          color: UIColors.darkBlue,
                                        ),
                                        text: "'${supporter?.fullName}'",
                                      ),
                                      const TextSpan(
                                        text: " không còn là người dẫn dắt của mình",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Divider(
                                  color: UIColors.lightGray,
                                  thickness: 1,
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Những lưu ý khi bỏ người dẫn dắt",
                                  style: UITextStyle.medium.copyWith(
                                    fontSize: 16,
                                    color: UIColors.orange,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("1.", style: UITextStyle.regular),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: UITextStyle.regular,
                                          children: [
                                            const TextSpan(text: "Bạn sẽ trở thành "),
                                            TextSpan(
                                              text: "cộng tác viên tự do",
                                              style: UITextStyle.semiBold.copyWith(
                                                color: UIColors.orange,
                                              ),
                                            ),
                                            const TextSpan(text: " sau khi bỏ người dẫn dắt"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("2.", style: UITextStyle.regular),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: UITextStyle.regular,
                                          children: [
                                            const TextSpan(text: "Các cộng tác viên dưới cấp sẽ "),
                                            TextSpan(
                                              text: "không còn thuộc quyền quản lý của bạn",
                                              style: UITextStyle.semiBold.copyWith(
                                                color: UIColors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -32,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: ChatAvatar(
                                url: FirebaseDatabaseUtil.convertUrlAvatar(supporter?.avatarImage) ?? "",
                                size: 80,
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Expanded(
                                child: AppOutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  title: "Quay lại",
                                  backgroundColor: UIColors.background,
                                  textColor: UIColors.grayText,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: PrimaryButton(
                                  onPressed: () {
                                    _onLeaveSupporter(context, supporter: supporter);
                                  },
                                  title: "Bỏ người dẫn dắt",
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: state.leaveStatus.isLoading,
                  child: const LoadingWidget.withoutText(),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _onLeaveSupporter(BuildContext context, {CollaboratorSupporterModel? supporter}) {
    final cubit = context.read<LegendaryChangeSupporterCubit>();
    cubit.leaveSupporter();
  }
}
