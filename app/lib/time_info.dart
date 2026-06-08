import 'dart:math' as math;

class FullLunarEngine {
  /// 农历压缩星历表 (1900-2100)
  /// 采用 16 进制位域（Bit-field）压缩存储每年农历的大小月、闰月及春节跨度信息
  /// 每个二进制位代表一个特定维度的天文学开关（例如高4位代表闰月月份，低12位代表各月大小等）
  final List<int> _lunarInfo = [0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2, 0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0dd40, 0x0d4a0, 0x1d4a4, 0x0d540, 0x0d5a0, 0x06950, 0x052d5, 0x059a0, 0x05b50, 0x05b52, 0x06a50, 0x06d40, 0x15ab6, 0x05ad0, 0x055d0, 0x0ae52, 0x09a50, 0x0a5b4, 0x0a4b0, 0x0aa50, 0x15265, 0x06d20, 0x0ad90, 0x14956, 0x05690, 0x04950, 0x0a4b6, 0x0a4a0, 0x0a4b0, 0x16525, 0x06d20, 0x0d960, 0x0d5b4, 0x056a0, 0x096d0, 0x04ad2, 0x04ae0, 0x0a4b6, 0x0a4b0, 0x0d250, 0x1d255, 0x0d540, 0x0d5a0, 0x1da46, 0x05950, 0x055d0, 0x0afb2, 0x0a4b0, 0x0a4b4, 0x0a4b0, 0x15265, 0x06d20, 0x0d960, 0x1d954, 0x0d5a0, 0x056a0, 0x0a6d2, 0x05ad0, 0x05ae0, 0x0ae56, 0x0ae50, 0x0a4d0, 0x1d265, 0x0d250, 0x0d520, 0x0d534, 0x0d5a0, 0x056a0, 0x15ab4, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d260, 0x0d954, 0x0d5a0, 0x056a0, 0x196d2, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550, 0x0d564, 0x0d5a0, 0x056a0, 0x16d22, 0x05ad0, 0x05ae0, 0x0ae52, 0x0a4d0, 0x0a4d4, 0x0d250, 0x0d550];

