import 'package:calendar_schedular/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // 플러터가 실행되기 전에 다른 요소들이 준비되었는지 체크하는 함수
  // runApp 이 실행될 때에는 자동으로 실행됨
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
