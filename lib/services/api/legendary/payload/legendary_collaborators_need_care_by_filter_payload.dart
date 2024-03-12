
import '../../../../common/enum/collaborator/collaborator_status.dart';

class LegendaryCollaboratorsNeedCareByFilterPayload {
  const LegendaryCollaboratorsNeedCareByFilterPayload({
    this.level,
    this.grade,
    this.type,
    this.page = 1,
  });

  final List<String>? level;
  final List<String>? grade;
  final String? type;
  final int page;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (type != CollaboratorStatus.working.name && type != CollaboratorStatus.can_remove.name) map['level'] = level;
    if (type != CollaboratorStatus.working.name && type != CollaboratorStatus.can_remove.name) map['grade'] = grade;
    map['type'] = type;
    map['page'] = page;
    return map;
  }

  LegendaryCollaboratorsNeedCareByFilterPayload copyWith({
    List<String>? level,
    List<String>? grade,
    String? type,
    int? page,
  }) {
    return LegendaryCollaboratorsNeedCareByFilterPayload(
      level: level ?? this.level,
      grade: grade ?? this.grade,
      type: type ?? this.type,
      page: page ?? this.page,
    );
  }
}
