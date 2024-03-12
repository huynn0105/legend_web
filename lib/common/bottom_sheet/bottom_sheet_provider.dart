import 'package:flutter/material.dart';
import 'package:legend_mfast/common/bottom_sheet/views/cupertino_wrapper_sheet_view.dart';
import 'package:legend_mfast/common/bottom_sheet/views/level_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/general_object.dart';

import '../colors.dart';
import 'views/bottom_sheet_view.dart';
import 'views/cupertino_sheet_view.dart';
import 'views/search_list_view.dart';
import 'wrapper/data_wrapper.dart';

class BottomSheetProvider {
  static final instance = BottomSheetProvider._();

  BottomSheetProvider._();

  Future<dynamic> show(
      BuildContext context, {
        required String title,
        required Widget child,
        bool isDismissible = true,
        bool closeOnRight = true,
        bool enabledOnDone = false,
        Color? headerColor,
        Color? backgroundColor,
        VoidCallback? onDone,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      backgroundColor: Colors.transparent,
      barrierColor: UIColors.blurBackground,
      builder: (_) {
        return BottomSheetView(
          title: title,
          closeOnRight: closeOnRight,
          isDismissible: isDismissible,
          enabledOnDone: enabledOnDone,
          onDone: onDone,
          headerColor: headerColor,
          backgroundColor: backgroundColor,
          child: child,
        );
      },
    );
  }

  Future<DataWrapper?> showCupertinoWrapperPicker(
      BuildContext context, {
        required String title,
        required List<DataWrapper> data,
        DataWrapper? selectedItem,
        bool isDismissible = true,
        bool enableDrag = true,
        bool autoScrollToIndex = false,
        int initIndex = 0,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      barrierColor: UIColors.blurBackground,
      builder: (_) {
        return CupertinoWrapperSheetView(
          title: title,
          data: data,
          selectedItem: selectedItem,
          autoScrollToIndex: autoScrollToIndex,
          initIndex: initIndex,
        );
      },
    );
  }

  // Future onShowMTradeDeliveryLocation(
  //     BuildContext context, {
  //       required String value,
  //       required LocationType type,
  //       required List<MasterDataModel> data,
  //     }) {
  //   return show(
  //     context,
  //     title: type.title,
  //     child: DeliverySupportSelectionComponent(
  //       value: value,
  //       data: data,
  //     ),
  //   );
  // }

  Future<DataWrapper?> onShowSearchList(
      BuildContext context, {
        required String title,
        required String selectedId,
        required List<DataWrapper> data,
      }) async {
    return await show(
      context,
      title: title,
      child: SearchListView(
        id: selectedId,
        data: data,
      ),
    );
  }

  // Future onShowMultiSelectSearchList(
  //     BuildContext context, {
  //       required String title,
  //       required List<String?> ids,
  //       required List<DataWrapper> data,
  //       bool enabledSearch = true,
  //     }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     enableDrag: true,
  //     backgroundColor: Colors.transparent,
  //     barrierColor: UIColors.blurBackground,
  //     builder: (_) {
  //       return MultiSelectSearchView(
  //         title: title,
  //         ids: ids,
  //         data: data,
  //         enableSearch: enabledSearch,
  //       );
  //     },
  //   );
  // }

  // Future onShowMultiSelectList(
  //     BuildContext context, {
  //       required String title,
  //       required List<DataWrapper> data,
  //       required List<DataWrapper> selectedData,
  //       bool enabledOnDone = false,
  //       bool isDisableItem = false,
  //       String allOptionTitle = 'Tất cả',
  //     }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     enableDrag: true,
  //     backgroundColor: Colors.transparent,
  //     barrierColor: UIColors.blurBackground,
  //     builder: (_) {
  //       return MultiSelectView(
  //         title: title,
  //         data: data,
  //         selectedData: selectedData,
  //         allOptionTitle: allOptionTitle,
  //         enabledOnDone: enabledOnDone,
  //         forceDisableWhenSelectAll: isDisableItem,
  //       );
  //     },
  //   );
  // }

  // Future<List<DataWrapper>?> showMultiSelectGroupSearchView(
  //     BuildContext context, {
  //       required String title,
  //       String? hintSearch,
  //       required List<String?> ids,
  //       List<DataWrapper> data = const [],
  //       List<GroupDataWrapper> groupedData = const [],
  //     }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     enableDrag: true,
  //     backgroundColor: Colors.transparent,
  //     barrierColor: UIColors.blurBackground,
  //     builder: (_) {
  //       return MultiSelectGroupSearchView(
  //         title: title,
  //         ids: ids,
  //         data: data,
  //         groupedData: groupedData,
  //         hintSearch: hintSearch,
  //       );
  //     },
  //   );
  // }

  // Future showReceiveTimeBottomSheet(
  //     BuildContext context, {
  //       required List<TimeFrameModel> data,
  //       required List<TimeFrameModel> selectData,
  //     }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     enableDrag: true,
  //     backgroundColor: Colors.transparent,
  //     barrierColor: UIColors.blurBackground,
  //     builder: (_) {
  //       return ReceiveTimeView(
  //         selectData: selectData,
  //         data: data,
  //       );
  //     },
  //   );
  // }

  Future showLevelBottomSheet(
      BuildContext context, {
        required List<GeneralObject> data,
        required List<GeneralObject> selectData,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      barrierColor: UIColors.blurBackground,
      builder: (_) {
        return LevelView(
          selectData: selectData,
          data: data,
        );
      },
    );
  }

  // showBottomSheetUserReviews(BuildContext context, {required String uid, String? fullName, String? avatarImage}) {
  //   BottomSheetProvider.instance.show(
  //     context,
  //     child: BlocProvider(
  //       create: (context) {
  //         final cubit = ChatRatingCubit();
  //         cubit.payload = cubit.payload.copyWith(userID: uid);
  //         return cubit;
  //       },
  //       child: ChatListReviewComponent(
  //         avatarImage: avatarImage,
  //         fullName: fullName,
  //       ),
  //     ),
  //     title: 'Thông tin cá nhân',
  //   );
  // }

  // Future<DateTime?> showCupertinoDatePicker(
  //     BuildContext context, {
  //       required String title,
  //       DateTime? initDate,
  //     }) {
  //   return showModalBottomSheet<DateTime?>(
  //     context: context,
  //     isDismissible: true,
  //     enableDrag: true,
  //     backgroundColor: Colors.transparent,
  //     barrierColor: UIColors.blurBackground,
  //     builder: (_) {
  //       return CupertinoDatePickerSheetView(
  //         title: title,
  //         initDate: initDate,
  //       );
  //     },
  //   );
  // }
  //
  // Future<List<DataWrapper>?> showMultiSelectList(
  //     BuildContext context, {
  //       required String title,
  //       required String allOptionTitle,
  //       required List<DataWrapper> data,
  //       required List<DataWrapper> selectedData,
  //       bool showSearchInput = false,
  //     }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     enableDrag: true,
  //     backgroundColor: Colors.transparent,
  //     barrierColor: UIColors.blurBackground,
  //     builder: (_) {
  //       return MultiSelectView(
  //         title: title,
  //         allOptionTitle: allOptionTitle,
  //         data: data,
  //         selectedData: selectedData,
  //         showSearchInput: showSearchInput,
  //       );
  //     },
  //   );
  // }
}
