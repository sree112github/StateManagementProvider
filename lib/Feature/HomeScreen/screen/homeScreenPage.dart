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
      homeProvider.fetchCurrentPlace();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: authProvider.isLoading
            ? const CircularProgressIndicator()
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
            await homeProvider.fetchCurrentPlace();
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Show Home Info
                  if (homeProvider.isLoading)
                    const CircularProgressIndicator()
                  else
                    _buildHomeList(homeProvider),

                  const SizedBox(height: 20),

                  // Location Info
                  _buildLocationInfo(homeProvider),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: homeProvider.getHomeAverageData,
                    child: const Text("Get Home Average Data"),
                  ),

                  const SizedBox(height: 20),

                  _buildHomeAverageSection(homeProvider),

                  const SizedBox(height: 20),

                  // User Info
                  if (authProvider.isLoading)
                    const CircularProgressIndicator()
                  else ...[
                    Text("User Photo: ${authProvider.getUserData.userPhotoUrl ?? "N/A"}"),
                    const SizedBox(height: 10),
                    Text("User Created: ${authProvider.getUserData.userCreatedAt ?? "N/A"}"),
                  ],

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showCreateHomeDialog(context);
                    },
                    child: const Text("Create Home"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeList(HomeProvider provider) {
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
        return Card(
          child: ListTile(
            title: Text(home.homeName ?? "Unnamed"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID: ${home.homeId ?? 'N/A'}"),
                Text("Location: ${home.homePlace ?? 'N/A'}"),
                Text("Created At: ${home.homeCreatedAt ?? 'N/A'}"),
                Text("Status: ${home.statusCode ?? 'N/A'}"),
                Text("Lat: ${home.homeLatitude}, Long: ${home.homeLongitude}"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationInfo(HomeProvider provider) {
    final location = provider.currentLocationDetails;
    if (location == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📍 Location Info", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Latitude: ${location.latitude ?? 'N/A'}"),
        Text("Longitude: ${location.longitude ?? 'N/A'}"),
        Text("Name: ${location.name ?? 'N/A'}"),
        Text("Area: ${location.administrativeArea ?? 'N/A'}"),
        Text("Street: ${location.street ?? 'N/A'}"),
        Text("Postal Code: ${location.postalCode ?? 'N/A'}"),
      ],
    );
  }

  Widget _buildHomeAverageSection(HomeProvider provider) {
    final data = provider.homeAverageData;
    if (data == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🏠 Home Averages", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Home ID: ${data.homeAverage?.homeId ?? 'N/A'}"),
        Text("Name: ${data.homeAverage?.homeName ?? 'N/A'}"),
        Text("AQI: ${data.homeAverage?.aqi ?? 'N/A'}"),
        Text("Temperature: ${data.homeAverage?.temperature ?? 'N/A'}"),
        Text("Humidity: ${data.homeAverage?.humidity ?? 'N/A'}"),
        Text("CO2: ${data.homeAverage?.co2 ?? 'N/A'}"),
        Text("Pressure: ${data.homeAverage?.pressure ?? 'N/A'}"),
        Text("VOC: ${data.homeAverage?.voc ?? 'N/A'}"),

        const SizedBox(height: 10),
        const Text("🛏️ Room Averages", style: TextStyle(fontWeight: FontWeight.bold)),

        ListView.builder(
          itemCount: data.roomAverage?.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final room = data.roomAverage?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Card(
                child: ListTile(
                  title: Text(room?.roomName ?? 'Unknown'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Room ID: ${room?.roomId ?? 'N/A'}"),
                      Text("AQI: ${room?.aqi ?? 'N/A'}"),
                      Text("Temp: ${room?.temperature ?? 'N/A'}"),
                      Text("Humidity: ${room?.humidity ?? 'N/A'}"),
                      Text("CO2: ${room?.co2 ?? 'N/A'}"),
                      Text("Pressure: ${room?.pressure ?? 'N/A'}"),
                      Text("VOC: ${room?.voc ?? 'N/A'}"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
