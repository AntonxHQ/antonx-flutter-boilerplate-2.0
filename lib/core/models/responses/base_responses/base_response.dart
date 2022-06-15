class BaseResponse {
  late bool success;
  String? error;

  BaseResponse(this.success, {this.error});

  BaseResponse.fromJson(json) {
    this.success = json['success'];
    this.error = json['error'];
  }

  toJson() {
    return {
      'success': this.success,
      'error': this.error,
    };
  }
}
