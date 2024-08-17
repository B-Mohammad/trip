import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:trip/models/form_model.dart';
import 'package:trip/models/group_data_model.dart';
import 'package:trip/models/independent_variable_data_model.dart';

class Repository {
  static Future<List<GroupModel>> readExcelFile() async {
    List<GroupModel> formModel = [];

    ByteData data = await rootBundle.load("assets/data/Data.xlsx");
    Uint8List bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    Excel excel = Excel.decodeBytes(bytes);

    for (var element in excel.tables.keys) {
      // debugPrint(excel.tables.length);
      // debugPrint(element);
      // debugPrint(excel.tables[element]?.maxColumns);
      // debugPrint(excel.tables[element]?.maxRows);

      for (var row in excel.tables[element]!.rows.indexed) {
        if (row.$1 == 0) {
          continue;
        } else if (formModel.every(
            (element) => element.groupName != row.$2[1]?.value.toString())) {
          formModel.add(GroupModel(
              groupName: row.$2[1]?.value.toString() as String,
              day: GroupDataModel(
                days: row.$2[4]?.value.toString(),
                peakTime: row.$2[5]?.value.toString(),
                entry: row.$2[6]?.value.toString(),
                averageNumberOfPassengers: row.$2[16]?.value.toString(),
                averageOfEntireGroup: row.$2[17]?.value.toString(),
                personalCarShare: row.$2[18]?.value.toString(),
                bikeShare: row.$2[19]?.value.toString(),
                taxiShare: row.$2[20]?.value.toString(),
                subwayShare: row.$2[21]?.value.toString(),
                busShare: row.$2[22]?.value.toString(),
                pedestrianShare: row.$2[23]?.value.toString(),
                internetTaxiShare: row.$2[24]?.value.toString(),
                serviceShare: row.$2[25]?.value.toString(),
                averageDuration: row.$2[26]?.value.toString(),
                parkingPeakPeriod: row.$2[27]?.value.toString(),
                variable: IndependentVariableDataModel(
                    independentVariableName: row.$2[3]?.value.toString(),
                    minVariable: row.$2[7]?.value.toString(),
                    maxVariable: row.$2[8]?.value.toString(),
                    avgVariable: row.$2[9]?.value.toString(),
                    avgTripCreationRate: row.$2[11]?.value.toString(),
                    coefficient: row.$2[13]?.value.toString(),
                    constantNumber: row.$2[14]?.value.toString(),
                    indexOfFit: row.$2[15]?.value.toString(),
                    coefficientParking: row.$2[28]?.value.toString(),
                    constantNumberParking: row.$2[29]?.value.toString(),
                    indexOfFitParking: row.$2[30]?.value.toString(),
                    averageParkingPeakRate: row.$2[31]?.value.toString(),
                    queueCreationRate: row.$2[40]?.value.toString(),
                    comment1: row.$2[41]?.value.toString(),
                    comment2: row.$2[42]?.value.toString()),
              )));
        } else {
          final int index = formModel.indexWhere(
              (element) => element.groupName == row.$2[1]?.value.toString());

          if (!formModel[index]
              .groupDayData
              .map((e) => e.days)
              .contains(row.$2[4]?.value.toString())) {
            formModel[index].groupDayData.add(GroupDataModel(
                  days: row.$2[4]?.value.toString(),
                  peakTime: row.$2[5]?.value.toString(),
                  entry: row.$2[6]?.value.toString(),
                  averageNumberOfPassengers: row.$2[16]?.value.toString(),
                  averageOfEntireGroup: row.$2[17]?.value.toString(),
                  personalCarShare: row.$2[18]?.value.toString(),
                  bikeShare: row.$2[19]?.value.toString(),
                  taxiShare: row.$2[20]?.value.toString(),
                  subwayShare: row.$2[21]?.value.toString(),
                  busShare: row.$2[22]?.value.toString(),
                  pedestrianShare: row.$2[23]?.value.toString(),
                  internetTaxiShare: row.$2[24]?.value.toString(),
                  serviceShare: row.$2[25]?.value.toString(),
                  averageDuration: row.$2[26]?.value.toString(),
                  parkingPeakPeriod: row.$2[27]?.value.toString(),
                  variable: IndependentVariableDataModel(
                      independentVariableName: row.$2[3]?.value.toString(),
                      minVariable: row.$2[7]?.value.toString(),
                      maxVariable: row.$2[8]?.value.toString(),
                      avgVariable: row.$2[9]?.value.toString(),
                      avgTripCreationRate: row.$2[11]?.value.toString(),
                      coefficient: row.$2[13]?.value.toString(),
                      constantNumber: row.$2[14]?.value.toString(),
                      indexOfFit: row.$2[15]?.value.toString(),
                      coefficientParking: row.$2[28]?.value.toString(),
                      constantNumberParking: row.$2[29]?.value.toString(),
                      indexOfFitParking: row.$2[30]?.value.toString(),
                      averageParkingPeakRate: row.$2[31]?.value.toString(),
                      queueCreationRate: row.$2[40]?.value.toString(),
                      comment1: row.$2[41]?.value.toString(),
                      comment2: row.$2[42]?.value.toString()),
                ));
          } else {
            final int indexInGroup = formModel[index].groupDayData.indexWhere(
                (element) => element.days == row.$2[4]?.value.toString());

            formModel[index]
                .groupDayData[indexInGroup]
                .independentVariableData
                .add(
                  IndependentVariableDataModel(
                      independentVariableName: row.$2[3]?.value.toString(),
                      minVariable: row.$2[7]?.value.toString(),
                      maxVariable: row.$2[8]?.value.toString(),
                      avgVariable: row.$2[9]?.value.toString(),
                      avgTripCreationRate: row.$2[11]?.value.toString(),
                      coefficient: row.$2[13]?.value.toString(),
                      constantNumber: row.$2[14]?.value.toString(),
                      indexOfFit: row.$2[15]?.value.toString(),
                      coefficientParking: row.$2[28]?.value.toString(),
                      constantNumberParking: row.$2[29]?.value.toString(),
                      indexOfFitParking: row.$2[30]?.value.toString(),
                      averageParkingPeakRate: row.$2[31]?.value.toString(),
                      queueCreationRate: row.$2[40]?.value.toString(),
                      comment1: row.$2[41]?.value.toString(),
                      comment2: row.$2[42]?.value.toString()),
                );
          }
        }

        // for (var Cell in row) {

        // }
        // debugPrint("${row.$2[1]?.value}");
      }
    }
    return formModel;
  }
}
