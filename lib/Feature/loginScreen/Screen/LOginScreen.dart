import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterlearn/Feature/HomeScreen/screen/homeScreenPage.dart';
import 'package:provider/provider.dart';
import '../../../data/provider/AuthProvider/authProvider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController userName;
  late final TextEditingController userPassword;

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    userPassword = TextEditingController();
  }

  @override
  void dispose() {
    userName.dispose();
    userPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("rebuilt");
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Selector<AuthProvider, String?>(
              selector: (context, provider) =>
                  provider.userData.userCreationMessage,
              builder: (context, selectedValue, child) {
                return Text("status  : $selectedValue");
              },
            ),
            Selector<AuthProvider, String?>(
              selector: (context, provider) => provider.userData.userId,
              builder: (context, selectedValue, child) {
                return Text("id  : $selectedValue");
              },
            ),
            Selector<AuthProvider, String?>(
              selector: (context, provider) => provider.userData.userEmail,
              builder: (context, selectedValue, child) {
                return Text("email: $selectedValue");
              },
            ),
            Selector<AuthProvider, String?>(
              selector: (context, provider) => provider.userData.userPhotoUrl,
              builder: (context, selectedValue, child) {
                return Text("photo: $selectedValue");
              },
            ),
            SizedBox(height: 20),
            TextField(controller: userName),
            SizedBox(height: 20),
            TextField(controller: userPassword),
            SizedBox(height: 20),

            Selector<AuthProvider, bool>(
              selector: (context, provider) => provider.isLoading,
              builder: (context, isLoading, child) {
                return isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () async {
                    await authProvider.createUserProvider(
                      userName.text,
                      userPassword.text,
                    );

                    final creationStatus = authProvider.userData.userCreationMessage;
                    if (creationStatus == "Success") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreenPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login failed: $creationStatus")),
                      );
                    }
                  },
                  child: Text("login"),
                );
              },
            )

          ],
        ),
      ),
    );
  }
}
