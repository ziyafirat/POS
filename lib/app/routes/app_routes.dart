
part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const START = _Paths.START;
  static const ITEM_SCAN = _Paths.ITEM_SCAN;
  static const PAYMENT = _Paths.PAYMENT;
  static const PROCESSING = _Paths.PROCESSING;
  static const PRINTING = _Paths.PRINTING;
  static const ERROR = _Paths.ERROR;
  static const ALERT = _Paths.ALERT;
  static const ASSISTANT = _Paths.ASSISTANT;
}

abstract class _Paths {
  _Paths._();
  static const START = '/start';
  static const ITEM_SCAN = '/item-scan';
  static const PAYMENT = '/payment';
  static const PROCESSING = '/processing';
  static const PRINTING = '/printing';
  static const ERROR = '/error';
  static const ALERT = '/alert';
  static const ASSISTANT = '/assistant';
}
