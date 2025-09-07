import '../models/item_model.dart';
import '../models/grpc_response_model.dart';
import '../models/mqtt_alert_model.dart';
import '../providers/grpc_provider.dart';
import '../providers/mqtt_provider.dart';

class CheckoutRepository {
  final GrpcProvider _grpcProvider;
  final MqttProvider _mqttProvider;

  CheckoutRepository({
    required GrpcProvider grpcProvider,
    required MqttProvider mqttProvider,
  }) : _grpcProvider = grpcProvider,
       _mqttProvider = mqttProvider;

  Future<bool> initializeConnections() async {
    final grpcConnected = await _grpcProvider.connect();
    final mqttConnected = await _mqttProvider.connect();
    return grpcConnected && mqttConnected;
  }

  Future<GrpcResponseModel> finishScanning(List<ItemModel> items) async {
    final itemsData = items.map((item) => item.toJson()).toList();
    return await _grpcProvider.sendFinishScanningRequest(itemsData);
  }

  Future<GrpcResponseModel> processPayment(String paymentMethod) async {
    return await _grpcProvider.sendPaymentRequest(paymentMethod);
  }

  Future<GrpcResponseModel> checkPaymentStatus() async {
    return await _grpcProvider.checkPaymentStatus();
  }

  Future<GrpcResponseModel> sendTestAction(String action) async {
    return await _grpcProvider.sendTestRequest(action);
  }

  Stream<MqttAlertModel> get alertStream => _mqttProvider.alertStream;

  Future<void> publishTestAlert() async {
    await _mqttProvider.publishTestAlert();
  }

  bool get isGrpcConnected => _grpcProvider.isConnected;
  bool get isMqttConnected => _mqttProvider.isConnected;

  void dispose() {
    _grpcProvider.dispose();
    _mqttProvider.dispose();
  }
}
