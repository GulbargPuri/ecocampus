import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const EcoCampusApp());
}

class EcoCampusApp extends StatelessWidget {
  const EcoCampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoCampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        primaryColor: const Color(0xFF1B4332),
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  // List of screens for the 4 bottom tabs
  final List<Widget> _screens = [
    const DashboardScreen(),
    const MapScreen(),
    const ChallengesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF09101A),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF52B788),
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined), label: 'Challenges'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// 1. DASHBOARD SCREEN
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _statusMessage = "Ready to connect to Python backend & MySQL";

  void _sendHabitData() async {
    setState(() => _statusMessage = "Sending data to Python ML Backend...");

    var result = await ApiService.logHabit(
      userId: 1,
      transportMode: 'Walking',
      plasticItemsAvoided: 3,
      electricitySavedKwh: 1.5,
    );

    if (result != null) {
      setState(() {
        _statusMessage = "Success! Saved ${result['estimated_co2_saved_kg']} kg CO₂ via ML model.";
      });
    } else {
      setState(() {
        _statusMessage = "Failed to connect. Make sure FastAPI server is running on port 8000.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('My Impact Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1B4332),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.eco, color: Color(0xFF52B788)),
                  SizedBox(width: 10),
                  Text('EcoCampus - Challenge MVP', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF52B788),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _sendHabitData,
                child: const Text('Test Backend Connection & Log Habit', style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _statusMessage,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. MAP SCREEN (Green Campus Spots)
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Green Campus Map')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.water_drop, color: Colors.blueAccent),
            title: Text('Refill Station - Library Block'),
            subtitle: Text('Avoided plastic bottles: 420 today'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.electric_bike, color: Colors.greenAccent),
            title: Text('E-Bike Hub - North Gate'),
            subtitle: Text('Available bikes: 5'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.solar_power, color: Colors.orangeAccent),
            title: Text('Solar Charging Bench - Cafeteria'),
            subtitle: Text('Clean energy generated: 14.2 kWh'),
          ),
        ],
      ),
    );
  }
}

// 3. CHALLENGES SCREEN
class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sustainability Challenges')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFF1E293B),
            child: ListTile(
              title: const Text('Zero Plastic Week', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Avoid single-use plastics for 7 days.'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF52B788)),
                onPressed: () {},
                child: const Text('Join', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            color: const Color(0xFF1E293B),
            child: ListTile(
              title: const Text('Walk to Class Initiative', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Walk or cycle instead of taking campus cars.'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF52B788)),
                onPressed: () {},
                child: const Text('Join', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 4. PROFILE SCREEN
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Eco-Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF52B788),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text('Eco Champion #1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Department of Computer Science', style: TextStyle(color: Colors.white54)),
            SizedBox(height: 30),
            Card(
              color: Color(0xFF1E293B),
              child: ListTile(
                leading: Icon(Icons.eco, color: Color(0xFF52B788)),
                title: Text('Total CO₂ Saved'),
                trailing: Text('34.5 kg', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}