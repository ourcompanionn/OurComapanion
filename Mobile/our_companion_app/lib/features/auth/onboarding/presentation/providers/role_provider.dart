import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/features/auth/onboarding/domain/entities/user_role.dart';

class RoleNotifier extends Notifier<UserRole> {
  @override
  UserRole build() => UserRole.none;

  void setRole(UserRole role) {
    state = role;
  }
}

final roleProvider = NotifierProvider<RoleNotifier, UserRole>(RoleNotifier.new);
