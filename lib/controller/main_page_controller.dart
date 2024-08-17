import 'package:get/get.dart';
import 'package:trip/models/form_model.dart';
import 'package:trip/models/group_data_model.dart';
import 'package:trip/models/independent_variable_data_model.dart';
import 'package:trip/utils/repository.dart';

class MainPageController extends GetxController {
  List<GroupModel>? listGroupModel;
  List<String?> te = [];
  GroupDataModel? selectedgroup;
  bool banner = true;
  List<IndependentVariableDataModel?>? depVars;
  List<List<dynamic>> result = [];
  Map<String, dynamic> genResult = {};
  Map<String, double?> zResalt = {};
  Map<String, dynamic> comment = {};

  Future<void> getListFormModels() async {
    listGroupModel = await Repository.readExcelFile();
    // print(listGroupModel);
  }

  void getDays(String x) {
    te = listGroupModel!
        .singleWhere((element) => element.groupName == x)
        .groupDayData
        .map((e) => e.days)
        .toList();
  }

  // void OndropMenu() {}

  void setSelectedg(String day, String gname) {
    selectedgroup = listGroupModel!
        .singleWhere((element) => element.groupName == gname)
        .groupDayData
        .singleWhere((element) => element.days == day);
    // print(selectedgroup);
  }

  void calc(MapEntry<String, String> x, double zarib) {
    if (x.key.isNotEmpty && x.value.isNotEmpty) {
      final coefficient = double.tryParse(selectedgroup?.independentVariableData
          .where((element) => element.independentVariableName == x.key)
          .toList()
          .first
          .coefficient as String);
      final constantNumber = double.tryParse(selectedgroup
          ?.independentVariableData
          .where((element) => element.independentVariableName == x.key)
          .toList()
          .first
          .constantNumber as String);

      final coefficientParking = double.tryParse(selectedgroup
          ?.independentVariableData
          .where((element) => element.independentVariableName == x.key)
          .toList()
          .first
          .coefficientParking as String);
      final constantNumberParking = double.tryParse(selectedgroup
          ?.independentVariableData
          .where((element) => element.independentVariableName == x.key)
          .toList()
          .first
          .constantNumberParking as String);

      final avg = double.tryParse(selectedgroup?.independentVariableData
          .where((element) => element.independentVariableName == x.key)
          .first
          .avgTripCreationRate as String);

      final avgp = double.tryParse(selectedgroup?.independentVariableData
          .where((element) => element.independentVariableName == x.key)
          .first
          .averageParkingPeakRate as String);

      List resultTemp = [];
      resultTemp.add(x.key);
      print(coefficient);
      if (coefficient != null && constantNumber != null) {
        final temp = double.parse(x.value) * coefficient + constantNumber;
        resultTemp.add(temp.round());
      } else {
        double value;
        if (x.key.contains("زيربنا") || x.key.contains("سطح")) {
          value = double.tryParse(x.value)! / 100;
        } else {
          value = double.tryParse(x.value)!;
        }

        final temp = value * avg!;
        resultTemp.add(temp.round());
      }

      if (coefficientParking != null && constantNumberParking != null) {
        final temp = (double.parse(x.value) * coefficientParking +
                constantNumberParking) *
            zarib;
        resultTemp.add(temp.round());
      } else {
        double value;
        if (x.key.contains("زيربنا") || x.key.contains("سطح")) {
          value = double.tryParse(x.value)! / 100;
        } else {
          value = double.tryParse(x.value)!;
        }
        print("$value-++--");
        print("$avgp-++--");

        final temp = (value * avgp!) * zarib;
        resultTemp.add(temp.round());
      }
      result.add(resultTemp);

      comment.clear();
      if (selectedgroup?.independentVariableData
              .where((element) => element.independentVariableName == x.key)
              .first
              .comment1 as String !=
          "null") {
        comment["توضیحات"] = selectedgroup?.independentVariableData
            .where((element) => element.independentVariableName == x.key)
            .first
            .comment1;
      }
    }
  }

