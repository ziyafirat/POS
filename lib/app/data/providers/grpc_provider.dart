import 'package:grpc/grpc.dart';
import '../models/grpc_response_model.dart';

class GrpcProvider {
  static const String _host = 'localhost';
  static const int _port = 50051;
  
  late ClientChannel _channel;
  bool _isConnected = false;

  GrpcProvider() {
    _initializeChannel();
  }

  void _initializeChannel() {
    _channel = ClientChannel(
      _host,
      port: _port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
  }

  Future<bool> connect() async {
    try {
      _isConnected = true;
      return true;
    } catch (e) {
      _isConnected = false;
      return false;
    }
  }

  Future<GrpcResponseModel> sendFinishScanningRequest(List<Map<String, dynamic>> items) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      return GrpcResponseModel(
        substate: ResponseSubstate.payment,
        message: 'Scanning completed. Please proceed to payment.',
        data: {'items': items, 'total': _calculateTotal(items)},
        success: true,
      );
    } catch (e) {
      return GrpcResponseModel(
        substate: ResponseSubstate.error,
        message: 'Failed to process scanning request: $e',
        success: false,
      );
    }
  }

  Future<GrpcResponseModel> sendPaymentRequest(String paymentMethod) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      
      return GrpcResponseModel(
        substate: ResponseSubstate.processing,
        message: 'Payment processing...',
        data: {'paymentMethod': paymentMethod},
        success: true,
      );
    } catch (e) {
      return GrpcResponseModel(
        substate: ResponseSubstate.error,
        message: 'Payment failed: $e',
        success: false,
      );
    }
  }

  Future<GrpcResponseModel> checkPaymentStatus() async {
    try {
      await Future.delayed(const Duration(milliseconds: 2000));
      
      return GrpcResponseModel(
        substate: ResponseSubstate.printing,
        message: 'Payment completed. Printing receipt...',
        success: true,
      );
    } catch (e) {
      return GrpcResponseModel(
        substate: ResponseSubstate.error,
        message: 'Payment status check failed: $e',
        success: false,
      );
    }
  }

  Future<GrpcResponseModel> sendTestRequest(String action) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      return GrpcResponseModel(
        substate: ResponseSubstate.idle,
        message: 'Test action "$action" executed successfully',
        data: {'action': action, 'timestamp': DateTime.now().toIso8601String()},
        success: true,
      );
    } catch (e) {
      return GrpcResponseModel(
        substate: ResponseSubstate.error,
        message: 'Test action failed: $e',
        success: false,
      );
    }
  }

  double _calculateTotal(List<Map<String, dynamic>> items) {
    return items.fold(0.0, (total, item) {
      final price = (item['price'] ?? 0.0).toDouble();
      final quantity = (item['quantity'] ?? 1).toInt();
      return total + (price * quantity);
    });
  }

  void dispose() {
    _channel.shutdown();
    _isConnected = false;
  }

  bool get isConnected => _isConnected;
}
