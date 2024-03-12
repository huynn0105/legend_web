import 'package:auto_route/auto_route.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/models/general_object.dart';
import 'package:legend_mfast/routes/routes.gr.dart';

import '../../../../../../../common/bottom_sheet/bottom_sheet_provider.dart';
import '../../../../../../../common/colors.dart';
import '../../../../../../../common/styles.dart';
import '../../../../../../../common/widgets/images.dart';
import '../../../../../../../common/widgets/textfields.dart';
import '../../../../../../../widgets/filter_widget.dart';
import '../../../../../cubit/legendary_collaborator/legendary_collaborator_cubit.dart';

class CollaboratorFiltersComponent extends StatefulWidget {
  const CollaboratorFiltersComponent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CollaboratorFiltersComponentState();
  }
}

class _CollaboratorFiltersComponentState extends State<CollaboratorFiltersComponent> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegendaryCollaboratorCubit, LegendaryCollaboratorState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Danh sách cộng tác viên",
                  style: UITextStyle.semiBold.copyWith(
                    fontSize: 18,
                    color: UIColors.lightBlack,
                  ),
                ),
                const Spacer(),
                SplashButton(
                  onTap: () {
                    _showSortBottomSheet(state);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Sắp xếp",
                        style: UITextStyle.regular.copyWith(
                          fontSize: 13,
                          color: UIColors.grayText,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const AppImage.asset(
                        asset: "ic_sort",
                        width: 24,
                        height: 24,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            UISearchTextField(
              controller: _searchController,
              contentPadding: const EdgeInsets.only(right: 10, top: 9, bottom: 9),
              hintText: 'Tìm theo Nickname hoặc số điện thoại',
              onChanged: context.read<LegendaryCollaboratorCubit>().searchCollaborator,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: SplashButton(
                    onTap: () {
                      _showLevelBottomSheet(
                        context: context,
                        selectedData: state.selectedLevels,
                        data: state.collaboratorFilter?.level ?? [],
                      );
                    },
                    child: FilterWidget(
                      value: _getLevelDisplay(state),
                      hint: 'Cấp CTV',
                      icon: 'ic_filter',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: SplashButton(
                    onTap: () {
                      _showWorkBottomSheet(state);
                    },
                    child: FilterWidget(
                      value: state.selectedWork?.name ?? '',
                      icon: 'ic_filter',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            if (state.userPending != null && state.userPending != 0)
              CollaboratorPendingButton(
                userPending: state.userPending!,
              ),
            SizedBox(
              height: 32,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  GeneralObject? item = state.collaboratorFilter?.tabs?[index];
                  return SplashButton(
                    onTap: () {
                      _selectTab(context.read<LegendaryCollaboratorCubit>(), item);
                    },
                    child: Chip(
                      label: Text(
                        item?.name ?? '',
                        style: item?.code == state.selectedTab?.code
                            ? UITextStyle.medium.copyWith(
                                color: UIColors.white,
                              )
                            : UITextStyle.regular.copyWith(
                                color: UIColors.grayText,
                              ),
                      ),
                      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 7, top: 5),
                      backgroundColor: item?.code == state.selectedTab?.code ? UIColors.primaryColor : UIColors.white,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 8,
                  );
                },
                itemCount: state.collaboratorFilter?.tabs?.length ?? 0,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        );
      },
    );
  }

  String? _getLevelDisplay(LegendaryCollaboratorState state) {
    if (state.selectedLevels.isEmpty) {
      return null;
    }
    if (state.selectedLevels.length == state.collaboratorFilter?.level?.length) {
      return 'Tất cả tầng CTV';
    }
    List<String> levels = state.selectedLevels.map((e) => e.code ?? '').toList();

    levels.sort((a, b) => a.compareTo(b));
    return 'Tầng ${levels.join(', ')}';
  }

  _showSortBottomSheet(LegendaryCollaboratorState state) async {
    final result = await BottomSheetProvider.instance.showCupertinoWrapperPicker(
      context,
      title: 'Thứ tự hiển thị CTV',
      data: state.collaboratorFilter?.sort?.map((e) => DataWrapper(id: e.code, value: e.name)).toList() ?? [],
      selectedItem: DataWrapper(id: state.selectedSort?.code, value: state.selectedSort?.name),
    );
    if (result != null && context.mounted) {
      context.read<LegendaryCollaboratorCubit>().selectSortOption(GeneralObject(code: result.id, name: result.value));
    }
  }

  _showWorkBottomSheet(LegendaryCollaboratorState state) async {
    final result = await BottomSheetProvider.instance.showCupertinoWrapperPicker(
      context,
      title: 'Hoạt động bán hàng',
      data: state.collaboratorFilter?.work?.map((e) => DataWrapper(id: e.code, value: e.name)).toList() ?? [],
      selectedItem: DataWrapper(id: state.selectedWork?.code, value: state.selectedWork?.name),
    );
    if (result != null && context.mounted) {
      context.read<LegendaryCollaboratorCubit>().selectWorkOption(GeneralObject(code: result.id, name: result.value));
    }
  }

  _selectTab(LegendaryCollaboratorCubit cubit, GeneralObject? tab) async {
    if (tab?.code == cubit.state.selectedTab?.code) return;
    cubit.selectTabOption(tab!);
  }

  _showLevelBottomSheet({
    required BuildContext context,
    required List<GeneralObject> selectedData,
    required List<GeneralObject> data,
  }) async {
    final result = await BottomSheetProvider.instance.showLevelBottomSheet(
      context,
      selectData: selectedData,
      data: data,
    );
    if (context.mounted && result != null && result is List<GeneralObject>) {
      context.read<LegendaryCollaboratorCubit>().selectLevelOptions(result);
    }
  }
}

class CollaboratorPendingButton extends StatelessWidget {
  const CollaboratorPendingButton({
    super.key,
    required this.userPending,
  });

  final int userPending;

  @override
  Widget build(BuildContext context) {
    return SplashButton(
      onTap: () {
        context.router.push(CollaboratorPendingRoute(
            userPending: userPending,
            onUserPendingChange: (userPending) {
              context.read<LegendaryCollaboratorCubit>().updateCollaboratorPending(userPending);
            }));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            const AppImage.asset(
              asset: 'ic_pending_time_outline',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 6),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: 'Có '),
                  TextSpan(
                    text: '$userPending',
                    style: UITextStyle.semiBold.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const TextSpan(text: ' người muốn trở thành CTV của bạn'),
                ],
                style: UITextStyle.regular.copyWith(
                  fontSize: 13,
                  color: UIColors.grayText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
