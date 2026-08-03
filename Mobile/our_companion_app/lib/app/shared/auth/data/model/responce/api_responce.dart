import 'auth_data_model.dart';

class OtpVerifyResponse {
  final bool success;
  final String message;
  final AuthDataModel? data;
  final dynamic errors;

  const OtpVerifyResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerifyResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null
          ? AuthDataModel.fromJson(json["data"])
          : null,
      errors: json["errors"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data?.toJson(),
      "errors": errors,
    };
  }
}