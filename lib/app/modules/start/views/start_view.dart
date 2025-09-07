import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/start_controller.dart';

class StartView extends GetView<StartController> {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.shopping_cart,
                size: 100,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Self Checkout',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
              controller.statusMessage.value,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            )),
            const SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
