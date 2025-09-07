import 'package:get/get.dart';
import '../modules/start/bindings/start_binding.dart';
import '../modules/start/views/start_view.dart';
import '../modules/item_scan/bindings/item_scan_binding.dart';
import '../modules/item_scan/views/item_scan_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/processing/bindings/processing_binding.dart';
import '../modules/processing/views/processing_view.dart';
import '../modules/printing/bindings/printing_binding.dart';
import '../modules/printing/views/printing_view.dart';
import '../modules/error/bindings/error_binding.dart';
import '../modules/error/views/error_view.dart';
import '../modules/alert/bindings/alert_binding.dart';
import '../modules/alert/views/alert_view.dart';
import '../modules/assistant/bindings/assistant_binding.dart';
import '../modules/assistant/views/assistant_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.START;

  static final routes = [
    GetPage(
      name: _Paths.START,
      page: () => const StartView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.ITEM_SCAN,
      page: () => const ItemScanView(),
      binding: ItemScanBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PROCESSING,
      page: () => const ProcessingView(),
      binding: ProcessingBinding(),
    ),
    GetPage(
      name: _Paths.PRINTING,
      page: () => const PrintingView(),
      binding: PrintingBinding(),
    ),
    GetPage(
      name: _Paths.ERROR,
      page: () => const ErrorView(),
      binding: ErrorBinding(),
    ),
    GetPage(
      name: _Paths.ALERT,
      page: () => const AlertView(),
      binding: AlertBinding(),
    ),
    GetPage(
      name: _Paths.ASSISTANT,
      page: () => const AssistantView(),
      binding: AssistantBinding(),
    ),
  ];
}
