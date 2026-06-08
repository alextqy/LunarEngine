import 'time_info.dart';

void main() {
  final engine = FullLunarEngine();
  final now = DateTime(1987, 11, 2, 22, 10);
  final longitude = 120.0;

  print('--- 测试结果 ---');
  print('当前公历时间: $now');
  print('干支年: ${engine.getGanzhiYear(now)}');
  print('干支日: ${engine.getGanzhiDay(now)}');
  print('干支月: ${engine.getGanzhiMonth(now)}');
  print('干支时 (经度 $longitude): ${engine.getGanzhiTime(now, longitude)}');
  print('闰月 (2026年): ${engine.getLunarLeapMonth(2026)}');
  print('----------------');
}