import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Repository {
  void readXcelFile() async {
    ByteData data = await rootBundle.load("assets/data/Data.xlsx");
    Uint8List bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    Excel excel = Excel.decodeBytes(bytes);

    for (var element in excel.tables.keys) {
      // debugPrint(excel.tables.length);
      // debugPrint(element);
      // debugPrint(excel.tables[element]?.maxColumns);
      // debugPrint(excel.tables[element]?.maxRows);
      for (var row in excel.tables[element]!.rows) {
        debugPrint("${row[1]?.value}");
      }
    }
  }
}
