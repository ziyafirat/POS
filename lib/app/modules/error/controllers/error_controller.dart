import 'package:get/get.dart';

class ErrorController extends GetxController {
  final RxString errorMessage = 'An unexpected error occurred'.obs;

  @override
  void onInit() {
    super.onInit();
    final message = Get.arguments as String?;
    if (message != null && message.isNotEmpty) {
      errorMessage.value = message;
    }
  }

  void goToStart() {
    Get.offAllNamed('/start');
  }

  void goToAssistant() {
    Get.toNamed('/assistant');
  }

  void retry() {
    Get.back();
  }
}
