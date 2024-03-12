import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/models/general_object.dart';

class CollaboratorStatusModel {
  CollaboratorStatusModel({
    this.data,
  });

  CollaboratorStatusModel.fromJson(Map<String, dynamic> json) {
    data = json.entries.map((e) => GeneralObject(code: e.key, value: TextUtils.parseInt(e.value))).toList();
  }

  List<GeneralObject>? data;
}
