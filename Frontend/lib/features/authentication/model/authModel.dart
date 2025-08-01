class AuthModel {
  final bool success;
  final String message;
  final String? token;

  AuthModel({
    required this.success,
    required this.message,
    this.token,
   
  });

  factory AuthModel.fromJson(Map<String,dynamic> json){
    return AuthModel(
      success: json['success'],
      message: json['message'],
      token: json['token'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'success': success,
      'message': message,
      'token': token,
    };
  }

}


