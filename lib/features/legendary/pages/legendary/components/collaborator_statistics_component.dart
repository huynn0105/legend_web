import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/enum/legendary/legendary_overview_content.dart';
import 'package:legend_mfast/common/global_function.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/format_util.dart';
import 'package:legend_mfast/common/utils/legendary_util.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_collaborator/legendary_collaborator_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/components/collaborator_info_component.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

import '../../../../../common/widgets/avatar_widget.dart';
import '../../../../../common/widgets/concave_layout.dart';
import '../../../../../common/widgets/images.dart';
import '../../../../../widgets/column_summary_widget.dart';
import '../../../../../widgets/row_summary_widget.dart';
import '../../../cubit/legendary_hier_user_info/legendary_hier_user_info_cubit.dart';
import 'countdown_delete_account_component.dart';
import 'legendary_title_component.dart';

class CollaboratorStatisticsComponent extends StatelessWidget {
  const CollaboratorStatisticsComponent({
    Key? key,
    required this.userID,
    required this.isMyLegendaryHier,
    this.onBack,
    this.onMore,
    this.onAvatar,
    this.onChartAutoScroll,
    this.isMoreEnable = true,
  }) : super(key: key);

  final String? userID;
  final bool isMyLegendaryHier;
  final Function()? onBack;
  final Function()? onMore;
  final Function()? onAvatar;
  final Function(LegendaryOverviewContent)? onChartAutoScroll;
  final bool isMoreEnable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegendaryHierUserInfoCubit, LegendaryHierUserInfoState>(
      builder: (context, state) {
        if (state.status.isSuccess && context.read<LegendaryCollaboratorCubit>().state.status.isInitial) {
          context.read<LegendaryCollaboratorCubit>().fetchData(rank: state.data?.rank?.level?.level);
        }
        final cubit = context.read<LegendaryHierUserInfoCubit>();
        if (state.status.isInitial && !isMyLegendaryHier) {
          cubit
            ..updatePayloadUserID(userID: userID)
            ..fetchData();
        }

        final point = FormatUtil.doubleFormat(state.data?.point?.round().toDouble());
        final commission = FormatUtil.doubleFormat(state.data?.commission);
        final collaborator = FormatUtil.doubleFormat(state.data?.collaborator?.toDouble());
        final rankLabel = LegendaryUtil.getLegendaryRankByTitle(state.data?.rank?.level?.title ?? '');
        final data = state.data;
        final user = data?.user;
        final referalUsers = data?.line ?? [];

        final hierUserLevel = state.data?.rank?.level?.level;
        final hierUserGender = state.data?.user?.sex;
        final asset = GlobalFunction.getRankingMascotAssetImage(hierUserGender, hierUserLevel, isHeadAsset: false);

        ///
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              AppImage.asset(
                asset: asset,
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
              const Positioned(
                top: 108,
                left: 0,
                right: 0,
                child: ConcaveLayout(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 156,
                    ),
                    if (!isMyLegendaryHier) ...[
                      Text(
                        user?.fullName ?? '',
                        style: UITextStyle.semiBold.copyWith(
                          fontSize: 18,
                          color: UIColors.defaultText,
                        ),
                      ),
                    ],
                    const SizedBox(
                      height: 6,
                    ),
                    LegendaryTitleComponent(
                      title: rankLabel.title ?? '',
                      star: rankLabel.star ?? 0,
                    ),
                    if (!isMyLegendaryHier) ...[
                      const SizedBox(
                        height: 6,
                      ),
                      CollaboratorInfoComponent(
                        collaboratorID: userID ?? '',
                        collaboratorPhone: user?.mobilePhone ?? '',
                        level: data?.initLevel ?? 0,
                        referalUsers: referalUsers,
                      ),
                    ],
                    const SizedBox(
                      height: 16,
                    ),
                    if (!isMyLegendaryHier && state.data?.requestDelete == true) ...[
                      CountdownDeleteAccountComponent(
                        dateString: state.data?.requestDeleteDate,
                        reason: state.data?.requestReason,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: AppSplashButton(
                            onTap: () {
                              onChartAutoScroll?.call(LegendaryOverviewContent.experience);
                            },
                            child: ColumnSummaryWidget(
                              title: 'Kinh nghiệm tạm tính',
                              value: '$point điểm',
                              backgroundColor: UIColors.purple,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: AppSplashButton(
                            onTap: () {
                              onChartAutoScroll?.call(LegendaryOverviewContent.income);
                            },
                            child: ColumnSummaryWidget(
                              title: 'Tổng thu nhập',
                              value: '$commission đ',
                              backgroundColor: UIColors.extraGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppSplashButton(
                      onTap: () {
                        onChartAutoScroll?.call(LegendaryOverviewContent.collaborator);
                      },
                      child: RowSummaryWidget(
                        title: 'Cộng tác viên trong 6 tầng',
                        value: '$collaborator người',
                        backgroundColor: UIColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  if (isMyLegendaryHier)
                    SplashButton(
                      onTap: onAvatar,
                      borderRadius: BorderRadius.circular(24),
                      child: AvatarWidget(
                        url: FirebaseDatabaseUtil.convertUrlAvatar(user?.avatarImage),
                        size: 48,
                      ),
                    ),
                  if (!isMyLegendaryHier)
                    SplashButton(
                      onTap: onBack,
                      borderRadius: BorderRadius.circular(24),
                      child: const AppImage.asset(
                        asset: "ic_legendary_back",
                        height: 48,
                        width: 48,
                      ),
                    ),
                  const Spacer(),
                  if (!isMyLegendaryHier)
                    SplashButton(
                      onTap: onAvatar,
                      borderRadius: BorderRadius.circular(24),
                      child: AvatarWidget(
                        url: FirebaseDatabaseUtil.convertUrlAvatar(user?.avatarImage),
                        size: 48,
                      ),
                    ),
                  if (isMyLegendaryHier)
                    SplashButton(
                      onTap: onMore,
                      isDisabled: !isMoreEnable,
                      borderRadius: BorderRadius.circular(24),
                      child: AppImage.asset(
                        asset: isMoreEnable ? "ic_legendary_more_menu" : "ic_legendary_more_menu_disable",
                        height: 48,
                        width: 48,
                      ),
                    ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
