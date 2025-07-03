import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jacktrack/auth_wrapper.dart';
import 'package:jacktrack/home_screen.dart';
import 'package:jacktrack/scorecard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ScorecardAdapter());
  await Hive.openBox<Scorecard>('scorecards');
  await Hive.openBox('user');
  runApp(const JackTrackApp());
}

class JackTrackApp extends StatelessWidget {
  const JackTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JackTrack',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}