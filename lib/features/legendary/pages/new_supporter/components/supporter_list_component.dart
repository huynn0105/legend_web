import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/bottom_sheet/bottom_sheet_provider.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/empty_widget.dart';
import 'package:legend_mfast/common/widgets/loading.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_review/legendary_review_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/new_supporter/new_supporter_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/new_supporter_list/new_supporter_list_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/new_supporter/components/supporter_review_component.dart';
import 'package:legend_mfast/features/legendary/pages/new_supporter/items/supporter_item.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_supporter_by_filter_payload.dart';

class SupporterListComponent extends StatelessWidget {
  const SupporterListComponent({
    super.key,
    this.group,
    this.text,
    this.provinceID,
    this.districtID,
  });

  final String? group;
  final String? text;
  final String? provinceID;
  final String? districtID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => NewSupporterListCubit()),
      child: _SupporterListComponent(
        group: group,
        text: text,
        provinceID: provinceID,
        districtID: districtID,
      ),
    );
  }
}

class _SupporterListComponent extends StatefulWidget {
  const _SupporterListComponent({
    this.group,
    this.text,
    this.provinceID,
    this.districtID,
  });

  final String? group;
  final String? text;
  final String? provinceID;
  final String? districtID;

  @override
  State<_SupporterListComponent> createState() => _SupporterListComponentState();
}

class _SupporterListComponentState extends State<_SupporterListComponent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onGetData(context);
    });
  }

  @override
  void didUpdateWidget(_SupporterListComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.districtID != widget.districtID ||
        oldWidget.group != widget.group ||
        oldWidget.provinceID != widget.provinceID ||
        oldWidget.text != widget.text) {
      _onGetData(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewSupporterCubit, NewSupporterState>(
      builder: (context, supporterState) {
        final supporterSelect = supporterState.supporterSelect;
        return BlocBuilder<NewSupporterListCubit, NewSupporterListState>(
          builder: (context, state) {
            if (!isValidPayload()) return const SizedBox();

            if (state.status.isLoading) {
              return Container(
                height: 104,
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const LoadingWidget.withoutText(),
              );
            } else if (state.supporters.isEmpty) {
              return Container(
                height: 104,
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const EmptyWidget(
                  iconWidth: 24,
                  iconHeight: 24,
                  icon: "ic_null",
                  message: "Không tìm thấy người dẫn dắt",
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: UIColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  ...List.generate(state.supporters.length, (index) {
                    final item = state.supporters[index];
                    final isSelected = supporterSelect?.toUserID == item.toUserID;

                    return SupporterItem(
                      item: item,
                      isSelected: isSelected,
                      onSelect: () {
                        _onSelectSupporter(context, item: item);
                      },
                      onTap: () {
                        _onOpenUserReview(context, item: item, isSelected: isSelected);
                      },
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _onSelectSupporter(BuildContext context, {required LegendaryNewSupporterModel item}) {
    final cubit = context.read<NewSupporterCubit>();
    cubit.selectSupporter(data: item);
  }

  _onOpenUserReview(BuildContext context, {required LegendaryNewSupporterModel item, required bool isSelected}) {
    bool isNewSelect = isSelected;
    BottomSheetProvider.instance
        .show(
      context,
      title: "Thông tin người dẫn dắt",
      child: BlocProvider(
        create: (context) => LegendaryReviewCubit(),
        child: SupporterReviewComponent(
          user: item,
          isSelected: isSelected,
          onChangeSelected: (value) {
            isNewSelect = value;
          },
        ),
      ),
    )
        .then((_) {
      if (isNewSelect != isSelected) {
        final cubit = context.read<NewSupporterCubit>();
        cubit.selectSupporter(data: item);
      }
    });
  }

  _onGetData(BuildContext context) {
    if (!isValidPayload()) return;

    final cubit = context.read<NewSupporterListCubit>();

    cubit.payload = LegendarySupporterByFilterPayload(
      districtID: widget.districtID,
      provinceID: widget.provinceID,
      group: widget.group,
      text: widget.text,
    );

    cubit.getSupporterByFilter();
  }

  bool isValidPayload() {
    return TextUtils.isNotEmpty(widget.districtID) ||
        TextUtils.isNotEmpty(widget.provinceID) ||
        TextUtils.isNotEmpty(widget.group) ||
        TextUtils.isNotEmpty(widget.text);
  }
}
