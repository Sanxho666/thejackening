import 'package:hive/hive.dart';

part 'scorecard.g.dart';

@HiveType(typeId: 0)
class Scorecard extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final List<int> scores;

  Scorecard({
    required this.id,
    required this.userId,
    required this.date,
    required this.scores,
  });
}