import 'package:our_companion_app/app/shared/auth/domin/entities/auth_entiti.dart';

import 'account_model.dart';

class AuthDataModel {
  final bool isRegistrationRequired;
  final String? accessToken;
  final String? refreshToken;
  final AccountModel? account;

  const AuthDataModel({
    required this.isRegistrationRequired,
    this.accessToken,
    this.refreshToken,
    this.account,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      isRegistrationRequired:
          json["isRegistrationRequired"] ?? false,
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      account: json["account"] != null
          ? AccountModel.fromJson(json["account"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isRegistrationRequired": isRegistrationRequired,
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "account": account?.toJson(),
    };
  }

  AuthEntity toEntity() {
    return AuthEntity(
      isRegistrationRequired: isRegistrationRequired,
      accessToken: accessToken ?? "",
      refreshToken: refreshToken ?? "",
      account: account?.toEntity(),
    );
  }
}