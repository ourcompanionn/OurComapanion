import 'package:dio/dio.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/logout_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/refresh_token_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/register_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/request_otp.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/verify_otp_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/responce/api_responce.dart';
import 'package:our_companion_app/core/network/api_endpont.dart';

import 'auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl(this.dio);

  @override
  Future<ApiResponse> requestOtp(RequestOtpRequest request) async {
    print("========== REQUEST OTP ==========");
    print("URL: ${ApiEndpoints.requestOtp}");
    print("Request Body: ${request.toJson()}");

    print(dio.options.baseUrl);
print("${dio.options.baseUrl}${ApiEndpoints.requestOtp}");

    print("Before request");
    final response = await dio.post(
      ApiEndpoints.requestOtp,
      data: request.toJson(),
    );
    print("After request");

    print("Status Code: ${response.statusCode}");
    print("Response: ${response.data}");

    return ApiResponse.fromJson(response.data);
  }

  // @override
  // Future<ApiResponse> requestOtp(
  //   RequestOtpRequest request,
  // ) async {
  //   try {
  //     print("Calling: ${ApiEndpoints.baseUrl}${ApiEndpoints.requestOtp}");
  //     print("Request Body: ${request.toJson()}");

  //     final response = await dio.post(
  //       ApiEndpoints.requestOtp,
  //       data: request.toJson(),
  //     );

  //     print("Status Code: ${response.statusCode}");
  //     print("Response: ${response.data}");

  //     return ApiResponse.fromJson(response.data);
  //   } on DioException catch (e) {
  //     print("============== DIO ERROR ==============");
  //     print("Message: ${e.message}");
  //     print("Status: ${e.response?.statusCode}");
  //     print("Response: ${e.response?.data}");
  //     print("=======================================");

  //     rethrow;
  //   } catch (e) {
  //     print("General Error: $e");
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ApiResponse> verifyOtp(
  //   VerifyOtpRequest request,
  // ) async {

  //   final response = await dio.post(
  //     ApiEndpoints.verifyOtp,
  //     data: request.toJson(),
  //   );

  //   return ApiResponse.fromJson(response.data);
  // }

  @override
  Future<ApiResponse> verifyOtp(VerifyOtpRequest request) async {
    print("Calling: ${ApiEndpoints.baseUrl}${ApiEndpoints.verifyOtp}");
    print("Request Body: ${request.toJson()}");

    final response = await dio.post(
      ApiEndpoints.verifyOtp,
      data: request.toJson(),
    );

    print("Status Code: ${response.statusCode}");
    print("Response: ${response.data}");

    return ApiResponse.fromJson(response.data);
  }

  @override
  // Future<ApiResponse> register(
  //   RegisterRequest request,
  // ) async {
  //   final response = await dio.post(
  //     ApiEndpoints.register,
  //     data: request.toJson(),
  //   );
  //   return ApiResponse.fromJson(response.data);
  // }
  @override
  Future<ApiResponse> register(RegisterRequest request) async {
    try {
      print("========== REGISTER ==========");
      print("Calling: ${ApiEndpoints.baseUrl}${ApiEndpoints.register}");
      print("Request Body: ${request.toJson()}");

      final response = await dio.post(
        ApiEndpoints.register,
        data: request.toJson(),
      );

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.data}");

      return ApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("========== REGISTER ERROR ==========");
      print("Status Code: ${e.response?.statusCode}");
      print("Response: ${e.response?.data}");
      print("Message: ${e.message}");
      rethrow;
    }
  }

  @override
  Future<ApiResponse> refreshToken(RefreshTokenRequest request) async {
    final response = await dio.post(
      ApiEndpoints.refreshToken,
      data: request.toJson(),
    );

    return ApiResponse.fromJson(response.data);
  }

  @override
  Future<ApiResponse> logout(LogoutRequest request) async {
    final response = await dio.post(
      ApiEndpoints.logout,
      data: request.toJson(),
    );

    return ApiResponse.fromJson(response.data);
  }
}
