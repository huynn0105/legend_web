import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/features/legendary/cubit/new_supporter/new_supporter_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/new_supporter/components/rating_component.dart';
import 'package:legend_mfast/models/collaborator/collaborator_my_supporter_waiting_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

class SupporterWaitingComponent extends StatelessWidget {
  const SupporterWaitingComponent({
    super.key,
    this.supporter,
  });

  final MySupporterWaitingModel? supporter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: AppSize.instance.safeBottom + 12,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(
            "Đã gửi yêu cầu, vui lòng chờ phản hồi từ ${supporter?.fullName}",
            style: UITextStyle.regular.copyWith(
              color: UIColors.grayText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ChatAvatar(
                        url: FirebaseDatabaseUtil.convertUrlAvatar(supporter?.avatarImage),
                        size: 80,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              (supporter?.fullName ?? ""),
                              style: UITextStyle.semiBold.copyWith(
                                fontSize: 18,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: UIColors.darkGray,
                            ),
                          ),
                          Text(
                            supporter?.title ?? "",
                            style: UITextStyle.semiBold.copyWith(
                              color: UIColors.darkBlue,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      RatingComponent(
                        star: TextUtils.parseDouble(supporter?.avgRating) ?? 0,
                        size: 20,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Chờ chấp nhận",
                            style: UITextStyle.semiBold.copyWith(
                              color: UIColors.orange,
                            ),
                          ),
                          Text(
                            ' - ${DateTimeUtil.getNumberDayBetween(supporter?.time ?? '')}',
                            style: UITextStyle.regular.copyWith(
                              color: UIColors.grayText,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: SplashButton(
                  onTap: () {
                    final cubit = context.read<NewSupporterCubit>();
                    cubit.selectSupporterWaiting(data: MySupporterWaitingModel());
                    cubit.selectSupporter(data: LegendaryNewSupporterModel());
                  },
                  child: Row(
                    children: [
                      Text(
                        "Chọn lại",
                        style: UITextStyle.regular.copyWith(
                          fontSize: 13,
                          color: UIColors.grayText,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const AppImage.asset(
                        asset: "ic_edit",
                        width: 24,
                        height: 24,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          AppOutlinedButton(
            onPressed: () {
              context.popRoute();
            },
            title: "Quay lại",
            padding: const EdgeInsets.symmetric(horizontal: 32),
            textColor: UIColors.grayText,
            backgroundColor: UIColors.background,
            borderRadius: BorderRadius.circular(40),
          ),
        ],
      ),
    );
  }

  _getRemainTime() {
    return DateTimeUtil.formatRemainSecond(
      DateTimeUtil.convertStringRemainSeconds(
            DateTime.now().toIso8601String(),
            format: DateTimeFormat.yyyy_MM_ddTHH_mm_ssSS,
            isFromUtc: false,
            isUnSignSecond: false,
          ).abs() +
          1,
      showRemainHourPerDay: true,
      showRemainHourPerHour: true,
      showRemainSecondPerMinute: true,
      showSeconds: true,
    );
  }
}
