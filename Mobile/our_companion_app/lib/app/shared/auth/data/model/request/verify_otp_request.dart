class VerifyOtpRequest{

  final String phoneNumber;

  final String otpCode;

  final String deviceIdentifier;

  final String platform;

  final String deviceName;

  const VerifyOtpRequest({

    required this.phoneNumber,
    required this.otpCode,
    required this.deviceIdentifier,
    required this.platform,
    required this.deviceName,

  });

  Map<String,dynamic> toJson(){

    return{

      "phoneNumber":phoneNumber,
      "otpCode":otpCode,
      "deviceIdentifier":deviceIdentifier,
      "platform":platform,
      "deviceName":deviceName,

    };

  }

}