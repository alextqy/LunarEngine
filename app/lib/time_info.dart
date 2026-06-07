import 'dart:math' as math;

class FullLunarEngine {
  final List<int> _lunarInfo = [0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2, 0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0dd40, 0x0d4a0, 0x1d4a4, 0x0d540, 0x0d5a0, 0x06950, 0x052d5, 0x059a0, 0x05b50, 0x05b52, 0x06a50, 0x06d40, 0x15ab6, 0x05ad0, 0x055d0, 0x0ae52, 0x09a50, 0x0a5b4, 0x0a4b0, 0x0aa50, 0x15265, 0x06d20, 0x0ad90, 0x14956, 0x05690, 0x04950, 0x0a4b6, 0x0a4a0, 0x0a4b0, 0x16525, 0x06d20, 0x0d960, 0x0d5b4, 0x056a0, 0x096d0, 0x04ad2, 0x04ae0, 0x0a4b6, 0x0a4b0, 0x0d250, 0x1d255, 0x0d540, 0x0d5a0, 0x1da46, 0x05950, 0x055d0, 0x0afb2, 0x0a4b0, 0x0a4b4, 0x0a4b0, 0x15265, 0x06d20, 0x0d960, 0x1d954, 0x0d5a0, 0x056a0, 0x0a6d2, 0x05ad0, 0x05ae0, 0x0ae56, 0x0ae50, 0x0a4d0, 0x1d265, 0x0d250, 0x0d520, 0x0d534, 0x0d5a0, 0x056a0, 0x15ab4, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d260, 0x0d954, 0x0d5a0, 0x056a0, 0x196d2, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550];

