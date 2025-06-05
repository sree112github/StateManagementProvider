
import 'package:flutter/material.dart';
import 'package:flutterlearn/data/provider/AuthProvider/authProvider.dart';
import 'package:provider/provider.dart';

import '../../../data/provider/HomeProvider/HomeProvider.dart';


void showCreateHomeDialog(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final homeProvider = Provider.of<HomeProvider>(context, listen: false);
  final userProvider = Provider.of<AuthProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text("Create Home"),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: "Enter Home Name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Cancel"),
          ),

          Consumer<HomeProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CircularProgressIndicator(),
                );
              }

              return TextButton(
                onPressed: () async {
                  String homeName = nameController.text.trim();
                  if (homeName.isNotEmpty) {
                    String? userId = userProvider.getUserData.userId;
                    double? latitude = homeProvider.homePostData.homeLatitude;
                    double? longitude = homeProvider.homePostData.homeLongitude;

                    await provider.createHome(homeName, userId, longitude, latitude);

                    if (provider.homePostData.statusCode ==201) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Home created successfully!")),
                      );
                    }
                  }
                },
                child: Text("Create"),
              );
            },
          ),
        ],
      );
    },
  );
}
