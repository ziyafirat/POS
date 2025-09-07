import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/alert_controller.dart';

class AlertView extends GetView<AlertController> {
  const AlertView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    controller.alertIcon,
                    size: 32,
                    color: controller.alertColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      controller.alertTypeText,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: controller.alertColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.closeAlert,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                controller.alert.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                controller.alert.message,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              if (controller.alert.videoUrl != null && controller.alert.videoUrl!.isNotEmpty) ...[
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(() => controller.isVideoPlaying.value
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_circle_filled, size: 48),
                              SizedBox(height: 8),
                              Text('Video Playing'),
                              Text('(Simulated)'),
                            ],
                          ),
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.video_library, size: 48),
                              SizedBox(height: 8),
                              Text('Video Content'),
                            ],
                          ),
                        )),
                ),
              ],
              const SizedBox(height: 24),
              Text(
                'Alert Time: ${controller.alert.timestamp.toString().split('.')[0]}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: controller.acknowledgeAlert,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.alertColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shadowColor: Colors.black26,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  child: const Text(
                    'Acknowledge',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
