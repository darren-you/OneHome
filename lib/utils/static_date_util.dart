class StaticDateUtil {
  StaticDateUtil._();

  static const List<String> sexList = [
    "保密",
    "女",
    "男",
  ];

  static const Map<String, List<String>> majorDateList = {
    '保密': ['保密'],
    '计算机与软件学院': [
      '数字媒体技术',
      '人工智能',
      '数据科学与大数据技术',
      '软件工程',
      '计算机科学与技术',
      '网络工程',
      '移动应用开发',
      '云计算技术与应用'
    ],
    '电子信息学院': [
      '电子信息工程',
      '电子信息科学与技术',
      '通信工程',
      '物联网工程',
      '智能科学与技术',
      '物联网应用技术',
      '智能产品开发与应用',
      '信息安全技术应用',
      '专业设置'
    ],
    '智能制造学院': [
      '新媒体技术',
      '汽车服务工程',
      '智能工程与创意设计',
      '机器人工程',
      '机械电子工程',
      '机械设计制造及其自动化',
      '数字媒体技术',
      '智能互联网络技术',
      '工业机器人',
      '智能控制技术',
      '物联网工程技术',
      '机械设计与制造'
    ],
    '建筑学院': ['建筑学', '城乡规划', '工程造价', '工程管理'],
    '土木与环境工程学院': ['市政工程技术', '给排水工程技术', '给排水科学与工程', '建筑工程技术', '土木工程'],
    '文学与传媒学院': ['汉语言文学专业', '汉语国际教育专业', '新闻学专业', '广告学专业', '网络与新媒体专业', '行政管理专业'],
    '外国语学院': ['商务英语', '法语专业', '日语专业', '商务英语（专科）', '旅游英语（停招）', '英语专业'],
    '工商管理学院': ['人力资源管理', '市场营销', '文旅管理', '数据管理', '物流管理', '电子商务'],
    '财务会计学院': ['审计学', '会计学', '财务管理', '经济统计学', '大数据与会计', '大数据与审计'],
    '金融学院': ['金融学', '投资学', '保险学', '互联网金融', '国际经济与贸易', '国际商务', '金融管理', '互联网金融'],
    '艺术学院': ['广播电视编导', '播音与主持艺术', '表演', '视传与服装设计', '环境与产品设计'],
    '通识教育学院': [],
    '创新创业学院': [],
    '国际教育学院': [],
  };
}