import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/features/legendary/cubit/collaborator_need_to_care/collaborator_need_to_care_cubit.dart';
import 'package:legend_mfast/models/general_object.dart';

import '../../../../../../../common/bottom_sheet/bottom_sheet_provider.dart';
import '../../../../../widgets/filter_widget.dart';

class CollaboratorNeedToCareFiltersComponent extends StatefulWidget {
  const CollaboratorNeedToCareFiltersComponent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CollaboratorNeedToCareFiltersComponentState();
  }
}

class _CollaboratorNeedToCareFiltersComponentState extends State<CollaboratorNeedToCareFiltersComponent> {
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
    return BlocBuilder<CollaboratorNeedToCareCubit, CollaboratorNeedToCareState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SplashButton(
                    onTap: () {
                      _showLevelBottomSheet(
                        context: context,
                        selectedData: state.selectedGrades,
                        data: state.collaboratorFilter?.grade ?? [],
                        isLevelSheet: false,
                      );
                    },
                    child: FilterWidget(
                      value: _getGradeDisplay(state),
                      hint: 'Lọc cấp CTV',
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
                      _showLevelBottomSheet(
                        context: context,
                        selectedData: state.selectedLevels,
                        data: state.collaboratorFilter?.level ?? [],
                        isLevelSheet: true,
                      );
                    },
                    child: FilterWidget(
                      value: _getLevelDisplay(state),
                      hint: 'Lọc danh hiệu',
                      icon: 'ic_filter',
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String? _getGradeDisplay(CollaboratorNeedToCareState state) {
    if (state.selectedGrades.isEmpty) {
      return null;
    }
    List<String> grades = state.selectedGrades.map((e) => e.code ?? '').toList();
    grades.sort((a, b) => a.compareTo(b));
    return 'Tầng ${grades.join(', ')}';
  }

  String? _getLevelDisplay(CollaboratorNeedToCareState state) {
    if (state.selectedLevels.isEmpty) {
      return null;
    }
    List<String> levels = state.selectedLevels.map((e) => e.name ?? '').toList();
    levels.sort((a, b) => a.compareTo(b));
    return levels.join(', ');
  }

  _showLevelBottomSheet({
    required BuildContext context,
    required List<GeneralObject> selectedData,
    required List<GeneralObject> data,
    required bool isLevelSheet,
  }) async {
    final result = await BottomSheetProvider.instance.showLevelBottomSheet(
      context,
      selectData: selectedData,
      data: data,
    );
    if (context.mounted && result != null && result is List<GeneralObject>) {
      if (isLevelSheet) {
        context.read<CollaboratorNeedToCareCubit>().selectLevelOptions(result);
      } else {
        context.read<CollaboratorNeedToCareCubit>().selectGradeOptions(result);
      }
    }
  }
}