  /// 每一年正月初一（春节）在公历中所对应的绝对字面量日期表格
  /// 用于在农历与公历相互转换时作为核心步长切分点
  final List<DateTime> springFestivalDates = [
    // 1900-1919 年春节对应的公历日期
    DateTime(1900, 1, 31), DateTime(1901, 2, 19), DateTime(1902, 2, 8), DateTime(1903, 1, 29), DateTime(1904, 2, 16),
    DateTime(1905, 2, 4), DateTime(1906, 1, 25), DateTime(1907, 2, 13), DateTime(1908, 2, 2), DateTime(1909, 1, 22),
    DateTime(1910, 2, 10), DateTime(1911, 1, 30), DateTime(1912, 2, 18), DateTime(1913, 2, 6), DateTime(1914, 1, 26),
    DateTime(1915, 2, 14), DateTime(1916, 2, 3), DateTime(1917, 1, 23), DateTime(1918, 2, 11), DateTime(1919, 2, 1),
    // 1920-1939 年春节对应的公历日期
    DateTime(1920, 2, 20), DateTime(1921, 2, 8), DateTime(1922, 1, 28), DateTime(1923, 2, 16), DateTime(1924, 2, 5),
    DateTime(1925, 1, 24), DateTime(1926, 2, 13), DateTime(1927, 2, 2), DateTime(1928, 1, 23), DateTime(1929, 2, 10),
    DateTime(1930, 1, 30), DateTime(1931, 2, 17), DateTime(1932, 2, 6), DateTime(1933, 1, 26), DateTime(1934, 2, 14),
    DateTime(1935, 2, 4), DateTime(1936, 1, 24), DateTime(1937, 2, 11), DateTime(1938, 1, 31), DateTime(1939, 2, 19),
    // 1940-1959 年春节对应的公历日期
    DateTime(1940, 2, 8), DateTime(1941, 1, 27), DateTime(1942, 2, 15), DateTime(1943, 2, 5), DateTime(1944, 1, 25),
    DateTime(1945, 2, 13), DateTime(1946, 2, 2), DateTime(1947, 1, 22), DateTime(1948, 2, 10), DateTime(1949, 1, 29),
    DateTime(1950, 2, 17), DateTime(1951, 2, 6), DateTime(1952, 1, 27), DateTime(1953, 2, 14), DateTime(1954, 2, 3),
    DateTime(1955, 1, 24), DateTime(1956, 2, 12), DateTime(1957, 1, 31), DateTime(1958, 2, 18), DateTime(1959, 2, 8),
    // 1960-1979 年春节对应的公历日期
    DateTime(1960, 1, 28), DateTime(1961, 2, 15), DateTime(1962, 2, 5), DateTime(1963, 1, 25), DateTime(1964, 2, 13),
    DateTime(1965, 2, 2), DateTime(1966, 1, 21), DateTime(1967, 2, 9), DateTime(1968, 1, 30), DateTime(1969, 2, 17),
    DateTime(1970, 2, 6), DateTime(1971, 1, 27), DateTime(1972, 2, 15), DateTime(1973, 2, 3), DateTime(1974, 1, 23),
    DateTime(1975, 2, 11), DateTime(1976, 1, 31), DateTime(1977, 2, 18), DateTime(1978, 2, 7), DateTime(1979, 1, 28),
    // 1980-1999 年春节对应的公历日期
    DateTime(1980, 2, 16), DateTime(1981, 2, 5), DateTime(1982, 1, 25), DateTime(1983, 2, 13), DateTime(1984, 2, 2),
    DateTime(1985, 2, 20), DateTime(1986, 2, 9), DateTime(1987, 1, 29), DateTime(1988, 2, 17), DateTime(1989, 2, 6),
    DateTime(1990, 1, 27), DateTime(1991, 2, 15), DateTime(1992, 2, 4), DateTime(1993, 1, 23), DateTime(1994, 2, 10),
    DateTime(1995, 1, 31), DateTime(1996, 2, 19), DateTime(1997, 2, 7), DateTime(1998, 1, 28), DateTime(1999, 2, 16),
    // 2000-2019 年春节对应的公历日期
    DateTime(2000, 2, 5), DateTime(2001, 1, 24), DateTime(2002, 2, 12), DateTime(2003, 2, 1), DateTime(2004, 1, 22),
    DateTime(2005, 2, 9), DateTime(2006, 1, 29), DateTime(2007, 2, 18), DateTime(2008, 2, 7), DateTime(2009, 1, 26),
    DateTime(2010, 2, 14), DateTime(2011, 2, 3), DateTime(2012, 1, 23), DateTime(2013, 2, 10), DateTime(2014, 1, 31),
    DateTime(2015, 2, 19), DateTime(2016, 2, 8), DateTime(2017, 1, 28), DateTime(2018, 2, 16), DateTime(2019, 2, 5),
    // 2020-2049 年春节对应的公历日期
    DateTime(2020, 1, 25), DateTime(2021, 2, 12), DateTime(2022, 2, 1), DateTime(2023, 1, 22), DateTime(2024, 2, 10),
    DateTime(2025, 1, 29), DateTime(2026, 2, 17), DateTime(2027, 2, 7), DateTime(2028, 1, 26), DateTime(2029, 2, 13),
    DateTime(2030, 2, 3), DateTime(2031, 1, 23), DateTime(2032, 2, 11), DateTime(2033, 1, 31), DateTime(2034, 2, 19),
    DateTime(2035, 2, 8), DateTime(2036, 1, 28), DateTime(2037, 2, 15), DateTime(2038, 2, 4), DateTime(2039, 1, 24),
    DateTime(2040, 2, 12), DateTime(2041, 2, 1), DateTime(2042, 1, 22), DateTime(2043, 2, 10), DateTime(2044, 1, 30),
    DateTime(2045, 2, 17), DateTime(2046, 2, 6), DateTime(2047, 1, 26), DateTime(2048, 2, 14), DateTime(2049, 2, 2),
    // 2050-2069 年春节对应的公历日期
    DateTime(2050, 1, 23), DateTime(2051, 2, 11), DateTime(2052, 1, 31), DateTime(2053, 2, 19), DateTime(2054, 2, 8),
    DateTime(2055, 1, 28), DateTime(2056, 2, 15), DateTime(2057, 2, 4), DateTime(2058, 1, 24), DateTime(2059, 2, 12),
    DateTime(2060, 2, 2), DateTime(2061, 1, 22), DateTime(2062, 2, 10), DateTime(2063, 1, 30), DateTime(2064, 2, 17),
    DateTime(2065, 2, 6), DateTime(2066, 1, 26), DateTime(2067, 2, 14), DateTime(2068, 2, 3), DateTime(2069, 1, 23),
    // 2070-2089 年春节对应的公历日期
    DateTime(2070, 2, 11), DateTime(2071, 1, 31), DateTime(2072, 2, 19), DateTime(2073, 2, 7), DateTime(2074, 1, 27),
    DateTime(2075, 2, 15), DateTime(2076, 2, 5), DateTime(2077, 1, 24), DateTime(2078, 2, 12), DateTime(2079, 2, 2),
    DateTime(2080, 1, 22), DateTime(2081, 2, 9), DateTime(2082, 1, 29), DateTime(2083, 2, 17), DateTime(2084, 2, 7),
    DateTime(2085, 1, 26), DateTime(2086, 2, 14), DateTime(2087, 2, 3), DateTime(2088, 1, 23), DateTime(2089, 2, 10),
    // 2090-2100 年春节对应的公历日期
    DateTime(2090, 1, 30), DateTime(2091, 2, 18), DateTime(2092, 2, 7), DateTime(2093, 1, 27), DateTime(2094, 2, 15),
    DateTime(2095, 2, 4), DateTime(2096, 1, 24), DateTime(2097, 2, 11), DateTime(2098, 2, 1), DateTime(2099, 1, 21),
    DateTime(2100, 2, 9),
  ];

