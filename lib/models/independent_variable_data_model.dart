import 'dart:convert';

class IndependentVariableDataModel {
  String? independentVariableName;
  String? minVariable;
  String? maxVariable;
  String? avgVariable;
  String? avgTripCreationRate;

  String? coefficient;
  String? constantNumber;
  String? indexOfFit;

  String? coefficientParking;
  String? constantNumberParking;
  String? indexOfFitParking;
  String? averageParkingPeakRate;
  String? queueCreationRate;

  String? comment1;
  String? comment2;

  IndependentVariableDataModel({
    required this.independentVariableName,
    required this.minVariable,
    required this.maxVariable,
    required this.avgVariable,
    required this.avgTripCreationRate,
    required this.coefficient,
    required this.constantNumber,
    required this.indexOfFit,
    required this.coefficientParking,
    required this.constantNumberParking,
    required this.indexOfFitParking,
    required this.averageParkingPeakRate,
    required this.queueCreationRate,
    required this.comment1,
    required this.comment2,
  });

  IndependentVariableDataModel copyWith({
    String? independentVariableName,
    String? minVariable,
    String? maxVariable,
    String? avgVariable,
    String? avgTripCreationRate,
    String? coefficient,
    String? constantNumber,
    String? indexOfFit,
    String? coefficientParking,
    String? constantNumberParking,
    String? indexOfFitParking,
    String? averageParkingPeakRate,
    String? queueCreationRate,
    String? comment1,
    String? comment2,
  }) {
    return IndependentVariableDataModel(
      independentVariableName:
          independentVariableName ?? this.independentVariableName,
      minVariable: minVariable ?? this.minVariable,
      maxVariable: maxVariable ?? this.maxVariable,
      avgVariable: avgVariable ?? this.avgVariable,
      avgTripCreationRate: avgTripCreationRate ?? this.avgTripCreationRate,
      coefficient: coefficient ?? this.coefficient,
      constantNumber: constantNumber ?? this.constantNumber,
      indexOfFit: indexOfFit ?? this.indexOfFit,
      coefficientParking: coefficientParking ?? this.coefficientParking,
      constantNumberParking:
          constantNumberParking ?? this.constantNumberParking,
      indexOfFitParking: indexOfFitParking ?? this.indexOfFitParking,
      averageParkingPeakRate:
          averageParkingPeakRate ?? this.averageParkingPeakRate,
      queueCreationRate: queueCreationRate ?? this.queueCreationRate,
      comment1: comment1 ?? this.comment1,
      comment2: comment2 ?? this.comment2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'independentVariableName': independentVariableName,
      'minVariable': minVariable,
      'maxVariable': maxVariable,
      'avgVariable': avgVariable,
      'avgTripCreationRate': avgTripCreationRate,
      'coefficient': coefficient,
      'constantNumber': constantNumber,
      'indexOfFit': indexOfFit,
      'coefficientParking': coefficientParking,
      'constantNumberParking': constantNumberParking,
      'indexOfFitParking': indexOfFitParking,
      'averageParkingPeakRate': averageParkingPeakRate,
      'queueCreationRate': queueCreationRate,
      'comment1': comment1,
      'comment2': comment2,
    };
  }

  factory IndependentVariableDataModel.fromMap(Map<String, dynamic> map) {
    return IndependentVariableDataModel(
      independentVariableName: map['independentVariableName'] as String,
      minVariable: map['minVariable'] as String,
      maxVariable: map['maxVariable'] as String,
      avgVariable: map['avgVariable'] as String,
      avgTripCreationRate: map['avgTripCreationRate'] as String,
      coefficient: map['coefficient'] as String,
      constantNumber: map['constantNumber'] as String,
      indexOfFit: map['indexOfFit'] as String,
      coefficientParking: map['coefficientParking'] as String,
      constantNumberParking: map['constantNumberParking'] as String,
      indexOfFitParking: map['indexOfFitParking'] as String,
      averageParkingPeakRate: map['averageParkingPeakRate'] as String,
      queueCreationRate: map['queueCreationRate'] as String,
      comment1: map['comment1'] as String,
      comment2: map['comment2'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IndependentVariableDataModel.fromJson(String source) =>
      IndependentVariableDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IndependentVariableDataModel(independentVariableName: $independentVariableName, minVariable: $minVariable, maxVariable: $maxVariable, avgVariable: $avgVariable, avgTripCreationRate: $avgTripCreationRate, coefficient: $coefficient, constantNumber: $constantNumber, indexOfFit: $indexOfFit, coefficientParking: $coefficientParking, constantNumberParking: $constantNumberParking, indexOfFitParking: $indexOfFitParking, averageParkingPeakRate: $averageParkingPeakRate, queueCreationRate: $queueCreationRate, comment1: $comment1, comment2: $comment2)';
  }

  @override
  bool operator ==(covariant IndependentVariableDataModel other) {
    if (identical(this, other)) return true;

    return other.independentVariableName == independentVariableName &&
        other.minVariable == minVariable &&
        other.maxVariable == maxVariable &&
        other.avgVariable == avgVariable &&
        other.avgTripCreationRate == avgTripCreationRate &&
        other.coefficient == coefficient &&
        other.constantNumber == constantNumber &&
        other.indexOfFit == indexOfFit &&
        other.coefficientParking == coefficientParking &&
        other.constantNumberParking == constantNumberParking &&
        other.indexOfFitParking == indexOfFitParking &&
        other.averageParkingPeakRate == averageParkingPeakRate &&
        other.queueCreationRate == queueCreationRate &&
        other.comment1 == comment1 &&
        other.comment2 == comment2;
  }

  @override
  int get hashCode {
    return independentVariableName.hashCode ^
        minVariable.hashCode ^
        maxVariable.hashCode ^
        avgVariable.hashCode ^
        avgTripCreationRate.hashCode ^
        coefficient.hashCode ^
        constantNumber.hashCode ^
        indexOfFit.hashCode ^
        coefficientParking.hashCode ^
        constantNumberParking.hashCode ^
        indexOfFitParking.hashCode ^
        averageParkingPeakRate.hashCode ^
        queueCreationRate.hashCode ^
        comment1.hashCode ^
        comment2.hashCode;
  }
}
