import 'package:flutter/material.dart';
import 'package:jacktrack/local_auth_service.dart';
import 'package:jacktrack/scorecard.dart';
import 'package:jacktrack/scorecard_service.dart';

class GameHistoryScreen extends StatelessWidget {
  const GameHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = LocalAuthService().currentUserId;
    if (userId == null) {
      return const Center(child: Text('Please log in to see your game history.'));
    }

    final scorecards = ScorecardService().getScorecards(userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
      ),
      body: scorecards.isEmpty
          ? const Center(child: Text('No game history found.'))
          : ListView.builder(
              itemCount: scorecards.length,
              itemBuilder: (context, index) {
                final scorecard = scorecards[index];
                final totalScore = scorecard.scores.reduce((a, b) => a + b);
                return ListTile(
                  title: Text('Game on ${scorecard.date.toLocal()}'),
                  subtitle: Text('Total Score: $totalScore'),
                );
              },
            ),
    );
  }
}
