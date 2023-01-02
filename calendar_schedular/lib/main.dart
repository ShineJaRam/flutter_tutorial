import 'package:calendar_schedular/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_schedular/database/drift_database.dart';

const DEFAULT_COLORS = [
  // 빨강
  'F44336',
  // 주황
  'FF9800',
  // 노랑
  'FFEB3B',
  // 초록
  'FCAF50',
  // 파랑
  '2196F3',
  // 남색
  '3F51B5',
  // 보라
  '9C27B0'
];

void main() async {
  // 플러터가 실행되기 전에 다른 요소들이 준비되었는지 체크하는 함수
  // runApp 이 실행될 때에는 자동으로 실행됨
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();

  if (colors.isEmpty) {
    for (String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(hexCode: Value(hexCode)),
      );
    }
  }

  runApp(
    const MaterialApp(
      home: HomeScreen(),
    ),
  );
}