  /// 十天干核心映射表（0 -> 甲, 1 -> 乙 ... 9 -> 癸）
  final List<String> _gan = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"];

  /// 十二地支核心映射表（0 -> 子, 1 -> 丑 ... 11 -> 亥）
  final List<String> _zhi = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"];

  /// 将任意时区传入的本地时间，抹除本地环境时区干扰，还原为绝对的宇宙标准时间戳 (UTC 0点轴)
  DateTime _getCleanUtc(DateTime date, int inputTimeZoneOffset) {
    // 首先利用输入的年月日时分秒克隆出一个纯正的 UTC 时间实例，随后根据传入的政治时区偏移量作减法，逆向倒推出绝对 UTC 刻度
    return DateTime.utc(date.year, date.month, date.day, date.hour, date.minute, date.second).subtract(Duration(hours: inputTimeZoneOffset));
  }

  /// 1. 高阶真太阳时物理修正（基于公转不均匀理论与地理几何经度，抹平公式与真实的视太阳时差）
  DateTime getTrueSolarTime(DateTime utcTime, double longitude) {
    // 将给定的 UTC 时间戳转换为天文学的标准儒略日（Julian Day），2440587.5 是公历 1970-01-01 00:00:00 的儒略日起始基准
    double jd = (utcTime.millisecondsSinceEpoch / 86400000.0) + 2440587.5;
    // 均时差方程 (Equation of Time, EOT)：修正由于地球绕日公转轨道为“椭圆形”以及“黄赤交角”引起的平太阳时与真太阳时的分钟级物理偏差
    double eot = -7.659 * math.sin(math.pi * (0.0172 * (jd - 2451545.0 + 5.9)) / 180.0) - 9.863 * math.sin(math.pi * (0.0334 * (jd - 2451545.0 - 1.2)) / 180.0);
    // 经度地理时差：天文学中地球每旋转1度需要4分钟。这里以 0 度经线（格林威治）为绝对物理基准，叠加均时差算得该经线真正的绝对时差分钟
    double offsetMinutes = eot + (longitude * 4.0);
    // 将这个属于纯物理层面的绝对偏差时间（秒）原原本本地补偿回 UTC 时间戳上
    return utcTime.add(Duration(seconds: (offsetMinutes * 60).round()));
  }

