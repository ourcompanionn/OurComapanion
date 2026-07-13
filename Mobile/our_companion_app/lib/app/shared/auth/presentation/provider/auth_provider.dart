import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:our_companion_app/app/shared/auth/data/datasorse/auth_remote_datasource.dart';
import 'package:our_companion_app/app/shared/auth/data/datasorse/auth_remote_datasource_impl.dart';
import 'package:our_companion_app/app/shared/auth/data/repository/auth_repository_impl.dart';
import 'package:our_companion_app/app/shared/auth/domin/repository/auth_repository.dart';
import 'package:our_companion_app/app/shared/auth/domin/usecases/logout_usecase.dart';
import 'package:our_companion_app/app/shared/auth/domin/usecases/register_usecase.dart';
import 'package:our_companion_app/app/shared/auth/domin/usecases/request_otp_usecase.dart';
import 'package:our_companion_app/app/shared/auth/domin/usecases/verify_otp_usecase.dart';
import 'package:our_companion_app/app/shared/auth/presentation/controller/signup_ui_controller.dart';
import 'package:our_companion_app/app/shared/auth/presentation/controller/signup_ui_state.dart';
import 'package:our_companion_app/core/providers/core_provider.dart';

import '../controller/auth_controller.dart';
import '../controller/auth_state.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl(ref.read(dioProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDatasourceProvider));
});

final requestOtpUseCaseProvider = Provider(
  (ref) => RequestOtpUseCase(ref.read(authRepositoryProvider)),
);

final verifyOtpUseCaseProvider = Provider(
  (ref) => VerifyOtpUseCase(ref.read(authRepositoryProvider)),
);

final registerUseCaseProvider = Provider(
  (ref) => RegisterUseCase(ref.read(authRepositoryProvider)),
);

final logoutUseCaseProvider = Provider(
  (ref) => LogoutUseCase(ref.read(authRepositoryProvider)),
);

final signupUiProvider =
    StateNotifierProvider<SignupUiController, SignupUiState>((ref) {
      return SignupUiController();
    });

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(
      storage: ref.read(secureStorageProvider),
      requestOtpUseCase: ref.read(requestOtpUseCaseProvider),
      verifyOtpUseCase: ref.read(verifyOtpUseCaseProvider),
      registerUseCase: ref.read(registerUseCaseProvider),
      logoutUseCase: ref.read(logoutUseCaseProvider),
    );
  },
);
