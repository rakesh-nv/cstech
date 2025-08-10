class CallStatusModel {
  final int pending;
  final int called;
  final int rescheduled;

  CallStatusModel({
    required this.pending,
    required this.called,
    required this.rescheduled,
  });

  factory CallStatusModel.fromJson(Map<String, dynamic> json) {
    return CallStatusModel(
      pending: json['pending'] ?? 0,
      called: json['called'] ?? 0,
      rescheduled: json['rescheduled'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending': pending,
      'called': called,
      'rescheduled': rescheduled,
    };
  }
}
