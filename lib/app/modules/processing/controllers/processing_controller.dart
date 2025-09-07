import 'package:get/get.dart';
import '../../../data/repositories/checkout_repository.dart';

class ProcessingController extends GetxController {
  final CheckoutRepository _repository = Get.find<CheckoutRepository>();
  
  final RxString statusMessage = 'Processing payment...'.obs;
  final RxDouble progress = 0.0.obs;
  
  late final String paymentMethod;
  late final List items;
  late final double total;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    paymentMethod = arguments?['paymentMethod'] ?? '';
    items = arguments?['items'] ?? [];
    total = arguments?['total'] ?? 0.0;
    _listenToAlerts();
    _startProcessing();
  }

  void _listenToAlerts() {
    _repository.alertStream.listen((alert) {
      Get.toNamed('/alert', arguments: alert);
    });
  }

  Future<void> _startProcessing() async {
    statusMessage.value = 'Connecting to payment processor...';
    progress.value = 0.2;
    await Future.delayed(const Duration(seconds: 1));

    statusMessage.value = 'Verifying payment details...';
    progress.value = 0.4;
    await Future.delayed(const Duration(seconds: 1));

    statusMessage.value = 'Processing transaction...';
    progress.value = 0.6;
    await Future.delayed(const Duration(seconds: 1));

    statusMessage.value = 'Finalizing payment...';
    progress.value = 0.8;
    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await _repository.checkPaymentStatus();
      if (response.success) {
        statusMessage.value = 'Payment completed successfully!';
        progress.value = 1.0;
        await Future.delayed(const Duration(seconds: 1));
        Get.offNamed('/printing', arguments: {
          'paymentMethod': paymentMethod,
          'items': items,
          'total': total,
        });
      } else {
        Get.offNamed('/error', arguments: response.message);
      }
    } catch (e) {
      Get.offNamed('/error', arguments: 'Payment processing failed: $e');
    }
  }
}
