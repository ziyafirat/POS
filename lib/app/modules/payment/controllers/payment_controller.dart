import 'package:get/get.dart';
import '../../../data/repositories/checkout_repository.dart';

class PaymentController extends GetxController {
  final CheckoutRepository _repository = Get.find<CheckoutRepository>();
  
  final RxBool isLoading = false.obs;
  final RxString selectedPaymentMethod = ''.obs;
  
  late final List items;
  late final double total;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    items = arguments?['items'] ?? [];
    total = arguments?['total'] ?? 0.0;
    _listenToAlerts();
  }

  void _listenToAlerts() {
    _repository.alertStream.listen((alert) {
      Get.toNamed('/alert', arguments: alert);
    });
  }

  Future<void> processPayment(String paymentMethod) async {
    selectedPaymentMethod.value = paymentMethod;
    isLoading.value = true;

    try {
      final response = await _repository.processPayment(paymentMethod);
      if (response.success) {
        Get.offNamed('/processing', arguments: {
          'paymentMethod': paymentMethod,
          'items': items,
          'total': total,
        });
      } else {
        Get.offNamed('/error', arguments: response.message);
      }
    } catch (e) {
      Get.offNamed('/error', arguments: 'Payment processing failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
