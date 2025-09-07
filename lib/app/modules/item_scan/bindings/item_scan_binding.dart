import 'package:get/get.dart';
import '../controllers/item_scan_controller.dart';

class ItemScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemScanController>(
      () => ItemScanController(),
    );
  }
}