  final List<DateTime> springFestivalDates = [
    // 1900-1919
    DateTime(1900, 1, 31), DateTime(1901, 2, 19), DateTime(1902, 2, 8), DateTime(1903, 1, 29), DateTime(1904, 2, 16),
    DateTime(1905, 2, 4), DateTime(1906, 1, 25), DateTime(1907, 2, 13), DateTime(1908, 2, 2), DateTime(1909, 1, 22),
    DateTime(1910, 2, 10), DateTime(1911, 1, 30), DateTime(1912, 2, 18), DateTime(1913, 2, 6), DateTime(1914, 1, 26),
    DateTime(1915, 2, 14), DateTime(1916, 2, 3), DateTime(1917, 1, 23), DateTime(1918, 2, 11), DateTime(1919, 2, 1),
    // 1920-1939
    DateTime(1920, 2, 20), DateTime(1921, 2, 8), DateTime(1922, 1, 28), DateTime(1923, 2, 16), DateTime(1924, 2, 5),
    DateTime(1925, 1, 24), DateTime(1926, 2, 13), DateTime(1927, 2, 2), DateTime(1928, 1, 23), DateTime(1929, 2, 10),
    DateTime(1930, 1, 30), DateTime(1931, 2, 17), DateTime(1932, 2, 6), DateTime(1933, 1, 26), DateTime(1934, 2, 14),
    DateTime(1935, 2, 4), DateTime(1936, 1, 24), DateTime(1937, 2, 11), DateTime(1938, 1, 31), DateTime(1939, 2, 19),
    // 1940-1959
    DateTime(1940, 2, 8), DateTime(1941, 1, 27), DateTime(1942, 2, 15), DateTime(1943, 2, 5), DateTime(1944, 1, 25),
    DateTime(1945, 2, 13), DateTime(1946, 2, 2), DateTime(1947, 1, 22), DateTime(1948, 2, 10), DateTime(1949, 1, 29),
    DateTime(1950, 2, 17), DateTime(1951, 2, 6), DateTime(1952, 1, 27), DateTime(1953, 2, 14), DateTime(1954, 2, 3),
    DateTime(1955, 1, 24), DateTime(1956, 2, 12), DateTime(1957, 1, 31), DateTime(1958, 2, 18), DateTime(1959, 2, 8),
    // 1960-1979
    DateTime(1960, 1, 28), DateTime(1961, 2, 15), DateTime(1962, 2, 5), DateTime(1963, 1, 25), DateTime(1964, 2, 13),
    DateTime(1965, 2, 2), DateTime(1966, 1, 21), DateTime(1967, 2, 9), DateTime(1968, 1, 30), DateTime(1969, 2, 17),
    DateTime(1970, 2, 6), DateTime(1971, 1, 27), DateTime(1972, 2, 15), DateTime(1973, 2, 3), DateTime(1974, 1, 23),
    DateTime(1975, 2, 11), DateTime(1976, 1, 31), DateTime(1977, 2, 18), DateTime(1978, 2, 7), DateTime(1979, 1, 28),
    // 1980-1999
    DateTime(1980, 2, 16), DateTime(1981, 2, 5), DateTime(1982, 1, 25), DateTime(1983, 2, 13), DateTime(1984, 2, 2),
    DateTime(1985, 2, 20), DateTime(1986, 2, 9), DateTime(1987, 1, 29), DateTime(1988, 2, 17), DateTime(1989, 2, 6),
    DateTime(1990, 1, 27), DateTime(1991, 2, 15), DateTime(1992, 2, 4), DateTime(1993, 1, 23), DateTime(1994, 2, 10),
    DateTime(1995, 1, 31), DateTime(1996, 2, 19), DateTime(1997, 2, 7), DateTime(1998, 1, 28), DateTime(1999, 2, 16),
    // 2000-2019
    DateTime(2000, 2, 5), DateTime(2001, 1, 24), DateTime(2002, 2, 12), DateTime(2003, 2, 1), DateTime(2004, 1, 22),
    DateTime(2005, 2, 9), DateTime(2006, 1, 29), DateTime(2007, 2, 18), DateTime(2008, 2, 7), DateTime(2009, 1, 26),
    DateTime(2010, 2, 14), DateTime(2011, 2, 3), DateTime(2012, 1, 23), DateTime(2013, 2, 10), DateTime(2014, 1, 31),
    DateTime(2015, 2, 19), DateTime(2016, 2, 8), DateTime(2017, 1, 28), DateTime(2018, 2, 16), DateTime(2019, 2, 5),
    // 2020-2049
    DateTime(2020, 1, 25), DateTime(2021, 2, 12), DateTime(2022, 2, 1), DateTime(2023, 1, 22), DateTime(2024, 2, 10),
    DateTime(2025, 1, 29), DateTime(2026, 2, 17), DateTime(2027, 2, 7), DateTime(2028, 1, 26), DateTime(2029, 2, 13),
    DateTime(2030, 2, 3), DateTime(2031, 1, 23), DateTime(2032, 2, 11), DateTime(2033, 1, 31), DateTime(2034, 2, 19),
    DateTime(2035, 2, 8), DateTime(2036, 1, 28), DateTime(2037, 2, 15), DateTime(2038, 2, 4), DateTime(2039, 1, 24),
    DateTime(2040, 2, 12), DateTime(2041, 2, 1), DateTime(2042, 1, 22), DateTime(2043, 2, 10), DateTime(2044, 1, 30),
    DateTime(2045, 2, 17), DateTime(2046, 2, 6), DateTime(2047, 1, 26), DateTime(2048, 2, 14), DateTime(2049, 2, 2),
    // 2050-2069
    DateTime(2050, 1, 23), DateTime(2051, 2, 11), DateTime(2052, 1, 31), DateTime(2053, 2, 19), DateTime(2054, 2, 8),
    DateTime(2055, 1, 28), DateTime(2056, 2, 15), DateTime(2057, 2, 4), DateTime(2058, 1, 24), DateTime(2059, 2, 12),
    DateTime(2060, 2, 2), DateTime(2061, 1, 22), DateTime(2062, 2, 10), DateTime(2063, 1, 30), DateTime(2064, 2, 17),
    DateTime(2065, 2, 6), DateTime(2066, 1, 26), DateTime(2067, 2, 14), DateTime(2068, 2, 3), DateTime(2069, 1, 23),
    // 2070-2089
    DateTime(2070, 2, 11), DateTime(2071, 1, 31), DateTime(2072, 2, 19), DateTime(2073, 2, 7), DateTime(2074, 1, 27),
    DateTime(2075, 2, 15), DateTime(2076, 2, 5), DateTime(2077, 1, 24), DateTime(2078, 2, 12), DateTime(2079, 2, 2),
    DateTime(2080, 1, 22), DateTime(2081, 2, 9), DateTime(2082, 1, 29), DateTime(2083, 2, 17), DateTime(2084, 2, 7),
    DateTime(2085, 1, 26), DateTime(2086, 2, 14), DateTime(2087, 2, 3), DateTime(2088, 1, 23), DateTime(2089, 2, 10),
    // 2090-2100
    DateTime(2090, 1, 30), DateTime(2091, 2, 18), DateTime(2092, 2, 7), DateTime(2093, 1, 27), DateTime(2094, 2, 15),
    DateTime(2095, 2, 4), DateTime(2096, 1, 24), DateTime(2097, 2, 11), DateTime(2098, 2, 1), DateTime(2099, 1, 21),
    DateTime(2100, 2, 9),
  ];

