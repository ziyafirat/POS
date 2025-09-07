import 'package:get/get.dart';
import '../../../data/repositories/checkout_repository.dart';

class AssistantController extends GetxController {
  final CheckoutRepository _repository = Get.find<CheckoutRepository>();
  
  final RxBool isLoading = false.obs;
  final RxString lastResponse = ''.obs;
  final RxList<String> actionHistory = <String>[].obs;

  final List<Map<String, String>> testActions = [
    {'name': 'Test Connection', 'action': 'test_connection'},
    {'name': 'Start Scanning', 'action': 'start_scanning'},
    {'name': 'Add Test Item', 'action': 'add_test_item'},
    {'name': 'Process Payment', 'action': 'process_payment'},
    {'name': 'Check Status', 'action': 'check_status'},
    {'name': 'Print Receipt', 'action': 'print_receipt'},
    {'name': 'Reset System', 'action': 'reset_system'},
    {'name': 'Send Alert', 'action': 'send_alert'},
    {'name': 'Test Error', 'action': 'test_error'},
    {'name': 'Simulate Timeout', 'action': 'simulate_timeout'},
  ];

  @override
  void onInit() {
    super.onInit();
    _listenToAlerts();
  }

  void _listenToAlerts() {
    _repository.alertStream.listen((alert) {
      Get.toNamed('/alert', arguments: alert);
    });
  }

  Future<void> executeTestAction(String actionName, String action) async {
    isLoading.value = true;
    lastResponse.value = 'Executing $actionName...';
    
    try {
      if (action == 'send_alert') {
        await _repository.publishTestAlert();
        lastResponse.value = 'Test alert sent successfully';
      } else {
        final response = await _repository.sendTestAction(action);
        lastResponse.value = response.success 
            ? 'Success: ${response.message}'
            : 'Error: ${response.message}';
      }
      
      actionHistory.insert(0, '$actionName - ${DateTime.now().toString().split('.')[0]}');
      if (actionHistory.length > 10) {
        actionHistory.removeLast();
      }
    } catch (e) {
      lastResponse.value = 'Error executing $actionName: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void clearHistory() {
    actionHistory.clear();
    lastResponse.value = '';
  }

  void goToStart() {
    Get.offAllNamed('/start');
  }

  void goToItemScan() {
    Get.offAllNamed('/item-scan');
  }

  String get connectionStatus {
    final grpcStatus = _repository.isGrpcConnected ? 'Connected' : 'Disconnected';
    final mqttStatus = _repository.isMqttConnected ? 'Connected' : 'Disconnected';
    return 'gRPC: $grpcStatus | MQTT: $mqttStatus';
  }
}
