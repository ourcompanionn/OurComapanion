import 'auth_data_model.dart';

class ApiResponse {
  final bool success;
  final String message;
  final AuthDataModel? data;
  final dynamic errors;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
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