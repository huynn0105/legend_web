import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/constants.dart';
import 'package:legend_mfast/common/enum/collaborator/collaborator_status.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/features/legendary/cubit/collaborator_need_to_care/collaborator_need_to_care_cubit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../../common/widgets/buttons.dart';
import '../../../../../models/general_object.dart';

class TabSelectComponent extends StatelessWidget {
  const TabSelectComponent({
    super.key,
    required this.tabController,
    required this.onSelectedTab,
  });

  final AutoScrollController tabController;
  final Function(int) onSelectedTab;

  @override
  Widget build(BuildContext context) {

    final List<GeneralObject> data = CollaboratorStatus.values
        .where((e) => AppConstants.visibleCollaboratorCanRemove || e != CollaboratorStatus.can_remove)
        .map((e) => GeneralObject(code: e.name, name: e.title))
        .toList();
        
    return BlocBuilder<CollaboratorNeedToCareCubit, CollaboratorNeedToCareState>(
      builder: (context, state) {
        return SizedBox(
          height: 60,
          child: ListView.separated(
            controller: tabController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final item = data[index];
              final isSelected = item.code == state.selectedTab?.code;
              return SplashButton(
                onTap: () {
                  int tabIndex = 0;
                  if (item.code == CollaboratorStatus.working.name) {
                    tabIndex = CollaboratorStatus.working.index;
                  }
                  if (item.code == CollaboratorStatus.follow.name) {
                    tabIndex = CollaboratorStatus.follow.index;
                  }
                  if (item.code == CollaboratorStatus.can_leave.name) {
                    tabIndex = CollaboratorStatus.can_leave.index;
                  }
                  if (item.code == CollaboratorStatus.can_remove.name) {
                    tabIndex = CollaboratorStatus.can_remove.index;
                  }
                  if (item.code == CollaboratorStatus.departed.name) {
                    tabIndex = CollaboratorStatus.departed.index;
                  }
                  onSelectedTab.call(tabIndex);
                  _selectTab(context.read<CollaboratorNeedToCareCubit>(), item);
                },
                child: AutoScrollTag(
                  controller: tabController,
                  key: ValueKey(index),
                  index: index,
                  child: TabSelectItem(item: item, isSelected: isSelected),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 8,
              );
            },
            itemCount: data.length,
          ),
        );
      },
    );
  }

  _selectTab(CollaboratorNeedToCareCubit cubit, GeneralObject? tab) async {
    if (tab?.code == cubit.state.selectedTab?.code) return;
    cubit.selectTabOption(tab!);
  }
}

class TabSelectItem extends StatelessWidget {
  const TabSelectItem({
    super.key,
    required this.item,
    this.isSelected = false,
  });

  final GeneralObject item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Chip(
          label: Text(
            item.name ?? '',
            style: isSelected
                ? UITextStyle.medium.copyWith(
                    color: UIColors.white,
                  )
                : UITextStyle.regular.copyWith(
                    color: UIColors.grayText,
                  ),
          ),
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 7, top: 5),
          backgroundColor: isSelected ? UIColors.primaryColor : UIColors.white,
        ),
        if (isSelected)
          const AppImage.asset(
            asset: 'ic_arrow_shape',
            width: 48,
            height: 12,
          )
      ],
    );
  }
}
