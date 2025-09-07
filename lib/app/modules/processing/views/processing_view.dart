import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/processing_controller.dart';

class ProcessingView extends GetView<ProcessingController> {
  const ProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
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
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  Icons.payment,
                  size: 60,
                  color: Colors.orange.shade700,
                ),
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
              Obx(() => LinearProgressIndicator(
                value: controller.progress.value,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange.shade700),
                minHeight: 8,
              )),
              const SizedBox(height: 20),
              Obx(() => Text(
                '${(controller.progress.value * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              )),
              const SizedBox(height: 40),
              const Text(
                'Please wait while we process your payment...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
