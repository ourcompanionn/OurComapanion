
import 'dart:developer';

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
  Future<OtpVerifyResponse> requestOtp(RequestOtpRequest request) async {
    log("========== REQUEST OTP ==========");
    log("URL: ${ApiEndpoints.requestOtp}");
    log("Request Body: ${request.toJson()}");

    log(dio.options.baseUrl);
log("${dio.options.baseUrl}${ApiEndpoints.requestOtp}");

    log("Before request");
    final response = await dio.post(
      ApiEndpoints.requestOtp,
      data: request.toJson(),
    );
    log("After request");

    log("Status Code: ${response.statusCode}");
    log("Response: ${response.data}");

    return OtpVerifyResponse.fromJson(response.data);
  }

  // @override
  // Future<ApiResponse> requestOtp(
  //   RequestOtpRequest request,
  // ) async {
  //   try {
  //     log("Calling: ${ApiEndpoints.baseUrl}${ApiEndpoints.requestOtp}");
  //     log("Request Body: ${request.toJson()}");

  //     final response = await dio.post(
  //       ApiEndpoints.requestOtp,
  //       data: request.toJson(),
  //     );

  //     log("Status Code: ${response.statusCode}");
  //     log("Response: ${response.data}");

  //     return ApiResponse.fromJson(response.data);
  //   } on DioException catch (e) {
  //     log("============== DIO ERROR ==============");
  //     log("Message: ${e.message}");
  //     log("Status: ${e.response?.statusCode}");
  //     log("Response: ${e.response?.data}");
  //     log("=======================================");

  //     rethrow;
  //   } catch (e) {
  //     log("General Error: $e");
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
  Future<OtpVerifyResponse> verifyOtp(VerifyOtpRequest request) async {
    log("Calling: ${ApiEndpoints.baseUrl}${ApiEndpoints.verifyOtp}");
    log("Request Body: ${request.toJson()}");

    final response = await dio.post(
      ApiEndpoints.verifyOtp,
      data: request.toJson(),
    );

    log("Status Code: ${response.statusCode}");
    log("Response: ${response.data}");

    return OtpVerifyResponse.fromJson(response.data);
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
  Future<OtpVerifyResponse> register(RegisterRequest request) async {
    try {
      log("========== REGISTER ==========");
      log("Calling: ${ApiEndpoints.baseUrl}${ApiEndpoints.register}");
      log("Request Body: ${request.toJson()}");

      final response = await dio.post(
        ApiEndpoints.register,
        data: request.toJson(),
      );

      log("Status Code: ${response.statusCode}");
      log("Response: ${response.data}");

      return OtpVerifyResponse.fromJson(response.data);
    } on DioException catch (e) {
      log("========== REGISTER ERROR ==========");
      log("Status Code: ${e.response?.statusCode}");
      log("Response: ${e.response?.data}");
      log("Message: ${e.message}");
      rethrow;
    }
  }

  @override
  Future<OtpVerifyResponse> refreshToken(RefreshTokenRequest request) async {
    final response = await dio.post(
      ApiEndpoints.refreshToken,
      data: request.toJson(),
    );

    return OtpVerifyResponse.fromJson(response.data);
  }

  @override
  Future<OtpVerifyResponse> logout(LogoutRequest request) async {
    final response = await dio.post(
      ApiEndpoints.logout,
      data: request.toJson(),
    );

    return OtpVerifyResponse.fromJson(response.data);
  }
}
