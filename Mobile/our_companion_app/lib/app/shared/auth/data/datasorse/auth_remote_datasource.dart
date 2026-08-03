import 'package:our_companion_app/app/shared/auth/data/model/request/logout_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/refresh_token_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/register_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/request_otp.dart';
import 'package:our_companion_app/app/shared/auth/data/model/request/verify_otp_request.dart';
import 'package:our_companion_app/app/shared/auth/data/model/responce/api_responce.dart';


abstract class AuthRemoteDatasource {

  Future<OtpVerifyResponse> requestOtp(
    RequestOtpRequest request,
  );

  Future<OtpVerifyResponse> verifyOtp(
    VerifyOtpRequest request,
  );

  Future<OtpVerifyResponse> register(
    RegisterRequest request,
  );

  Future<OtpVerifyResponse> refreshToken(
    RefreshTokenRequest request,
  );

  Future<OtpVerifyResponse> logout(
    LogoutRequest request,
  );
}