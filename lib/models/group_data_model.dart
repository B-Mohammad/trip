import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:trip/models/independent_variable_data_model.dart';

class GroupDataModel {
  String? days;
  String? peakTime;
  String? entry;
  String? averageNumberOfPassengers;
  String? averageOfEntireGroup;
  String? personalCarShare;
  String? bikeShare;
  String? taxiShare;
  String? subwayShare;
  String? busShare;
  String? pedestrianShare;
  String? internetTaxiShare;
  String? serviceShare;
  String? averageDuration;
  String? parkingPeakPeriod;

  List<IndependentVariableDataModel> independentVariableData = [];

  GroupDataModel({
    this.days,
    this.peakTime,
    this.entry,
    this.averageNumberOfPassengers,
    this.averageOfEntireGroup,
    this.personalCarShare,
    this.bikeShare,
    this.taxiShare,
    this.subwayShare,
    this.busShare,
    this.pedestrianShare,
    this.internetTaxiShare,
    this.serviceShare,
    this.averageDuration,
    this.parkingPeakPeriod,
    required IndependentVariableDataModel? variable,
  }) {
    if (variable != null) {
      independentVariableData.add(variable);
    }
  }

  // GroupDataModel copyWith({
  //   String? days,
  //   String? peakTime,
  //   String? entry,
  //   String? averageNumberOfPassengers,
  //   String? averageOfEntireGroup,
  //   String? personalCarShare,
  //   String? bikeShare,
  //   String? taxiShare,
  //   String? subwayShare,
  //   String? busShare,
  //   String? pedestrianShare,
  //   String? internetTaxiShare,
  //   String? serviceShare,
  //   String? averageDuration,
  //   String? parkingPeakPeriod,
  //   List<IndependentVariableDataModel>? independentVariableData,
  // }) {
  //   return GroupDataModel(
  //     days: days ?? this.days,
  //     peakTime: peakTime ?? this.peakTime,
  //     entry: entry ?? this.entry,
  //     averageNumberOfPassengers:
  //         averageNumberOfPassengers ?? this.averageNumberOfPassengers,
  //     averageOfEntireGroup: averageOfEntireGroup ?? this.averageOfEntireGroup,
  //     personalCarShare: personalCarShare ?? this.personalCarShare,
  //     bikeShare: bikeShare ?? this.bikeShare,
  //     taxiShare: taxiShare ?? this.taxiShare,
  //     subwayShare: subwayShare ?? this.subwayShare,
  //     busShare: busShare ?? this.busShare,
  //     pedestrianShare: pedestrianShare ?? this.pedestrianShare,
  //     internetTaxiShare: internetTaxiShare ?? this.internetTaxiShare,
  //     serviceShare: serviceShare ?? this.serviceShare,
  //     averageDuration: averageDuration ?? this.averageDuration,
  //     parkingPeakPeriod: parkingPeakPeriod ?? this.parkingPeakPeriod,
  //     independentVariableData:
  //         independentVariableData ?? this.independentVariableData,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'days': days,
      'peakTime': peakTime,
      'entry': entry,
      'averageNumberOfPassengers': averageNumberOfPassengers,
      'averageOfEntireGroup': averageOfEntireGroup,
      'personalCarShare': personalCarShare,
      'bikeShare': bikeShare,
      'taxiShare': taxiShare,
      'subwayShare': subwayShare,
      'busShare': busShare,
      'pedestrianShare': pedestrianShare,
      'internetTaxiShare': internetTaxiShare,
      'serviceShare': serviceShare,
      'averageDuration': averageDuration,
      'parkingPeakPeriod': parkingPeakPeriod,
      'independentVariableData':
          independentVariableData.map((x) => x.toMap()).toList(),
    };
  }

  // factory GroupDataModel.fromMap(Map<String, dynamic> map) {
  //   return GroupDataModel(
  //     days: map['days'] != null ? map['days'] as String : null,
  //     peakTime: map['peakTime'] != null ? map['peakTime'] as String : null,
  //     entry: map['entry'] != null ? map['entry'] as String : null,
  //     averageNumberOfPassengers: map['averageNumberOfPassengers'] != null
  //         ? map['averageNumberOfPassengers'] as String
  //         : null,
  //     averageOfEntireGroup: map['averageOfEntireGroup'] != null
  //         ? map['averageOfEntireGroup'] as String
  //         : null,
  //     personalCarShare: map['personalCarShare'] != null
  //         ? map['personalCarShare'] as String
  //         : null,
  //     bikeShare: map['bikeShare'] != null ? map['bikeShare'] as String : null,
  //     taxiShare: map['taxiShare'] != null ? map['taxiShare'] as String : null,
  //     subwayShare:
  //         map['subwayShare'] != null ? map['subwayShare'] as String : null,
  //     busShare: map['busShare'] != null ? map['busShare'] as String : null,
  //     pedestrianShare: map['pedestrianShare'] != null
  //         ? map['pedestrianShare'] as String
  //         : null,
  //     internetTaxiShare: map['internetTaxiShare'] != null
  //         ? map['internetTaxiShare'] as String
  //         : null,
  //     serviceShare:
  //         map['serviceShare'] != null ? map['serviceShare'] as String : null,
  //     averageDuration: map['averageDuration'] != null
  //         ? map['averageDuration'] as String
  //         : null,
  //     parkingPeakPeriod: map['parkingPeakPeriod'] != null
  //         ? map['parkingPeakPeriod'] as String
  //         : null,
  //     independentVariableData: List<IndependentVariableDataModel>.from(
  //       (map['independentVariableData'] as List<int>)
  //           .map<IndependentVariableDataModel>(
  //         (x) =>
  //             IndependentVariableDataModel.fromMap(x as Map<String, dynamic>),
  //       ),
  //     ),
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory GroupDataModel.fromJson(String source) =>
  //     GroupDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupDataModel(days: $days, peakTime: $peakTime, entry: $entry, averageNumberOfPassengers: $averageNumberOfPassengers, averageOfEntireGroup: $averageOfEntireGroup, personalCarShare: $personalCarShare, bikeShare: $bikeShare, taxiShare: $taxiShare, subwayShare: $subwayShare, busShare: $busShare, pedestrianShare: $pedestrianShare, internetTaxiShare: $internetTaxiShare, serviceShare: $serviceShare, averageDuration: $averageDuration, parkingPeakPeriod: $parkingPeakPeriod, independentVariableData: $independentVariableData)';
  }

  @override
  bool operator ==(covariant GroupDataModel other) {
    if (identical(this, other)) return true;

    return other.days == days &&
        other.peakTime == peakTime &&
        other.entry == entry &&
        other.averageNumberOfPassengers == averageNumberOfPassengers &&
        other.averageOfEntireGroup == averageOfEntireGroup &&
        other.personalCarShare == personalCarShare &&
        other.bikeShare == bikeShare &&
        other.taxiShare == taxiShare &&
        other.subwayShare == subwayShare &&
        other.busShare == busShare &&
        other.pedestrianShare == pedestrianShare &&
        other.internetTaxiShare == internetTaxiShare &&
        other.serviceShare == serviceShare &&
        other.averageDuration == averageDuration &&
        other.parkingPeakPeriod == parkingPeakPeriod &&
        listEquals(other.independentVariableData, independentVariableData);
  }

  @override
  int get hashCode {
    return days.hashCode ^
        peakTime.hashCode ^
        entry.hashCode ^
        averageNumberOfPassengers.hashCode ^
        averageOfEntireGroup.hashCode ^
        personalCarShare.hashCode ^
        bikeShare.hashCode ^
        taxiShare.hashCode ^
        subwayShare.hashCode ^
        busShare.hashCode ^
        pedestrianShare.hashCode ^
        internetTaxiShare.hashCode ^
        serviceShare.hashCode ^
        averageDuration.hashCode ^
        parkingPeakPeriod.hashCode ^
        independentVariableData.hashCode;
  }
}
