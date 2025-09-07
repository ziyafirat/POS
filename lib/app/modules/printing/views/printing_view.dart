import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/printing_controller.dart';

class PrintingView extends GetView<PrintingController> {
  const PrintingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Obx(() => Icon(
                  controller.isPrinting.value ? Icons.print : Icons.check_circle,
                  size: 60,
                  color: Colors.purple.shade700,
                )),
              ),
              const SizedBox(height: 40),
              Obx(() => Text(
                controller.statusMessage.value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
              const SizedBox(height: 40),
              Obx(() => controller.isPrinting.value
                  ? CircularProgressIndicator(
                      color: Colors.purple.shade700,
                    )
                  : Icon(
                      Icons.done,
                      size: 48,
                      color: Colors.green.shade600,
                    )),
              const SizedBox(height: 40),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaction Summary',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Items: ${controller.items.length}'),
                      Text('Payment Method: ${controller.paymentMethod.toUpperCase()}'),
                      Text('Total: \$${controller.total.toStringAsFixed(2)}'),
                      Text('Date: ${DateTime.now().toString().split('.')[0]}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Obx(() => !controller.isPrinting.value
                  ? ElevatedButton(
                      onPressed: controller.skipPrinting,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      child: const Text('Continue'),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
