
import 'package:flutter/material.dart';
import 'package:flutterlearn/data/provider/AuthProvider/authProvider.dart';
import 'package:flutterlearn/data/provider/HomeProvider/HomeProvider.dart';
import 'package:flutterlearn/data/repository/HomeRepository/homeRepository.dart';
import 'package:flutterlearn/data/repository/authRepository/authRepository.dart';
import 'package:flutterlearn/data/service/HomeServices/Get/GetHomeService.dart';
import 'package:flutterlearn/data/service/HomeServices/Post/CreateHomePostService.dart';
import 'package:flutterlearn/data/service/authServices/Get/GetUserService.dart';
import 'package:flutterlearn/data/service/authServices/Post/CreateUserPostService.dart';
import 'package:provider/provider.dart';

import 'Feature/loginScreen/Screen/LOginScreen.dart';

void main(){
  runApp(MultiProvider(providers:[
    ChangeNotifierProvider(create: (_)=> AuthProvider(AuthRepository(AuthPostService(),AuthGetServices()))),
    ChangeNotifierProvider(create: (_)=> HomeProvider(HomeRepository(HomePostService(),HomeGetService())))
  ],  child:MyApp()));
  

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
