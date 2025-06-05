import 'package:flutter/material.dart';
import 'package:flutterlearn/Feature/loginScreen/Screen/LOginScreen.dart';
import 'package:flutterlearn/data/provider/AuthProvider/authProvider.dart';
import 'package:flutterlearn/data/provider/HomeProvider/HomeProvider.dart';
import 'package:provider/provider.dart';

import '../widget/createHomeWidget.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      final homeProvider = context.read<HomeProvider>();
      final userId = authProvider.userData.userId;

      authProvider.getUserProvider(userId);
      homeProvider.getHomeInfo(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: authProvider.isLoading
            ? CircularProgressIndicator()
            : const Text("Homepage"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final userId = authProvider.getUserData.userId;
          if (userId != null) {
            await homeProvider.getHomeInfo(userId);
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Consumer<HomeProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const CircularProgressIndicator();
                      }

                      final homes = provider.homesList;

                      if (homes.isEmpty) {
                        return const Text("No homes found");
                      }

                      return ListView.builder(
                        itemCount: homes.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final home = homes[index];
                          return Column(
                            children: [
                              Text("${home.homeId}"),
                              Card(
                                child: ListTile(
                                  title: Text(home.homeName ?? "Unnamed"),
                                  subtitle: Text(
                                    "Lat: ${home.homeLatitude}, Long: ${home.homeLongitude}",
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 20),


                  const SizedBox(height: 20),
                  authProvider.isLoading
                      ? const CircularProgressIndicator()
                      : Text("User Photo: ${authProvider.getUserData.userPhotoUrl ?? "N/A"}"),

                  const SizedBox(height: 10),
                  authProvider.isLoading
                      ? const CircularProgressIndicator()
                      : Text("User Created: ${authProvider.getUserData.userCreatedAt ?? "N/A"}"),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showCreateHomeDialog(context);
                    },
                    child: const Text("Create Home"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
