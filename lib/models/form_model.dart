import 'dart:convert';
import 'package:trip/models/group_data_model.dart';

class GroupModel {
  String groupName;
  List<GroupDataModel> groupDayData = [];

  GroupModel({
    required this.groupName,
    required GroupDataModel day,
  }) {
    groupDayData.add(day);
  }

  // FormModel copyWith({
  //   String? groupName,
  //   List<String>? independentVariable,
  //   String? day,
  // }) {
  //   return FormModel(
  //     groupName: groupName ?? this.groupName,
  //     independentVariable: independentVariable ?? this.independentVariable,
  //     day: day ?? this.day,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupName': groupName,
      // 'independentVariable': independentVariableData,
      'days': groupDayData,
    };
  }

  // factory FormModel.fromMap(Map<String, dynamic> map) {
  //   return FormModel(
  //     groupName: map['groupName'] as String,
  //     independentVariable:
  //         List<String>.from((map['independentVariable'] as List<String>)),
  //     day: map['day'] as String,
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory FormModel.fromJson(String source) =>
  //     FormModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FormModel(groupName: $groupName, days: $groupDayData)';

  @override
  bool operator ==(covariant GroupModel other) {
    if (identical(this, other)) return true;

    return other.groupName == groupName && other.groupDayData == groupDayData;
  }

  @override
  int get hashCode => groupName.hashCode ^ groupDayData.hashCode;
}
