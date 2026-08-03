class RequestOtpRequest {

  final String phoneNumber;

  const RequestOtpRequest({
    required this.phoneNumber,
  });

  Map<String,dynamic> toJson(){

    return{
      "phoneNumber":phoneNumber,
    };

  }

}