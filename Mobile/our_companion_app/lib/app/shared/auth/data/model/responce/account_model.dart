import 'package:our_companion_app/app/shared/auth/domin/entities/account_entiti.dart';

class AccountModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String accountType;
  final bool isVerified;
  final bool isProfileCompleted;

  const AccountModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.accountType,
    required this.isVerified,
    required this.isProfileCompleted,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json["id"],
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      email: json["email"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      accountType: json["accountType"] ?? "",
      isVerified: json["isVerified"] ?? false,
      isProfileCompleted: json["isProfileCompleted"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "accountType": accountType,
      "isVerified": isVerified,
      "isProfileCompleted": isProfileCompleted,
    };
  }



  AccountEntity toEntity() {
  return AccountEntity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    phoneNumber: phoneNumber,
    accountType: accountType,
    isVerified: isVerified,
    isProfileCompleted: isProfileCompleted,
  );
}
}