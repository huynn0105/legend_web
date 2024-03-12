import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/divider.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/common/widgets/loading.dart';

import '../../../../user/cubit/user/user_cubit.dart';
import '../../../cubit/delete_account/delete_account_cubit.dart';

class CancelDeleteAccount extends StatelessWidget {
  const CancelDeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAccountCubit(),
      child: BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
        listener: (context, state) {
          if (state.cancelStatus == BlocStatus.success) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: AppSize.instance.height * 0.6,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state.cancelStatus.isInitial) ...[
                      const SizedBox(
                        height: 56,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: UIColors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 80,
                                ),
                                Text(
                                  "Mừng bạn trở lại - ${context.read<UserCubit>().state.userMetaData?.fullName}",
                                  style: UITextStyle.semiBold.copyWith(fontSize: 18, color: UIColors.accentGreen),
                                  textAlign: TextAlign.center,
                                ),
                                const DottedDivider(
                                  height: 12,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Xác nhận bỏ yêu cầu xóa tài khoản, tiếp tục đồng hành và tạo ra thật nhiều thu nhập cùng MFast",
                                    style: UITextStyle.regular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            top: -56,
                            child: AppImage.asset(
                              asset: "ic_mtrade_mascot_success",
                              width: 140,
                              height: 140,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      PrimaryButton(
                        width: double.infinity,
                        onPressed: () {
                          context.read<DeleteAccountCubit>().cancelDeleteAccount();
                        },
                        title: "Xác nhận",
                      ),
                    ],
                    if (state.cancelStatus.isFailure) ...[
                      const SizedBox(
                        height: 56,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: UIColors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 80,
                                ),
                                Text(
                                  "Bỏ yêu cầu huỷ tài khoản bị lỗi!",
                                  style: UITextStyle.semiBold.copyWith(fontSize: 18, color: UIColors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const DottedDivider(
                                  height: 12,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    state.errorMessage,
                                    style: UITextStyle.regular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            top: -56,
                            child: AppImage.asset(
                              asset: "ic_mtrade_mascot_success",
                              width: 140,
                              height: 140,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      PrimaryButton(
                        width: double.infinity,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        title: "Xác nhận",
                      ),
                    ],
                  ],
                ),
                Visibility(
                  visible: state.cancelStatus.isLoading,
                  child: const LoadingWidget.dark(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