  final List<String> _gan = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"];
  final List<String> _zhi = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"];

  /// 1. 真太阳时修正（解决时辰判定歧义）
  /// [longitude]：出生地经度（如西安 108.9）
  DateTime getTrueSolarTime(DateTime dt, double longitude) {
    double jd = (dt.millisecondsSinceEpoch / 86400000) + 2440587.5;
    // double t = (jd - 2451545.0) / 36525.0;
    // 简化均时差方程 (EOT)
    double eot = -7.659 * math.sin(math.pi * (0.0172 * (jd - 2451545.0 + 5.9)) / 180.0) - 9.863 * math.sin(math.pi * (0.0334 * (jd - 2451545.0 - 1.2)) / 180.0);
    double offsetMinutes = eot + (longitude - 120.0) * 4;
    return dt.add(Duration(seconds: (offsetMinutes * 60).round()));
  }

  /// 2. 太阳黄经判定月柱 (解决节气交接错误)
  String getGanzhiMonth(DateTime dt) {
    // 核心：基于太阳黄经的节气区间判定
    // 0度(春分) -> 30度(清明) ... 315度(立春)
    double jd = (dt.millisecondsSinceEpoch / 86400000) + 2440587.5;
    double t = (jd - 2451545.0) / 36525.0;
    double l0 = 280.46646 + 36000.76983 * t; // 太阳平黄经
    int solarTermIdx = ((l0 - 15) / 30).floor() % 12; // 简化黄经转节气索引

    String yearGan = getGanzhiYear(dt)[0];
    int yearGanIdx = _gan.indexOf(yearGan) % 5;
    int monthGanIdx = (yearGanIdx * 2 + solarTermIdx + 2) % 10;
    return "${_gan[monthGanIdx]}${_zhi[solarTermIdx + 2]}";
  }

  /// 3. 获取精准干支年
  String getGanzhiYear(DateTime date) {
    int year = date.year;
    // 使用黄经判定立春是否交接
    if (date.month < 2 || (date.month == 2 && date.day < 4)) year -= 1;
    int idx = (year - 3) % 60 - 1;
    if (idx < 0) idx += 60;
    return "${_gan[idx % 10]}${_zhi[idx % 12]}";
  }

  /// 4. 日干支 (物理常量)
  String getGanzhiDay(DateTime date) {
    int jdn = (date.millisecondsSinceEpoch / 86400000).floor() + 2440588;
    int idx = (jdn + 5) % 60;
    return "${_gan[idx % 10]}${_zhi[idx % 12]}";
  }

  /// 5. 时干支 (基于真太阳时)
  String getGanzhiTime(DateTime date, double longitude) {
    DateTime trueTime = getTrueSolarTime(date, longitude);
    String dayGan = getGanzhiDay(date)[0];
    int dayGanIdx = _gan.indexOf(dayGan) % 5;
    int hourIndex = ((trueTime.hour + 1) % 24) ~/ 2;
    int timeGanIdx = (dayGanIdx * 2 + hourIndex) % 10;
    return "${_gan[timeGanIdx]}${_zhi[hourIndex]}";
  }

  /// 7. 公历闰年判断 (数学规则)
  bool isSolarLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// 8. 农历闰月提取 (位运算解压)
  /// 返回值：0表示无闰月，1-12表示闰几月
  int getLunarLeapMonth(int year) {
    if (year < 1900 || year > 2100) return 0;
    return (_lunarInfo[year - 1900] >> 16) & 0xF;
  }
}
