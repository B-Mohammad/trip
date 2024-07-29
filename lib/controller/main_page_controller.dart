import 'package:get/get.dart';
import 'package:trip/models/form_model.dart';
import 'package:trip/utils/repository.dart';

class MainPageController extends GetxController {
  List<FormModel>? listFormModel;

  Future<void> getListFormModels() async {
    listFormModel = await Repository.readExcelFile();
  }
}
