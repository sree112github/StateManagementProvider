

class UserModel {

  String? userId;
  String? userName;
  String? password;
  String? userEmail;
  String? userPhotoUrl;
  DateTime? userCreatedAt;
  String? userCreationMessage;

  UserModel(this.userId,this.userName,this.password,this.userEmail,this.userPhotoUrl,this.userCreatedAt,this.userCreationMessage);


  Map<String, dynamic> toJson() {
    return {
      "username": userName,    // note lowercase 'username'
      "password": password,
    };
  }

  factory UserModel.fromJson(Map<String,dynamic> json, {required String message}){
    return UserModel(
      json['userId'],
      json['username'],
      null, // Don't return password from API
      json['userEmail'],
      json['userPhotourl'],
      json['userCreatedAt'] != null ? DateTime.tryParse(json['userCreatedAt']) : null,
      message

    );

    }
  }


