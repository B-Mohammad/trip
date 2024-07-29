import 'dart:convert';
import 'package:flutter/foundation.dart';

class FormModel {
  String groupName;
  List<String> independentVariable = [];
  List<String> days = [];

  FormModel({
    required this.groupName,
    required String variable,
    required String day,
  }) {
    independentVariable.add(variable);
    days.add(day);
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
      'independentVariable': independentVariable,
      'days': days,
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
  String toString() =>
      'FormModel(groupName: $groupName, independentVariable: $independentVariable, days: $days)';

  @override
  bool operator ==(covariant FormModel other) {
    if (identical(this, other)) return true;

    return other.groupName == groupName &&
        listEquals(other.independentVariable, independentVariable) &&
        other.days == days;
  }

  @override
  int get hashCode =>
      groupName.hashCode ^ independentVariable.hashCode ^ days.hashCode;
}
