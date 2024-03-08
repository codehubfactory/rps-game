import 'package:shared_preferences/shared_preferences.dart';

class CachedManager {
  static const _keyScore = 'myscore';
  static const _keyScoreList = 'myscoreList';

  // Method to store the score using SharedPreferences
  Future<void> score_record(int i) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyScore, i);
  }

  Future<void> score_recordList(List<String> i) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyScoreList, i);
  }

  Future<List<String>?> getScoreList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyScoreList);
  }

  // Method to retrieve the score from SharedPreferences
  Future<int> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyScore) ?? 0;
  }
}
