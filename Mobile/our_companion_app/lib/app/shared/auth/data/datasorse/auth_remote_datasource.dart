import 'package:our_companion_app/app/shared/auth/data/model/request/logout_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/refresh_token_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/register_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/request_otp.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/verify_otp_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/responce/api_responce.dart';


abstract class AuthRemoteDatasource {

  Future<ApiResponse> requestOtp(
    RequestOtpRequest request,
  );

  Future<ApiResponse> verifyOtp(
    VerifyOtpRequest request,
  );

  Future<ApiResponse> register(
    RegisterRequest request,
  );

  Future<ApiResponse> refreshToken(
    RefreshTokenRequest request,
  );

  Future<ApiResponse> logout(
    LogoutRequest request,
  );
}