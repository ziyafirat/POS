import 'dart:async';
import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../models/mqtt_alert_model.dart';

class MqttProvider {
  static const String _broker = 'localhost';
  static const int _port = 1883;
  static const String _clientId = 'self_checkout_app';
  static const String _alertTopic = 'alerts/checkout';

  MqttServerClient? _client;
  bool _isConnected = false;
  
  final StreamController<MqttAlertModel> _alertController = StreamController<MqttAlertModel>.broadcast();
  Stream<MqttAlertModel> get alertStream => _alertController.stream;

  Future<bool> connect() async {
    try {
      _client = MqttServerClient(_broker, _clientId);
      _client!.port = _port;
      _client!.logging(on: false);
      _client!.keepAlivePeriod = 20;
      _client!.onDisconnected = _onDisconnected;
      _client!.onConnected = _onConnected;
      _client!.onSubscribed = _onSubscribed;

      final connMessage = MqttConnectMessage()
          .withClientIdentifier(_clientId)
          .startClean()
          .withWillQos(MqttQos.atLeastOnce);
      
      _client!.connectionMessage = connMessage;

      await _client!.connect();
      
      if (_client!.connectionStatus!.state == MqttConnectionState.connected) {
        _isConnected = true;
        _subscribeToAlerts();
        return true;
      }
      
      return false;
    } catch (e) {
      _isConnected = false;
      return false;
    }
  }

  void _subscribeToAlerts() {
    if (_client != null && _isConnected) {
      _client!.subscribe(_alertTopic, MqttQos.atLeastOnce);
      _client!.updates!.listen(_onMessage);
    }
  }

  void _onMessage(List<MqttReceivedMessage<MqttMessage>> messages) {
    for (final message in messages) {
      final payload = message.payload as MqttPublishMessage;
      final messageText = String.fromCharCodes(payload.payload.message);
      
      try {
        final alertData = jsonDecode(messageText);
        final alert = MqttAlertModel.fromJson(alertData);
        _alertController.add(alert);
      } catch (e) {
        // Error parsing MQTT alert: $e
      }
    }
  }

  void _onConnected() {
    _isConnected = true;
    // MQTT client connected
  }

  void _onDisconnected() {
    _isConnected = false;
    // MQTT client disconnected
  }

  void _onSubscribed(String topic) {
    // Subscribed to topic: $topic
  }

  Future<void> publishTestAlert() async {
    if (_client != null && _isConnected) {
      final testAlert = {
        'id': 'test_${DateTime.now().millisecondsSinceEpoch}',
        'title': 'Test Alert',
        'message': 'This is a test alert from the assistant screen',
        'type': 'info',
        'timestamp': DateTime.now().toIso8601String(),
      };

      final builder = MqttClientPayloadBuilder();
      builder.addString(jsonEncode(testAlert));
      
      _client!.publishMessage(_alertTopic, MqttQos.atLeastOnce, builder.payload!);
    }
  }

  void disconnect() {
    _client?.disconnect();
    _isConnected = false;
  }

  void dispose() {
    disconnect();
    _alertController.close();
  }

  bool get isConnected => _isConnected;
}
