import 'dart:convert';
import 'package:flutter/services.dart';

class DataService {
  static Map<String, dynamic>? _data;

  static Future<void> loadData() async {
    if (_data != null) return;
    final jsonString = await rootBundle.loadString('assets/data/gameData.json');
    _data = json.decode(jsonString);
  }

  static Map<String, dynamic> get data => _data!;
}
