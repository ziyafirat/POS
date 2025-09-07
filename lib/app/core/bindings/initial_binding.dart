import 'package:get/get.dart';
import '../../data/providers/grpc_provider.dart';
import '../../data/providers/mqtt_provider.dart';
import '../../data/repositories/checkout_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GrpcProvider>(GrpcProvider(), permanent: true);
    Get.put<MqttProvider>(MqttProvider(), permanent: true);
    Get.put<CheckoutRepository>(
      CheckoutRepository(
        grpcProvider: Get.find<GrpcProvider>(),
        mqttProvider: Get.find<MqttProvider>(),
      ),
      permanent: true,
    );
  }
}
