import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bottom_sheet/bottom_sheet_provider.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/constants.dart';
import 'package:legend_mfast/common/event_bus/event_bus.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/debounce_util.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/common/widgets/appbar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/common/widgets/textfields.dart';
import 'package:legend_mfast/features/legendary/cubit/new_supporter/new_supporter_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/new_supporter/components/confirm_new_supporter_component.dart';
import 'package:legend_mfast/features/legendary/pages/new_supporter/components/supporter_list_component.dart';
import 'package:legend_mfast/features/legendary/pages/new_supporter/components/supporter_waiting_component.dart';
import 'package:legend_mfast/general_config.dart';
import 'package:legend_mfast/models/collaborator/collaborator_my_supporter_waiting_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';

import 'components/action_header.dart';

@RoutePage()
class NewSupporterPage extends StatelessWidget implements AutoRouteWrapper {
  const NewSupporterPage({
    super.key,
    this.mySupporterWaiting,
  });

  final MySupporterWaitingModel? mySupporterWaiting;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = NewSupporterCubit();
            cubit.initCubit(mySupporterWaiting);
            cubit.getProvinces();
            return cubit;
          },
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DebounceUtil debounce = DebounceUtil(milliseconds: 500);

    return Scaffold(
      body: AppLayout(
        child: Column(
          children: [
            MFastSimpleAppBar(
              title: "Chọn người dẫn dắt",
              context: context,
              actions: const [ActionHeader()],
            ),
            Expanded(
              child: BlocConsumer<NewSupporterCubit, NewSupporterState>(
                listener: (context, state) {
                  if (state.supporterWaiting?.toUserID != null) {
                    eventBus.fire(RefreshSupporterEventBus());
                  }
                },
                listenWhen: (pre, cur) => pre.supporterWaiting?.toUserID != cur.supporterSelect?.toUserID,
                builder: (context, state) {
                  if (state.supporterWaiting?.toUserID != null) {
                    return SupporterWaitingComponent(
                      supporter: state.supporterWaiting,
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: AppSize.instance.safeBottom + 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 48,
                          child: UITextFieldOutline(
                            borderRadius: 40,
                            hintText: "Tìm theo nickname hoặc mã MFast",
                            hintTextStyle: UITextStyle.medium.copyWith(fontSize: 16, height: 1.4, color: UIColors.darkGray),
                            textStyle: UITextStyle.medium.copyWith(fontSize: 16, height: 1.4),
                            textAlign: TextAlign.center,
                            contentPadding: const EdgeInsets.only(left: 48),
                            onChanged: (p0) {
                              debounce.run(() {
                                _onChangeText(context, text: p0);
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SupporterListComponent(
                          text: state.text,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Đề xuất cho bạn",
                          style: UITextStyle.medium.copyWith(
                            fontSize: 16,
                            color: UIColors.grayText,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: UIColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: UIColors.lightGray,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              ButtonFilter(
                                icon: "ic_filter_bar",
                                value: state.group?.value,
                                onTap: () {
                                  _showSortBottomSheet(context, selectedItem: state.group);
                                },
                              ),
                              const Divider(
                                thickness: 1,
                                height: 1,
                                color: UIColors.extraLightGray,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ButtonFilter(
                                      icon: "ic_location_outline",
                                      value: state.province?.value,
                                      placeholder: "Tỉnh/Thành phố",
                                      onTap: () {
                                        _showProvinceBottomSheet(
                                          context,
                                          data: state.provinces,
                                          selectedItem: state.province,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                    child: VerticalDivider(
                                      color: UIColors.lightGray,
                                      width: 12,
                                      thickness: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: ButtonFilter(
                                      value: state.district?.value,
                                      placeholder: "Quận/Huyện",
                                      onTap: () {
                                        _showDistrictBottomSheet(
                                          context,
                                          data: state.districts,
                                          selectedItem: state.district,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SupporterListComponent(
                          group: state.group?.id,
                          provinceID: state.province?.id,
                          districtID: state.district?.id,
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: AppOutlinedButton(
                                onPressed: () {
                                  context.popRoute();
                                },
                                title: "Quay lại",
                                textColor: UIColors.grayText,
                                backgroundColor: UIColors.background,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: PrimaryButton(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                enabled: state.supporterSelect?.toUserID != null,
                                onPressed: () {
                                  _showConfirmBottomSheet(
                                    context,
                                    supporter: state.supporterSelect,
                                  );
                                },
                                title: "Chọn người này",
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onChangeText(BuildContext context, {required String text}) {
    final cubit = context.read<NewSupporterCubit>();
    cubit.changeText(data: text);
  }

  _showSortBottomSheet(BuildContext context, {DataWrapper? selectedItem}) async {
    final result = await BottomSheetProvider.instance.onShowSearchList(
      context,
      title: 'Lọc TOP 20 dẫn dắt',
      data: AppConstants.defaultSkillFilters,
      selectedId: selectedItem?.id ?? "",
    );
    if (result != null && context.mounted) {
      final cubit = context.read<NewSupporterCubit>();
      cubit.selectGroup(data: result);
    }
  }

  _showProvinceBottomSheet(BuildContext context, {List<DataWrapper>? data, DataWrapper? selectedItem}) async {
    final result = await BottomSheetProvider.instance.onShowSearchList(
      context,
      title: 'Tỉnh/Thành phố',
      data: data ?? [],
      selectedId: selectedItem?.id ?? "",
    );
    if (result != null && context.mounted) {
      final cubit = context.read<NewSupporterCubit>();
      cubit.selectProvince(data: result);
    }
  }

  _showDistrictBottomSheet(BuildContext context, {List<DataWrapper>? data, DataWrapper? selectedItem}) async {
    final result = await BottomSheetProvider.instance.onShowSearchList(
      context,
      title: 'Quận/Huyện',
      data: data ?? [],
      selectedId: selectedItem?.id ?? "",
    );
    if (result != null && context.mounted) {
      final cubit = context.read<NewSupporterCubit>();
      cubit.selectDistrict(data: result);
    }
  }

  _showConfirmBottomSheet(BuildContext context, {LegendaryNewSupporterModel? supporter}) async {
    if (TextUtils.isEmpty(supporter?.toUserID)) return;

    BottomSheetProvider.instance
        .show(
      context,
      title: 'Xác nhận yêu cầu',
      child: BlocProvider.value(
        value: context.read<NewSupporterCubit>(),
        child: ConfirmNewSupporterComponent(supporter: supporter),
      ),
    )
        .then((value) {
      if (value is bool && value == true) {
        final cubit = context.read<NewSupporterCubit>();
        cubit.getSupporterWaiting();
      }
    });
  }
}

class ButtonFilter extends StatelessWidget {
  const ButtonFilter({
    super.key,
    this.icon,
    this.value,
    this.placeholder,
    this.onTap,
  });

  final String? icon;
  final String? value;
  final String? placeholder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isValue = TextUtils.isNotEmpty(value);
    return SplashButton(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            if (TextUtils.isNotEmpty(icon)) ...[
              AppImage.asset(
                asset: icon,
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 12,
              ),
            ],
            Expanded(
              child: Text(
                (isValue ? value : placeholder) ?? "Z",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.medium.copyWith(
                  color: isValue ? UIColors.boolText : UIColors.grayText,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
