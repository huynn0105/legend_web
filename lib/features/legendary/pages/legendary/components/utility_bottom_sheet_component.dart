import 'package:flutter/material.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/components/qr_code_component.dart';
import 'package:legend_mfast/models/user/referral_info_model.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/size.dart';
import '../../../../../common/styles.dart';
import '../../../../../common/widgets/widget_layout.dart';
import '../../../../../models/collaborator/collaborator_status_model.dart';
import 'list_utility_component.dart';
import 'referral_component.dart';

class UtilityBottomSheetComponent extends StatefulWidget {
  const UtilityBottomSheetComponent({
    Key? key,
    required this.referralCode,
    required this.referral,
    required this.collaboratorStatus,
    required this.useRsmPush,
  }) : super(key: key);

  final String referralCode;
  final ReferralInfoModel? referral;
  final CollaboratorStatusModel? collaboratorStatus;
  final bool? useRsmPush;

  @override
  State<UtilityBottomSheetComponent> createState() => _UtilityBottomSheetComponentState();
}

class _UtilityBottomSheetComponentState extends State<UtilityBottomSheetComponent> {
  String _title = '';
  bool _isShowQr = false;
  bool _isShowRef = false;

  @override
  void initState() {
    _title = 'Tiện ích và hỗ trợ';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final backWidget = _isShowQr || _isShowRef
        ? IconButton(
            onPressed: () {
              if (_isShowQr) {
                setState(() {
                  _isShowQr = false;
                });
              } else if (_isShowRef) {
                setState(() {
                  _isShowRef = false;
                });
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: UIColors.grayText,
              size: 20,
            ),
          )
        : const SizedBox();
    return WidgetLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 92,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: UIColors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: backWidget,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _title,
                      style: UITextStyle.medium.copyWith(
                        fontSize: 16,
                        color: UIColors.grayText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      color: UIColors.grayText,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: UIColors.background,
              ),
              child: _isShowQr
                  ? QrCodeComponent(data: widget.referral?.mfastLink ?? '')
                  : _isShowRef
                      ? ReferralComponent(
                          referralCode: widget.referralCode,
                          referral: widget.referral,
                          onGoQrCodeComponent: () {
                            setState(() {
                              _isShowQr = true;
                            });
                          })
                      : ListUtilityComponent(
                          referralCode: widget.referralCode,
                          collaboratorStatus: widget.collaboratorStatus,
                          useRsmPush: widget.useRsmPush,
                          onGoReferralComponent: () {
                            setState(() {
                              _isShowRef = true;
                            });
                          },
                        ),
            ),
          ),
          Container(
            height: AppSize.instance.safeBottom,
            color: UIColors.background,
          )
        ],
      ),
    );
  }
}