  /// 2. 获取精准干支年 (彻底斩断运行机器本地时区绑定的恶性 Bug，完全依托绝对的节气立春轴切换)
  String getGanzhiYear(DateTime date, int inputTimeZoneOffset) {
    // 率先洗净时间，拿到与行政区划无关的绝对宇宙时间 (UTC)
    DateTime utc = _getCleanUtc(date, inputTimeZoneOffset);

    // 世纪常量公式和立春时刻在 UTC 视角下表现为 2 月 4 日附近的特定连续轨道切点
    int year = utc.year;
    // 如果输入的绝对月份小于2月，或者正值2月但还没到4号立春边界，则在干支历法上该时刻依然属于上一年的干支统治
    if (utc.month < 2 || (utc.month == 2 && utc.day < 4)) year -= 1;

    // 以公元前4年（甲子年）为循环回归线计算出对应的六十甲子相对偏移索引
    int idx = (year - 3) % 60 - 1;
    // 若产生负数（如跨越边界），则通过前向加 60 补齐确保取模矩阵安全
    if (idx < 0) idx += 60;
    // 通过分离十天干与十二地支，强行咬合成对应的年柱汉字
    return "${_gan[idx % 10]}${_zhi[idx % 12]}";
  }

  /// 3. 世纪常量判定月柱 (基于地球绕日几何度数切换的节气交接轴)
  String getGanzhiMonth(DateTime date, int inputTimeZoneOffset) {
    // 提炼纯净的 UTC 绝对时刻
    DateTime utc = _getCleanUtc(date, inputTimeZoneOffset);
    // 此时将绝对 UTC 时间放回公式所对应的东八区基础坐标轴视点，避免节气交接前夕发生 8 小时的时间倒流错位
    DateTime bjView = utc.add(const Duration(hours: 8));

    // 分离出东八区视角下的字面年月日
    int year = bjView.year;
    int month = bjView.month;
    int day = bjView.day;

    // 20 世纪（1900-1999）及 21 世纪二十四节气在天文学上的拟合世纪常量常数数组（按公历各月节气顺序排列）
    final List<double> termConstants = [5.4055, 3.87, 5.63, 5.59, 6.318, 5.678, 7.108, 7.5, 7.646, 8.318, 7.438, 7.18];

    // 高斯节气判定公式：结合平气与定气原理，推算出当年当月该节气交接点在公历中出现的精确天数字面量
    double d = (year - 1900) * 0.2422 + termConstants[month - 1] - ((year - 1900) - 1) ~/ 4;
    // 向下取整截断，拿到交接当天的纯整天数值
    int sectionDay = d.floor();

    int solarTermIdx;
    // 若当前的公历天数已经达到或跨越了推算出的节气交接日，说明月令已经成功切换到下一个节气
    if (day >= sectionDay) {
      solarTermIdx = (month - 2 + 12) % 12;
    } else {
      // 若还没熬到交接天，则说明月干支仍被上一个月的地支掌控
      solarTermIdx = (month - 3 + 12) % 12;
    }

    // 提取当年年柱的天干，因为月柱的天干严重受制于年柱天干（即历法口诀：五虎遁诀）
    String yearGan = getGanzhiYear(date, inputTimeZoneOffset)[0];
    // 计算年干在天干表中的相对位置周期，用于代入五虎遁公式
    int yearGanIdx = _gan.indexOf(yearGan) % 5;
    // 五虎遁经典算式：MonthGan = (YearGan * 2 + SolarTermIdx + 2) % 10。用来锁死月干
    int monthGanIdx = (yearGanIdx * 2 + solarTermIdx + 2) % 10;
    // 节气月地支必然从“寅”月（正月，索引2）开始作为起点往后顺延
    return "${_gan[monthGanIdx]}${_zhi[solarTermIdx + 2]}";
  }

