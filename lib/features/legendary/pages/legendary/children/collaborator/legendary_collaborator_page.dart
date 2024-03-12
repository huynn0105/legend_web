import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/event_bus/event_bus.dart';
import 'package:legend_mfast/common/widgets/empty_widget.dart';
import 'package:legend_mfast/common/widgets/loading.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_collaborator/legendary_collaborator_cubit.dart';
import 'package:legend_mfast/general_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../common/widgets/loadmore_widget.dart';
import '../../items/collaborator_item.dart';
import 'components/collaborator_filters_component.dart';
import 'components/collaborator_need_to_care_component.dart';

@RoutePage()
class LegendaryCollaboratorPage extends StatelessWidget {
  const LegendaryCollaboratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _LegendaryCollaboratorPageImpl();
  }
}

class _LegendaryCollaboratorPageImpl extends StatefulWidget {
  const _LegendaryCollaboratorPageImpl();

  @override
  State<_LegendaryCollaboratorPageImpl> createState() => _LegendaryCollaboratorPageImplState();
}

class _LegendaryCollaboratorPageImplState extends State<_LegendaryCollaboratorPageImpl> {
  late final RefreshController refreshController;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    refreshController = RefreshController();
    _subscription = eventBus.on().listen(_handleEvent);
    super.initState();
  }

  _handleEvent(event) {
    if (event is RemoveCollaboratorEventBus) {
      refreshController.resetNoData();
      context.read<LegendaryCollaboratorCubit>().fetchData();
    }
  }

  @override
  void dispose() {
    refreshController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LegendaryCollaboratorCubit, LegendaryCollaboratorState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          refreshController.resetNoData();
        }
      },
      builder: (context, state) {
        return LoadMoreWidget(
          refreshController: refreshController,
          onLoadMore: () {
            return _onLoadMore(context);
          },
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: CollaboratorNeedToCareComponent(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
              const SliverToBoxAdapter(
                child: CollaboratorFiltersComponent(),
              ),
              if (state.status.isInitial || state.status.isLoading)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: LoadingWidget(),
                  ),
                )
              else if (state.data.isEmpty)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: EmptyWidget(
                      message: 'Không tìm thấy cộng tác viên nào',
                      icon: 'ic_null',
                      iconWidth: 24,
                      iconHeight: 24,
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) {
                        final int itemIndex = index ~/ 2;
                        if (index.isEven) {
                          return CollaboratorItem(
                            collaborator: state.data[itemIndex],
                          );
                        }
                        return const SizedBox(
                          height: 12,
                        );
                      },
                      semanticIndexCallback: (Widget widget, int localIndex) {
                        if (localIndex.isEven) {
                          return localIndex ~/ 2;
                        }
                        return null;
                      },
                      childCount: state.data.length * 2 - 1,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  _onLoadMore(BuildContext context) {
    final cubit = context.read<LegendaryCollaboratorCubit>();
    return cubit.loadmoreData();
  }
}
