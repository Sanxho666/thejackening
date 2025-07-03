import 'package:hive/hive.dart';

class LocalAuthService {
  final Box _userBox = Hive.box('user');

  String? get currentUserId => _userBox.get('currentUserId');

  Future<void> login(String userId) async {
    await _userBox.put('currentUserId', userId);
  }

  Future<void> logout() async {
    await _userBox.delete('currentUserId');
  }
}
