class MqttAlertModel {
  final String id;
  final String title;
  final String message;
  final String? videoUrl;
  final DateTime timestamp;
  final AlertType type;

  MqttAlertModel({
    required this.id,
    required this.title,
    required this.message,
    this.videoUrl,
    required this.timestamp,
    required this.type,
  });

  factory MqttAlertModel.fromJson(Map<String, dynamic> json) {
    return MqttAlertModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      videoUrl: json['videoUrl'],
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      type: _parseAlertType(json['type']),
    );
  }

  static AlertType _parseAlertType(String? type) {
    switch (type?.toLowerCase()) {
      case 'warning':
        return AlertType.warning;
      case 'error':
        return AlertType.error;
      case 'info':
        return AlertType.info;
      default:
        return AlertType.info;
    }
  }
}

enum AlertType {
  info,
  warning,
  error,
}
