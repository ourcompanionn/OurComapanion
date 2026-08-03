import 'package:our_companion_app/app/shared/auth/data/datasorse/auth_remote_datasource.dart';
import 'package:our_companion_app/app/shared/auth/domin/entities/auth_entiti.dart';
import 'package:our_companion_app/app/shared/auth/domin/repository/auth_repository.dart';
import '../model/request/request_otp.dart';
import '../model/request/verify_otp_request.dart';
import '../model/request/register_request.dart';
import '../model/request/refresh_token_request.dart';
import '../model/request/logout_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> requestOtp(String phoneNumber) async {
    await remoteDatasource.requestOtp(
      RequestOtpRequest(
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  Future<AuthEntity> verifyOtp({
    required String phoneNumber,
    required String otpCode,
    required String deviceIdentifier,
    required String platform,
    required String deviceName,
  }) async {
    final response = await remoteDatasource.verifyOtp(
      VerifyOtpRequest(
        phoneNumber: phoneNumber,
        otpCode: otpCode,
        deviceIdentifier: deviceIdentifier,
        platform: platform,
        deviceName: deviceName,
      ),
    );

    return response.data!.toEntity();
  }

  @override
  Future<AuthEntity> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String accountType,
    required String deviceIdentifier,
    required String platform,
    required String deviceName,
  }) async {
    final response = await remoteDatasource.register(
      RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        accountType: accountType,
        deviceIdentifier: deviceIdentifier,
        platform: platform,
        deviceName: deviceName,
      ),
    );

    return response.data!.toEntity();
  }

  @override
  Future<AuthEntity> refreshToken(
    String refreshToken,
  ) async {
    final response = await remoteDatasource.refreshToken(
      RefreshTokenRequest(
        refreshToken: refreshToken,
      ),
    );

    return response.data!.toEntity();
  }

  @override
  Future<void> logout(
    String refreshToken,
  ) async {
    await remoteDatasource.logout(
      LogoutRequest(
        refreshToken: refreshToken,
      ),
    );
  }
}