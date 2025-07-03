import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jacktrack/ble_service.dart';
import 'package:jacktrack/game_history_screen.dart';
import 'package:jacktrack/scorecard_screen.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BleService _bleService = BleService();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MapScreen(),
    const ScorecardScreen(),
    const GameHistoryScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JackTrack'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scoreboard),
            label: 'Scorecard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Game History',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bleService.startScan();
        },
        child: const Icon(Icons.bluetooth_searching),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(51.509364, -0.128928),
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.jacktrack.app',
        ),
      ],
    );
  }
}
