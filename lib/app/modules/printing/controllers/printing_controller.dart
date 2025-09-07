import 'package:get/get.dart';
import '../../../data/repositories/checkout_repository.dart';

class PrintingController extends GetxController {
  final CheckoutRepository _repository = Get.find<CheckoutRepository>();
  
  final RxString statusMessage = 'Preparing receipt...'.obs;
  final RxBool isPrinting = true.obs;
  
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
    _startPrinting();
  }

  void _listenToAlerts() {
    _repository.alertStream.listen((alert) {
      Get.toNamed('/alert', arguments: alert);
    });
  }

  Future<void> _startPrinting() async {
    statusMessage.value = 'Generating receipt...';
    await Future.delayed(const Duration(seconds: 2));

    statusMessage.value = 'Printing receipt...';
    await Future.delayed(const Duration(seconds: 3));

    statusMessage.value = 'Receipt printed successfully!';
    isPrinting.value = false;
    
    await Future.delayed(const Duration(seconds: 2));
    _completeTransaction();
  }

  void _completeTransaction() {
    Get.offAllNamed('/start');
  }

  void skipPrinting() {
    Get.offAllNamed('/start');
  }
}
