import 'package:flutter_riverpod/legacy.dart';
import 'package:our_companion_app/app/shared/auth/domin/usecases/logout_usecase.dart';
import 'package:our_companion_app/app/shared/auth/domin/usecases/register_usecase.dart';
import 'package:our_companion_app/app/shared/auth/domin/usecases/request_otp_usecase.dart';
import 'package:our_companion_app/app/shared/auth/domin/usecases/verify_otp_usecase.dart';
import 'package:our_companion_app/core/storage/secure_storage_service.dart';

import 'auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  final SecureStorageService storage;
  final RequestOtpUseCase requestOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthController({
    required this.storage,
    required this.requestOtpUseCase,
    required this.verifyOtpUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  }) : super(const AuthState());

  // Future<void> requestOtp(String phoneNumber) async {
  //   print("Request OTP button clicked");
  //   print("Phone: $phoneNumber");
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     await requestOtpUseCase(phoneNumber);

  //     state = state.copyWith(isLoading: false);
  //   } catch (e) {
  //     state = state.copyWith(isLoading: false, error: e.toString());
  //   }
  // }

  Future<void> requestOtp(String phoneNumber) async {
    print("Request OTP button clicked");
    print("Phone: $phoneNumber");

    try {
      state = state.copyWith(isLoading: true);

      await requestOtpUseCase(phoneNumber);

      print("OTP Request Success");

      state = state.copyWith(isLoading: false);
    } catch (e, stackTrace) {
      print("REQUEST OTP ERROR:");
      print(e);
      print(stackTrace);

      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Future<void> verifyOtp({
  //   required String phoneNumber,
  //   required String otp,
  //   required String deviceIdentifier,
  //   required String platform,
  //   required String deviceName,
  // }) async {
  //   try {
  //     state = state.copyWith(isLoading: true);

  //     final auth = await verifyOtpUseCase(
  //       phoneNumber: phoneNumber,
  //       otpCode: otp,
  //       deviceIdentifier: deviceIdentifier,
  //       platform: platform,
  //       deviceName: deviceName,
  //     );
  //     await storage.saveAccessToken(auth.accessToken);

  //     await storage.saveRefreshToken(auth.refreshToken);

  //     state = state.copyWith(isLoading: false, auth: auth);
  //   } catch (e) {
  //     state = state.copyWith(isLoading: false, error: e.toString());
  //   }
  // }

  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
    required String deviceIdentifier,
    required String platform,
    required String deviceName,
  }) async {
    print("========== VERIFY OTP ==========");
    print("Phone: $phoneNumber");
    print("OTP: $otp");

    try {
      state = state.copyWith(isLoading: true);

      final auth = await verifyOtpUseCase(
        phoneNumber: phoneNumber,
        otpCode: otp,
        deviceIdentifier: deviceIdentifier,
        platform: platform,
        deviceName: deviceName,
      );

      print("VERIFY SUCCESS");
      print(auth);
      print(auth.account?.accountType);
      print("Access Token from API: ${auth.accessToken}");
      print("Refresh Token from API: ${auth.refreshToken}");
      print("Is Registration Required: ${auth.isRegistrationRequired}");

      await storage.savePhoneNumber(phoneNumber);

      if (!auth.isRegistrationRequired) {
        await storage.saveAccessToken(auth.accessToken);
        await storage.saveRefreshToken(auth.refreshToken);

        if (auth.account != null) {
          await storage.seveRole(auth.account!.accountType);
        }

        
      }
      state = state.copyWith(isLoading: false, auth: auth);
    } catch (e, s) {
      print("VERIFY ERROR");
      print(e);
      print(s);

      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String accountType,
    required String deviceIdentifier,
    required String platform,
    required String deviceName,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      final auth = await registerUseCase(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        accountType: accountType,
        deviceIdentifier: deviceIdentifier,
        platform: platform,
        deviceName: deviceName,
      );
      await storage.saveAccessToken(auth.accessToken);

      await storage.saveRefreshToken(auth.refreshToken);
      if (auth.account != null) {
        await storage.seveRole(auth.account!.accountType);
      }

      state = state.copyWith(isLoading: false, auth: auth);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout(String refreshToken) async {
    try {
      state = state.copyWith(isLoading: true);

      await logoutUseCase(refreshToken);

      await storage.clear();

      state = const AuthState();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  

}
