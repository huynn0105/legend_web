
import '../../../../common/utils/text_util.dart';

class GetRsmListCollaboratorPayload {
  GetRsmListCollaboratorPayload({
    this.search,
    this.depth,
    this.ctvType,
    this.hasComm,
    this.isPl,
    this.isIns,
    this.isDaa,
    this.top,
    // this.page = 1,
  });

  String? search;
  int? depth;
  String? ctvType;
  int? hasComm;
  int? isPl;
  int? isIns;
  int? isDaa;
  int? top;
  // int page;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['search'] = search;
    map['depth'] = depth;
    if (TextUtils.isNotEmpty(ctvType)) map['ctv_type'] = ctvType;
    if (hasComm == 1) map['has_comm'] = hasComm;
    if (isPl == 1) map['is_pl'] = isPl;
    if (isIns == 1) map['is_ins'] = isIns;
    if (isDaa == 1) map['is_daa'] = isDaa;
    map['top'] = top;
    // map['page'] = page;
    return map;
  }

  GetRsmListCollaboratorPayload copyWith({
    int? depth,
    String? ctvType,
    int? hasComm,
    int? isPl,
    int? isIns,
    int? isDaa,
    int? top,
    bool? clearTop,
    // int? page,
  }) {
    return GetRsmListCollaboratorPayload(
      depth: depth ?? this.depth,
      ctvType: ctvType ?? this.ctvType,
      hasComm: hasComm ?? this.hasComm,
      isPl: isPl ?? this.isPl,
      isIns: isIns ?? this.isIns,
      isDaa: isDaa ?? this.isDaa,
      top: top ?? (clearTop == true ? null : this.top),
      // page: page ?? this.page,
    );
  }

  GetRsmListCollaboratorPayload copyWithSearch({
    String? search,
    int? depth,
    String? ctvType,
    int? hasComm,
    int? isPl,
    int? isIns,
    int? isDaa,
    int? top,
    bool? clearTop,
    int? page,
  }) {
    return GetRsmListCollaboratorPayload(
      search: search ?? this.search,
      depth: depth ?? this.depth,
      ctvType: ctvType ?? this.ctvType,
      hasComm: hasComm ?? this.hasComm,
      isPl: isPl ?? this.isPl,
      isIns: isIns ?? this.isIns,
      isDaa: isDaa ?? this.isDaa,
      top: top ?? (clearTop == true ? null : this.top),
      // page: 1,
    );
  }
}
