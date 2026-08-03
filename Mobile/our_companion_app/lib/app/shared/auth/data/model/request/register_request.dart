class RegisterRequest{

  final String firstName;

  final String lastName;

  final String email;

  final String phoneNumber;

  final String accountType;

  final String deviceIdentifier;

  final String platform;

  final String deviceName;

  const RegisterRequest({

    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.accountType,
    required this.deviceIdentifier,
    required this.platform,
    required this.deviceName,

  });

  Map<String,dynamic> toJson(){

    return{

      "firstName":firstName,
      "lastName":lastName,
      "email":email,
      "phoneNumber":phoneNumber,
      "accountType":accountType,
      "deviceIdentifier":deviceIdentifier,
      "platform":platform,
      "deviceName":deviceName,

    };

  }

}