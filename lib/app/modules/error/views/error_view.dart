import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/error_controller.dart';

class ErrorView extends GetView<ErrorController> {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
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
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 60,
                  color: Colors.red.shade700,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Obx(() => Text(
                controller.errorMessage.value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              )),
              const SizedBox(height: 40),
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 60,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      onPressed: controller.retry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: Colors.black26,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      child: const Text(
                        'Try Again',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 200,
                    height: 60,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      onPressed: controller.goToStart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: Colors.black26,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      child: const Text(
                        'Start Over',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 200,
                    height: 60,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: OutlinedButton(
                      onPressed: controller.goToAssistant,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        side: BorderSide(color: Colors.grey.shade400, width: 2),
                        elevation: 1,
                        shadowColor: Colors.black12,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      child: const Text(
                        'Assistant Mode',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
