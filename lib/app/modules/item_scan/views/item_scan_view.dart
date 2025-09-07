import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/item_scan_controller.dart';

class ItemScanView extends GetView<ItemScanController> {
  const ItemScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Items'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => controller.scannedItems.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_scanner, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Scan items to add them to your cart',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.scannedItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.scannedItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: const Icon(Icons.shopping_bag),
                          title: Text(item.name),
                          subtitle: Text('Barcode: ${item.barcode}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => controller.updateItemQuantity(
                                  index,
                                  item.quantity - 1,
                                ),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => controller.updateItemQuantity(
                                  index,
                                  item.quantity + 1,
                                ),
                              ),
                              Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => controller.removeItem(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Due:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Obx(() => Text(
                      '\$${controller.totalDue.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 180,
                        height: 60,
                        margin: const EdgeInsets.only(right: 8),
                        child: ElevatedButton(
                          onPressed: controller.simulateScanItem,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: Colors.black26,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          child: const Text(
                            'Simulate Scan Item',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        width: 180,
                        height: 60,
                        margin: const EdgeInsets.only(left: 8),
                        child: Obx(() => ElevatedButton(
                          onPressed: controller.isLoading.value ? null : controller.finishScanning,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: Colors.black26,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Finish & Pay',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
