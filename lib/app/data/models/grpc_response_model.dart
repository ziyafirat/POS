enum ResponseSubstate {
  idle,
  scanning,
  payment,
  processing,
  printing,
  completed,
  error,
}

class GrpcResponseModel {
  final ResponseSubstate substate;
  final String message;
  final Map<String, dynamic>? data;
  final bool success;

  GrpcResponseModel({
    required this.substate,
    required this.message,
    this.data,
    required this.success,
  });

  factory GrpcResponseModel.fromJson(Map<String, dynamic> json) {
    return GrpcResponseModel(
      substate: _parseSubstate(json['substate']),
      message: json['message'] ?? '',
      data: json['data'],
      success: json['success'] ?? false,
    );
  }

  static ResponseSubstate _parseSubstate(String? substate) {
    switch (substate?.toLowerCase()) {
      case 'idle':
        return ResponseSubstate.idle;
      case 'scanning':
        return ResponseSubstate.scanning;
      case 'payment':
        return ResponseSubstate.payment;
      case 'processing':
        return ResponseSubstate.processing;
      case 'printing':
        return ResponseSubstate.printing;
      case 'completed':
        return ResponseSubstate.completed;
      case 'error':
        return ResponseSubstate.error;
      default:
        return ResponseSubstate.idle;
    }
  }
}
