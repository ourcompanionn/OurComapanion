class LogoutRequest{

  final String refreshToken;

  const LogoutRequest({

    required this.refreshToken,

  });

  Map<String,dynamic> toJson(){

    return{

      "refreshToken":refreshToken,

    };

  }

}