import 'package:flutter/material.dart';
import 'package:legend_mfast/common/bottom_sheet/bottom_sheet_provider.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/count_down_util.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import 'cancel_delete_account_component.dart';

class CountdownDeleteAccountComponent extends StatefulWidget {
  const CountdownDeleteAccountComponent({
    super.key,
    this.dateString,
    this.reason,
  });

  final String? dateString;
  final String? reason;

  @override
  State<CountdownDeleteAccountComponent> createState() => _CountdownDeleteAccountComponentState();
}

class _CountdownDeleteAccountComponentState extends State<CountdownDeleteAccountComponent> {
  CountDownUtil? countDownUtil;

  @override
  void initState() {
    super.initState();
    countDownUtil = CountDownUtil(
      seconds: DateTimeUtil.getRemainSeconds(
        widget.dateString,
        format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
        isFromUtc: false,
      ),
    )..start();
    return;
  }

  @override
  void dispose() {
    countDownUtil?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (countDownUtil == null) return const SizedBox();

    return ValueListenableBuilder(
      valueListenable: countDownUtil!.result,
      builder: (BuildContext context, int value, Widget? child) {
        if (value < 0) {
          return const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            color: UIColors.lightRed,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: UIColors.red,
            ),
          ),
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppImage.asset(
                    asset: "ic_count_down",
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.reason?.isNotEmpty == true
                              ? "Tài khoản của người này sẽ được hủy sau:"
                              : "Tài khoản của bạn sẽ được hủy sau:",
                          style: UITextStyle.medium.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        if (countDownUtil?.result != null)
                          ValueListenableBuilder(
                            valueListenable: countDownUtil!.result,
                            builder: (context, value, child) {
                              return Text(
                                CountDownUtil.formatDayFormatUntilHour(value),
                                style: UITextStyle.medium.copyWith(
                                  fontSize: 16,
                                  color: UIColors.red,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              if (widget.reason?.isNotEmpty == true) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 46, bottom: 10),
                  child: Text(
                    "Lý do:    ${widget.reason}",
                    style: UITextStyle.regular,
                  ),
                )
              ] else ...[
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: UIColors.white,
                ),
                SplashButton(
                  onTap: () {
                    _onCancelDeleteAccount(context);
                  },
                  child: SizedBox(
                    height: 44,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Bỏ yêu cầu xóa tài khoản MFast",
                            style: UITextStyle.semiBold.copyWith(
                              color: UIColors.primaryColor,
                            ),
                          ),
                        ),
                        const AppImage.asset(
                          asset: "ic_arrow_right",
                          width: 20,
                          height: 20,
                          color: UIColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  _onCancelDeleteAccount(BuildContext context) {
    BottomSheetProvider.instance.show(
      context,
      title: "Bỏ yêu cầu xóa tài khoản MFast",
      child: const CancelDeleteAccount(),
    );
  }
}
