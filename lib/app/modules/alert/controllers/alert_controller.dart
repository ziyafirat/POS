import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/mqtt_alert_model.dart';

class AlertController extends GetxController {
  late final MqttAlertModel alert;
  final RxBool isVideoPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    alert = Get.arguments as MqttAlertModel;
    if (alert.videoUrl != null && alert.videoUrl!.isNotEmpty) {
      _startVideo();
    }
  }

  void _startVideo() {
    isVideoPlaying.value = true;
  }

  void closeAlert() {
    Get.back();
  }

  void acknowledgeAlert() {
    Get.back();
  }

  String get alertTypeText {
    switch (alert.type) {
      case AlertType.warning:
        return 'WARNING';
      case AlertType.error:
        return 'ERROR';
      case AlertType.info:
        return 'INFORMATION';
    }
  }

  Color get alertColor {
    switch (alert.type) {
      case AlertType.warning:
        return Colors.orange;
      case AlertType.error:
        return Colors.red;
      case AlertType.info:
        return Colors.blue;
    }
  }

  IconData get alertIcon {
    switch (alert.type) {
      case AlertType.warning:
        return Icons.warning;
      case AlertType.error:
        return Icons.error;
      case AlertType.info:
        return Icons.info;
    }
  }
}
