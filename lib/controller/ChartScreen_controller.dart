import 'package:get/get.dart';
import '../sarvices/callState_service.dart';

class ChartScreenController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt pending = 0.obs;
  RxInt done = 0.obs;
  RxInt scheduled = 0.obs;

  @override
  void onInit() {
    fetchCallStatus();
    super.onInit();
  }

  void fetchCallStatus() async {
    isLoading.value = true;
    final status = await CallStatusService.fetchCallStatus();
    if (status != null) {
      pending.value = status.pending;
      done.value = status.called;
      scheduled.value = status.rescheduled;
    }
    isLoading.value = false;
  }
}
