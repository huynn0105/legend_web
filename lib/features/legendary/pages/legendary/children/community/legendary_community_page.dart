import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/event_bus/event_bus.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/html_widget.dart';
import 'package:legend_mfast/common/widgets/loadmore_widget.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_change_supporter/legendary_change_supporter_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_review/legendary_review_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_supporter/legendary_supporter_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/community/components/user_review_list_component.dart';
import 'package:legend_mfast/general_config.dart';
import 'package:popover/popover.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../common/styles.dart';
import '../../../../../../common/widgets/images.dart';
import 'components/your_supporter_component.dart';

@RoutePage()
class LegendaryCommunityPage extends StatelessWidget implements AutoRouteWrapper {
  const LegendaryCommunityPage({
    Key? key,
    this.userID,
  }) : super(key: key);

  final String? userID;

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = LegendarySupporterCubit();
            cubit.getReviewFilter();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = LegendaryReviewCubit();
            cubit.updatePayload(
              userID: userID,
              page: 1,
              skill: UserSkill.sell.name,
            );
            cubit.getReviews();
            return cubit;
          },
        ),
        BlocProvider(
          create: ((context) => LegendaryChangeSupporterCubit()),
        ),
      ],
      child: _LegendaryCommunityPageImpl(
        userID: userID,
      ),
    );
  }
}

class _LegendaryCommunityPageImpl extends StatefulWidget {
  const _LegendaryCommunityPageImpl({
    Key? key,
    this.userID,
  }) : super(key: key);

  final String? userID;

  @override
  State<_LegendaryCommunityPageImpl> createState() => _LegendaryCommunityPageImplState();
}

class _LegendaryCommunityPageImplState extends State<_LegendaryCommunityPageImpl> {
  final RefreshController _controller = RefreshController();

  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();

    super.dispose();
  }

  @override
  void initState() {
    _subscription = eventBus.on<PersonalSettingEventBus>().listen((bus) {
      context.read<LegendarySupporterCubit>().getReviewFilter();
    });
    super.initState();
  }

  late final StreamSubscription _subscription;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegendaryReviewCubit, LegendaryReviewState>(
      builder: (context, state) {
        final cubit = context.read<LegendaryReviewCubit>();

        return LoadMoreWidget(
          refreshController: _controller,
          onLoadMore: () async {
            final length = state.reviews.length;
            await cubit.getReviews(loadMore: true);

            return length != state.reviews.length;
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Visibility(
                  visible: widget.userID == AppData.instance.userID,
                  child: const Column(
                    children: [
                      YourSupporterComponent(hasVerified: true),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Cộng đồng nghĩ gì về bạn?",
                          style: UITextStyle.semiBold.copyWith(
                            fontSize: 18,
                            color: UIColors.lightBlack,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Builder(builder: (context) {
                          return AppSplashButton(
                            onTap: () {
                              final htmlNote =
                                  context.read<LegendarySupporterCubit>().state.filters?.noteRatingUserHtml;
                              if (TextUtils.isNotEmpty(htmlNote)) {
                                showPopover(
                                  context: context,
                                  width: AppSize.instance.width * 0.85,
                                  arrowWidth: 10,
                                  arrowHeight: 10,
                                  bodyBuilder: (BuildContext context) {
                                    return Container(
                                      color: Colors.white,
                                      margin: const EdgeInsets.all(16),
                                      child: HtmlWidget(
                                        data: htmlNote!
                                            .replaceAll('div', 'span')
                                            .replaceAll('>-<', '>- <')
                                            .replaceAll('rowview', 'div'),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: AppImage.asset(
                                asset: 'ic_info_outline',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<LegendarySupporterCubit, LegendarySupporterState>(
                      builder: (context, filterState) {
                        return UserReviewListComponent(
                          isLoading: state.status.isLoading,
                          data: state.reviews,
                          tabs: filterState.filters?.tab,
                          skills: filterState.filters?.skill,
                          totalAmount: state.totalAmount,
                          totalAvg: state.totalAvg,
                          totalPercent: state.totalPercent,
                          onChangeTab: (id) {
                            _controller.resetNoData();
                            cubit.updatePayload(
                              tab: id,
                              page: 1,
                            );
                            cubit.getReviews();
                          },
                          onChangeSkill: (id) {
                            _controller.resetNoData();
                            cubit.updatePayload(
                              skill: id,
                              page: 1,
                            );
                            cubit.getReviews();
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
