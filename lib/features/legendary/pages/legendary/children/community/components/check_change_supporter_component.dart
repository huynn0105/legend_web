import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/html_widget.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/common/widgets/loading.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_change_supporter/legendary_change_supporter_cubit.dart';

import '../../../../../../../common/global_function.dart';
import '../../../../../../../models/legendary/check_change_supporter_model.dart';

class CheckChangeCollaboratorComponent extends StatefulWidget {
  const CheckChangeCollaboratorComponent({super.key});

  @override
  State<CheckChangeCollaboratorComponent> createState() => _CheckChangeCollaboratorComponentState();
}

class _CheckChangeCollaboratorComponentState extends State<CheckChangeCollaboratorComponent> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<LegendaryChangeSupporterCubit>();
      cubit.checkChangeSupporter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIColors.background,
      width: double.infinity,
      height: AppSize.instance.height * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocConsumer<LegendaryChangeSupporterCubit, LegendaryChangeSupporterState>(
        listener: (context, state) {
          if (state.checkStatus.isSuccess) {
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          if (state.checkStatus.showLoading) {
            return Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                const LoadingWidget.withoutText(),
                Text(
                  "Đang kiểm tra điều kiện thay đổi người dẫn dắt, vui lòng không thoát lúc này",
                  style: UITextStyle.regular.copyWith(
                    fontSize: 16,
                    color: UIColors.grayText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }

          return Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              const AppImage.asset(
                asset: "ic_error_outline",
                width: 56,
                height: 56,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Không thỏa điều kiện thay đổi người dẫn dắt",
                style: UITextStyle.semiBold.copyWith(
                  fontSize: 16,
                  color: UIColors.red,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Bạn chỉ được bỏ hoặc thay đổi người dẫn dắt khi thoả một trong các điều kiện sau:",
                style: UITextStyle.regular.copyWith(
                  fontSize: 13,
                  color: UIColors.grayText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: UIColors.white,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            "ĐIỀU KIỆN",
                            style: UITextStyle.semiBold.copyWith(
                              fontSize: 13,
                              color: UIColors.grayText,
                            ),
                          ),
                        ),
                        Text(
                          "THỰC TẾ CỦA BẠN",
                          style: UITextStyle.semiBold.copyWith(
                            fontSize: 13,
                            color: UIColors.orange,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (state.checkData?.errorComm != null) RuleInfo(data: state.checkData!.errorComm!),
                    const Divider(
                      height: 1,
                      indent: 12,
                      endIndent: 12,
                      thickness: 1,
                      color: UIColors.lightGray,
                    ),
                    if (state.checkData?.errorApp != null) RuleInfo(data: state.checkData!.errorApp!),
                    const Divider(
                      height: 1,
                      indent: 12,
                      endIndent: 12,
                      thickness: 1,
                      color: UIColors.lightGray,
                    ),
                    if (state.checkData?.errorLogin != null) RuleInfo(data: state.checkData!.errorLogin!),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                  style: UITextStyle.regular.copyWith(
                    fontSize: 16,
                    color: UIColors.grayText,
                  ),
                  children: [
                    const TextSpan(text: "Chi tiết quy định và điều kiện, "),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _onDetailRule(context, detailLink: state.checkData?.detailLink),
                      text: "xem tại đây >>",
                      style: UITextStyle.bold.copyWith(
                        fontSize: 16,
                        color: UIColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              PrimaryButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: "Đã hiểu và quay lại",
                padding: const EdgeInsets.symmetric(horizontal: 40),
              )
            ],
          );
        },
      ),
    );
  }

  _onDetailRule(BuildContext context, {String? detailLink}) {
    if (TextUtils.isNotEmpty(detailLink)) {
      GlobalFunction.pushWebView(url: detailLink);
    }
  }
}

class RuleInfo extends StatelessWidget {
  const RuleInfo({
    super.key,
    required this.data,
  });

  final ErrorComm data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: UIColors.white,
      child: Row(
        children: [
          Expanded(
            child: HtmlWidget.raw(
              data: (data.condition ?? "").replaceAll("div", "span"),
            ),
          ),
          Text(
            "${data.currentTime.toString()} ngày",
            style: UITextStyle.bold.copyWith(
              fontSize: 13,
              color: UIColors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
