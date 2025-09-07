import 'package:get/get.dart';
import '../../../data/models/item_model.dart';
import '../../../data/repositories/checkout_repository.dart';

class ItemScanController extends GetxController {
  final CheckoutRepository _repository = Get.find<CheckoutRepository>();
  
  final RxList<ItemModel> scannedItems = <ItemModel>[].obs;
  final RxDouble totalDue = 0.0.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToAlerts();
  }

  void _listenToAlerts() {
    _repository.alertStream.listen((alert) {
      Get.toNamed('/alert', arguments: alert);
    });
  }

  void addItem(String barcode) {
    final item = ItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Sample Item ${scannedItems.length + 1}',
      price: (10.0 + (scannedItems.length * 2.5)),
      barcode: barcode,
    );
    
    scannedItems.add(item);
    _calculateTotal();
  }

  void removeItem(int index) {
    if (index >= 0 && index < scannedItems.length) {
      scannedItems.removeAt(index);
      _calculateTotal();
    }
  }

  void updateItemQuantity(int index, int quantity) {
    if (index >= 0 && index < scannedItems.length && quantity > 0) {
      scannedItems[index] = scannedItems[index].copyWith(quantity: quantity);
      _calculateTotal();
    }
  }

  void _calculateTotal() {
    totalDue.value = scannedItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> finishScanning() async {
    if (scannedItems.isEmpty) {
      Get.snackbar('Error', 'Please scan at least one item');
      return;
    }

    isLoading.value = true;
    try {
      final response = await _repository.finishScanning(scannedItems.toList());
      if (response.success) {
        Get.offNamed('/payment', arguments: {
          'items': scannedItems.toList(),
          'total': totalDue.value,
        });
      } else {
        Get.offNamed('/error', arguments: response.message);
      }
    } catch (e) {
      Get.offNamed('/error', arguments: 'Failed to process items: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void simulateScanItem() {
    final barcode = 'ITEM${DateTime.now().millisecondsSinceEpoch}';
    addItem(barcode);
  }
}
