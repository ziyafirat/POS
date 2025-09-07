import 'package:get/get.dart';
import '../../../data/repositories/checkout_repository.dart';

class StartController extends GetxController {
  final CheckoutRepository _repository = Get.find<CheckoutRepository>();
  
  final RxBool isLoading = false.obs;
  final RxString statusMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    isLoading.value = true;
    statusMessage.value = 'Initializing connections...';
    
    try {
      final connected = await _repository.initializeConnections();
      if (connected) {
        statusMessage.value = 'Ready to start';
        await Future.delayed(const Duration(seconds: 2));
        Get.offNamed('/item-scan');
      } else {
        statusMessage.value = 'Connection failed';
        await Future.delayed(const Duration(seconds: 2));
        Get.offNamed('/error');
      }
    } catch (e) {
      statusMessage.value = 'Error: $e';
      await Future.delayed(const Duration(seconds: 2));
      Get.offNamed('/error');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToItemScan() {
    Get.offNamed('/item-scan');
  }
}