  double calcZarib(bool iwant, String pahneh,
      {double metro = 0, double bus = 0}) {
    double zarib = 1;
    if (iwant) {
      if ((metro <= 600 || bus <= 300) && pahneh == "شمالی") {
        zarib = 1.04;
      } else if ((metro > 600 || bus > 300) && pahneh == "شمالی") {
        zarib = 1.16;
      } else if ((metro <= 600 || bus <= 300) && pahneh == "جنوبی") {
        zarib = 0.84;
      } else if ((metro > 600 || bus > 300) && pahneh == "جنوبی") {
        zarib = 0.91;
      } else if ((metro <= 600 || bus <= 300) && pahneh == "مرکزی") {
        zarib = 0.6;
      } else if ((metro > 600 || bus > 300) && pahneh == "مرکزی") {
        zarib = 0.8;
      }
    }
    return zarib;
  }

  void calcdata(double zarib) {
    genResult.clear();
    if (selectedgroup?.peakTime != "null") {
      genResult["ساعت اوج سفر"] = selectedgroup?.peakTime;
    }
    if (selectedgroup?.parkingPeakPeriod != "null") {
      genResult["زمان اوج تقاضای پارکینگ"] = selectedgroup?.parkingPeakPeriod;
    }
    if (selectedgroup?.entry != "null") {
      genResult["جهت توزیع"] =
          "${selectedgroup?.entry} ورودی - ${100 - int.parse(selectedgroup?.entry as String)} خروجی";
    }
    if (selectedgroup?.averageDuration != "null") {
      genResult[" متوسط ماندگاری"] = "${selectedgroup?.averageDuration} دقیقه ";
    }
    if (selectedgroup?.averageNumberOfPassengers != "null") {
      genResult["  متوسط سرنشینان سواری"] =
          "${selectedgroup?.averageNumberOfPassengers} نفر";
    }
    if (selectedgroup?.averageOfEntireGroup != "null") {
      genResult["  متوسط گروه مراجعان"] =
          "${selectedgroup?.averageOfEntireGroup}";
    }

    zResalt.clear();

    double? bikeShare = double.tryParse(selectedgroup?.bikeShare as String);
    double? busShare = double.tryParse(selectedgroup?.busShare as String);
    double? internetTaxiShare =
        double.tryParse(selectedgroup?.internetTaxiShare as String);
    double? pedestrianShare =
        double.tryParse(selectedgroup?.pedestrianShare as String);
    double? personalCarShare =
        double.tryParse(selectedgroup?.personalCarShare as String);
    double? serviceShare =
        double.tryParse(selectedgroup?.serviceShare as String);
    double? subwayShare = double.tryParse(selectedgroup?.subwayShare as String);
    double? taxiShare = double.tryParse(selectedgroup?.taxiShare as String);

    if (personalCarShare != null) {
      final temp1 = 100 - personalCarShare;
      personalCarShare = zarib * personalCarShare;
      final temp2 = 100 - personalCarShare;

      if (selectedgroup?.personalCarShare != "null") {
        zResalt["  سهم خودرو شخصی"] = personalCarShare;
      }

      if (selectedgroup?.personalCarShare != "null") {
        bikeShare = bikeShare! / temp1 * temp2;

        zResalt["  سهم موتور یا دوچرخه"] = bikeShare;
      }

      if (selectedgroup?.taxiShare != "null") {
        taxiShare = taxiShare! / temp1 * temp2;

        zResalt["سهم تاکسی"] = taxiShare;
      }

      if (selectedgroup?.busShare != "null") {
        busShare = busShare! / temp1 * temp2;

        zResalt["سهم اتوبوس"] = busShare;
      }

      if (selectedgroup?.subwayShare != "null") {
        subwayShare = subwayShare! / temp1 * temp2;

        zResalt["سهم مترو"] = subwayShare;
      }

      if (selectedgroup?.pedestrianShare != "null") {
        pedestrianShare = pedestrianShare! / temp1 * temp2;

        zResalt["سهم پیاده"] = pedestrianShare;
      }

      if (selectedgroup?.internetTaxiShare != "null") {
        internetTaxiShare = internetTaxiShare! / temp1 * temp2;

        zResalt["سهم تاکسی اینترنتی"] = internetTaxiShare;
      }
      if (selectedgroup?.serviceShare != "null") {
        serviceShare = serviceShare! / temp1 * temp2;

        zResalt["سهم سرویس "] = serviceShare;
      }
    }
  }

  void generalCalc(Map<String, String> form, double zarib) {
    print(form);
    result.clear();
    for (var x in form.entries) {
      calc(x, zarib);
    }
    calcdata(zarib);
    banner = false;
    print(result);
    update();
  }
}
