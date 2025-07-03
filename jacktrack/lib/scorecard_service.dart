import 'package:hive/hive.dart';
import 'package:jacktrack/scorecard.dart';

class ScorecardService {
  final Box<Scorecard> _scorecardBox = Hive.box<Scorecard>('scorecards');

  Future<void> saveScorecard(Scorecard scorecard) {
    return _scorecardBox.put(scorecard.id, scorecard);
  }

  List<Scorecard> getScorecards(String userId) {
    return _scorecardBox.values
        .where((scorecard) => scorecard.userId == userId)
        .toList();
  }
}