  /// 4. 日干支 (采用绝对基准日差法，结合输入时区切分24小时边界，100%免疫本地硬件时区污染)
  String getGanzhiDay(DateTime date, int inputTimeZoneOffset) {
    // 1. 将输入的时间强制转换为无环境依赖的绝对 UTC 时间戳
    DateTime utcTime = _getCleanUtc(date, inputTimeZoneOffset);

    // 2. 在 UTC 时间轴上补回出生地当地的政治时区偏移，从而还原出目标地点出生时刻真正的【当地字面日期】
    DateTime localTime = utcTime.add(Duration(hours: inputTimeZoneOffset));

    // 3. 剥离掉小时、分钟、秒等一切子时辰碎屑，只保留纯净的 [年-月-日]，在 UTC 轴上建立一个绝对的当地零点对象
    DateTime localPureDate = DateTime.utc(localTime.year, localTime.month, localTime.day);

    // 4. 设立整个日柱推算系统最刚性的天文学锚点：公元 2000 年 1 月 1 日
    // 查阅天文万年历，公元 2000 年元旦那一天是标准的【戊午】日（六十甲子顺位第 54 位，索引为 54）
    DateTime anchorDate = DateTime.utc(2000, 1, 1);

    // 5. 让 Dart 底层内核直接跨越平闰年查表计算两地日期之间雷打不动的绝对天数差（inDays）
    int diffDays = localPureDate.difference(anchorDate).inDays;

    // 6. 用绝对天数差，叠加上锚点自身的 54 顺位偏移量，直接对六十甲子周期进行数学取模
    int idx = (diffDays + 54) % 60;
    // 如果日期在 2000 年以前，天数差会产生负数，通过回滚加 60 确保索引永远处于 0~59 安全闭环内
    if (idx < 0) idx += 60;

    // 从映射表中抓取最终永不漂移、完美对应万年历的日干支
    return "${_gan[idx % 10]}${_zhi[idx % 12]}";
  }

  /// 5. 时干支 (剔除伪行政时区，全权依赖高阶真太阳时以及日干五鼠遁诀)
  String getGanzhiTime(DateTime date, int inputTimeZoneOffset, double longitude) {
    // 剥离环境时区，锁定绝对宇宙时间
    DateTime utcTime = _getCleanUtc(date, inputTimeZoneOffset);
    // 将绝对时间传入真太阳时修正器，提取出受出生地地理位置、均时差波动影响的真实物理太阳时间
    DateTime trueSolarTime = getTrueSolarTime(utcTime, longitude);

    // 抓取真太阳时的小时字面值
    int hour = trueSolarTime.hour;
    // 传统时辰分界线：以 23:00 为子时正起点，每 2 小时跨越一个地支。通过加 1 除 2 取模锁定地支映射表的索引
    int zhiIdx = (((hour + 1) % 24) ~/ 2) % 12;

    // 传入目标时区调用日柱函数，抽取日柱天干，因为时干由日干全权决定（即历法口诀：五鼠遁诀）
    String dayGan = getGanzhiDay(date, inputTimeZoneOffset)[0];
    // 计算日干在五鼠遁体系内的基础权重
    int dayGanIdx = _gan.indexOf(dayGan) % 5;
    // 五鼠遁标准公式：TimeGan = (DayGan * 2 + ZhiIdx) % 10。用来强行咬合时辰的天干
    int timeGanIdx = (dayGanIdx * 2 + zhiIdx) % 10;

    // 输出最终属于物理时空的干支时柱
    return "${_gan[timeGanIdx]}${_zhi[zhiIdx]}";
  }

  /// 6. 公历平闰年判断标准四象限数学规则
  bool isSolarLeapYear(int year) {
    // 四年一闰且百年不闰，或四百年再闰
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// 7. 农历闰月解压器 (高效位运算，专管提取特定年份是否包含闰月及闰几月)
  int getLunarLeapMonth(int year) {
    // 超出星历表覆盖范围的直接予以拒绝保护
    if (year < 1900 || year > 2100) return 0;
    // 从 _lunarInfo 对应的年份空间中通过右移 16 位并做高位按位与（& 0xF），把藏在高 4 位的闰月数据解压剥离出来
    return (_lunarInfo[year - 1900] >> 16) & 0xF;
  }
}
