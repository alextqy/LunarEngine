import 'time_info.dart';

void main() {
  final engine = FullLunarEngine();
  // 1987年11月2日 22点10分
  final testDate = DateTime(1987, 11, 2, 22, 10);
  final offset = 8;
  final longitude = 120.0;

  print('--- 测试开始 ---');
  print('测试时间: $testDate');
  print('时区偏移: $offset');
  print('经度: $longitude');
  print('----------------');

  try {
    print('干支年: ${engine.getGanzhiYear(testDate, offset)}');
    print('干支月: ${engine.getGanzhiMonth(testDate, offset)}');
    print('干支日: ${engine.getGanzhiDay(testDate, offset)}');
    print('干支时: ${engine.getGanzhiTime(testDate, offset, longitude)}');
  } catch (e) {
    print('发生错误: $e');
  }
  print('----------------');
}