import 'package:flutter/material.dart';
import 'package:flutterlearn/data/model/authModel.dart/authModel.dart';
import 'package:flutterlearn/data/repository/authRepository/authRepository.dart';

class AuthProvider extends ChangeNotifier {
  AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UserModel get userData => _authRepository.userData;
  UserModel get getUserData => _authRepository.getUserData;

  Future<void> createUserProvider(userName, userPassword) async {
    _isLoading = true;
    notifyListeners();
    await _authRepository.createUserRepository(userName, userPassword);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getUserProvider(userId) async {
    _isLoading = true;
    notifyListeners();
    await _authRepository.getUserRepository(userId);
    _isLoading = false;

    notifyListeners();
  }

  void logout() {
    _isLoading = false;
    final user = _authRepository.userData;

      user.userId = null;
      user.userName = null;
      user.password = null;
      user.userEmail = null;
      user.userPhotoUrl = null;
      user.userCreatedAt = null;
      user.userCreationMessage = null;

      notifyListeners();
    }

  }

