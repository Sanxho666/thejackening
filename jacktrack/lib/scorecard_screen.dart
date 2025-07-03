import 'package:flutter/material.dart';
import 'package:jacktrack/local_auth_service.dart';
import 'package:jacktrack/scorecard.dart';
import 'package:jacktrack/scorecard_service.dart';
import 'package:uuid/uuid.dart';

class ScorecardScreen extends StatefulWidget {
  const ScorecardScreen({super.key});

  @override
  State<ScorecardScreen> createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen> {
  final ScorecardService _scorecardService = ScorecardService();
  final LocalAuthService _authService = LocalAuthService();
  final List<int> _scores = List.generate(18, (index) => 0);

  void _incrementScore(int index) {
    setState(() {
      _scores[index]++;
    });
  }

  void _decrementScore(int index) {
    setState(() {
      if (_scores[index] > 0) {
        _scores[index]--;
      }
    });
  }

  Future<void> _saveScorecard() async {
    final userId = _authService.currentUserId;
    if (userId != null) {
      final scorecard = Scorecard(
        id: const Uuid().v4(),
        userId: userId,
        date: DateTime.now(),
        scores: _scores,
      );
      await _scorecardService.saveScorecard(scorecard);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Scorecard saved!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scorecard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveScorecard,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 18,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Hole ${index + 1}'),
            subtitle: Text('Score: ${_scores[index]}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => _decrementScore(index),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _incrementScore(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
