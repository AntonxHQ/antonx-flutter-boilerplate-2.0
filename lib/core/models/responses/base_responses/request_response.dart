class RequestResponse {
  late bool success;
  String? error;
  late Map<String, dynamic> data;

  RequestResponse(this.success, {this.error});

  RequestResponse.fromJson(json) {
    this.data = json;
    this.success = json['success'];
    this.error = json['error'];
  }

  toJson() {
    return {
      'success': this.success,
      'error': this.error,
      'body': this.data,
    };
  }
}
