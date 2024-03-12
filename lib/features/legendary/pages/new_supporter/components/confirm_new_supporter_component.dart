import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/toast/toast_provider.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/common/widgets/loading.dart';
import 'package:legend_mfast/features/legendary/cubit/new_supporter/new_supporter_cubit.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

class ConfirmNewSupporterComponent extends StatefulWidget {
  const ConfirmNewSupporterComponent({
    super.key,
    this.supporter,
  });

  final LegendaryNewSupporterModel? supporter;

  @override
  State<ConfirmNewSupporterComponent> createState() => _ConfirmNewSupporterComponentState();
}

class _ConfirmNewSupporterComponentState extends State<ConfirmNewSupporterComponent> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewSupporterCubit, NewSupporterState>(
      listenWhen: (previous, current) => previous.changeStatus != current.changeStatus,
      listener: (context, state) {
        if (state.changeStatus.isSuccess) {
          Navigator.of(context).pop(true);
        }
        if (state.changeStatus.isFailure) {
          ToastProvider.instance.show(context: context, message: state.changeErrorMessage ?? '');
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ChatAvatar(
                      url: FirebaseDatabaseUtil.convertUrlAvatar(
                        widget.supporter?.avatarImage,
                      ),
                      size: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Bạn đang chọn ${widget.supporter?.fullName} làm người dẫn dắt của mình. Tuy nhiên, bạn cần chờ ${widget.supporter?.fullName} xác nhận điều này",
                    style: UITextStyle.medium.copyWith(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Gửi 1 lời nhắn để giới thiệu về bạn:",
                    textAlign: TextAlign.start,
                    style: UITextStyle.regular.copyWith(color: UIColors.grayText),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 90,
                    child: TextField(
                      controller: controller,
                      maxLines: 100,
                      decoration: InputDecoration(
                        fillColor: UIColors.white,
                        contentPadding: const EdgeInsets.all(12),
                        filled: true,
                        hintText: "Nhập lời nhắn",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 1,
                            color: UIColors.lightGray,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 1,
                            color: UIColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: UIColors.lightRed,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppImage.asset(
                          asset: "ic_warning_circle",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: UITextStyle.semiBold.copyWith(
                                color: UIColors.red,
                              ),
                              children: [
                                const TextSpan(text: "Khi thay đổi người dẫn dắt,"),
                                TextSpan(
                                  text: " tức chuyển qua cộng đồng mới, những người bên dưới bạn sẽ ",
                                  style: UITextStyle.regular,
                                ),
                                const TextSpan(text: "ở lại cộng đồng cũ và không còn chung nhánh với bạn nữa."),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: AppOutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          title: "Quay lại",
                          textColor: UIColors.grayText,
                          borderRadius: BorderRadius.circular(50),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () async {
                            await _onChangeSupporter(context);
                          },
                          title: "Xác nhận",
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Visibility(
              visible: state.changeStatus.isLoading,
              child: const Positioned.fill(
                child: LoadingWidget.dark(),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _onChangeSupporter(BuildContext context) async {
    final cubit = context.read<NewSupporterCubit>();
    await cubit.changeSupporter(
      toUserID: widget.supporter?.toUserID ?? "",
      note: controller.text,
    );
  }
}
