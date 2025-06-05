import 'package:flutterlearn/data/model/authModel.dart/authModel.dart';
import 'package:flutterlearn/data/service/authServices/Get/GetUserService.dart';
import 'package:flutterlearn/data/service/authServices/Post/CreateUserPostService.dart';

class AuthRepository {
  AuthPostService _postService;
  AuthGetServices _getService;

  AuthRepository(this._postService,this._getService);

  UserModel get userData => _postService.userData;
  UserModel get getUserData => _getService.userData;

  Future<void> createUserRepository(userName, userPassword) async {
    await _postService.createUserService(userName:userName ,userPassword: userPassword);
  }


  Future<void> getUserRepository(userId) async {

    await _getService.getUserInfo(userId);
  }
}
