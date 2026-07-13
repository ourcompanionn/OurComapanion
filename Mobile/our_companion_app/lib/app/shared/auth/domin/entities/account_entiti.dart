class AccountEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String accountType;
  final bool isVerified;
  final bool isProfileCompleted;

  const AccountEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.accountType,
    required this.isVerified,
    required this.isProfileCompleted,
  });
}