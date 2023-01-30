class DemoResponse {
  DemoResponse({String? timestamp, bool? status, String? message}) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
  }

  DemoResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
  }

  String? _timestamp;
  bool? _status;
  String? _message;

  DemoResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
  }) =>
      DemoResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
