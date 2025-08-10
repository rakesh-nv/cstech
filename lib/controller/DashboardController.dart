import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController {
  var bottomSheetOpen = false.obs;

  @override
  void onInit() {
    bottomSheetOpen.value = false; // reset on screen load
    super.onInit();
  }
}