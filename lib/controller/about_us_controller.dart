import 'package:get/get.dart';

import '../datafile/firebase_data/firebasedata.dart';
import '../models/app_detail_model.dart';

class AboutUsController extends GetxController{
  // bool currentTheme = false;
  // bool notification = true;


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    print("called--------setting");

    model = await FireBaseData.getAppDetail();

  }

  AppDetailModel? model;

}