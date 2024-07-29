import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:trip/models/form_model.dart';

class Repository {
  static Future<List<FormModel>> readExcelFile() async {
    List<FormModel> formModel = [];

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
          formModel.add(FormModel(
              groupName: row.$2[1]?.value.toString() as String,
              variable: row.$2[3]?.value.toString() as String,
              day: row.$2[4]?.value.toString() as String));
        } else {
          final int index = formModel.indexWhere(
              (element) => element.groupName == row.$2[1]?.value.toString());
          formModel[index]
              .independentVariable
              .add(row.$2[3]?.value.toString() as String);
          if (!formModel[index]
              .days
              .contains(row.$2[4]?.value.toString() as String)) {
            formModel[index].days.add(row.$2[4]?.value.toString() as String);
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
