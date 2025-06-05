class UserModel {
  String? userId;
  String? userName;
  String? password;
  String? userEmail;
  String? userPhotoUrl;
  DateTime? userCreatedAt;
  String? userCreationMessage;

  UserModel({
    this.userId,
    this.userName,
    this.password,
    this.userEmail,
    this.userPhotoUrl,
    this.userCreatedAt,
    this.userCreationMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": userName,    // backend expects lowercase 'username'
      "password": password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json, {required String message}) {
    return UserModel(
      userId: json['userId'],
      userName: json['username'],
      password: null, // Don't return password from API
      userEmail: json['userEmail'],
      userPhotoUrl: json['userPhotourl'], // make sure backend uses this exact key
      userCreatedAt: json['userCreatedAt'] != null ? DateTime.tryParse(json['userCreatedAt']) : null,
      userCreationMessage: message,
    );
  }
}
