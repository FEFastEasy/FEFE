import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Sales extends StatefulWidget {
  const Sales({Key? key}) : super(key: key);

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {

  static final TextStyle _textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const Color primaryColor = Color(0xfffae100);
  static const Color barColorLeft = Color(0xff00fccf);
  static const Color barColorRight = Color(0xfffe3175);

  final double width = 7; // 그래프 하나당 넓이

  late List<BarChartGroupData> rawBarGroupsDay;
  late List<BarChartGroupData> rawBarGroupsWeek;
  late List<BarChartGroupData> rawBarGroupsMonth;
  late List<BarChartGroupData> showingBarGroupsDay;
  late List<BarChartGroupData> showingBarGroupsWeek;
  late List<BarChartGroupData> showingBarGroupsMonth;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final barGroup8 = makeGroupData(0, 5, 12);
    final barGroup9 = makeGroupData(1, 16, 12);
    final barGroup10 = makeGroupData(2, 18, 5);
    final barGroup11 = makeGroupData(3, 20, 16);
    final barGroup12 = makeGroupData(4, 17, 6);
    final barGroup13 = makeGroupData(5, 19, 1.5);

    final barGroup14 = makeGroupData(0, 10, 1.5);
    final barGroup15 = makeGroupData(1, 5, 12);
    final barGroup16 = makeGroupData(2, 16, 12);
    final barGroup17 = makeGroupData(3, 18, 5);
    final barGroup18 = makeGroupData(4, 20, 16);
    final barGroup19 = makeGroupData(5, 17, 6);
    final barGroup20 = makeGroupData(6, 19, 1.5);
    final barGroup21 = makeGroupData(7, 5, 12);
    final barGroup22 = makeGroupData(8, 16, 12);
    final barGroup23 = makeGroupData(9, 18, 5);
    final barGroup24 = makeGroupData(10, 20, 16);
    final barGroup25 = makeGroupData(11, 17, 6);

    final itemsday = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    final itemsweek = [
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
      barGroup13,
    ];

    final itemsmonth = [
      barGroup14,
      barGroup15,
      barGroup16,
      barGroup17,
      barGroup18,
      barGroup19,
      barGroup20,
      barGroup21,
      barGroup22,
      barGroup23,
      barGroup24,
      barGroup25,
    ];

    rawBarGroupsDay = itemsday;
    rawBarGroupsWeek = itemsweek;
    rawBarGroupsMonth = itemsmonth;

    showingBarGroupsDay = rawBarGroupsDay;
    showingBarGroupsWeek = rawBarGroupsWeek;
    showingBarGroupsMonth = rawBarGroupsMonth;
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_backspace),
          color: Colors.black,
        ),
        title: Text("매출현황"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xff000000),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Color(0xfffae100),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 40),
              buildSalesRow("오늘 매출", "1,000,000원", "+100,000원", Colors.green),
              buildSalesRow("이번달 매출", "10,000,000원", "+300,000원", Colors.green),
              buildSalesRow("올해 매출", "100,000,000원", "+700,000원", Colors.green),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(border: Border.all(width: 1), color: Color(
                    0xff203857)),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              '일매출 비교',
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: BarChart(
                            BarChartData(
                              maxY: 20,
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.grey,
                                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                    String y = rod.toY.toStringAsFixed(2); // Format the value as needed
                                    return BarTooltipItem(
                                      y,
                                      TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },                                ),
                                touchCallback: (FlTouchEvent event, response) {
                                  if (response == null || response.spot == null) {
                                    setState(() {
                                      touchedGroupIndex = -1;
                                      showingBarGroupsDay = List.of(rawBarGroupsDay);
                                    });
                                    return;
                                  }

                                  touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                                  setState(() {
                                    if (!event.isInterestedForInteractions) {
                                      touchedGroupIndex = -1;
                                      showingBarGroupsDay = List.of(rawBarGroupsDay);
                                      return;
                                    }
                                    showingBarGroupsDay = List.of(rawBarGroupsDay);
                                    if (touchedGroupIndex != -1) {
                                      var sum = 0.0;
                                      for (final rod
                                      in showingBarGroupsDay[touchedGroupIndex].barRods) {
                                        sum += rod.toY;
                                      }
                                      final avg = sum /
                                          showingBarGroupsDay[touchedGroupIndex]
                                              .barRods
                                              .length;

                                      showingBarGroupsDay[touchedGroupIndex] =
                                          showingBarGroupsDay[touchedGroupIndex].copyWith(
                                            barRods: showingBarGroupsDay[touchedGroupIndex]
                                                .barRods
                                                .map((rod) {
                                              return rod.copyWith(
                                                  toY: avg, color: Colors.purple);
                                            }).toList(),
                                          );
                                    }
                                  });
                                },
                              ),
                              titlesData: FlTitlesData( // 축 설정
                                show: true,
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ), // 오른쪽 축
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ), // 위쪽 축
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: bottomDayTitles,
                                    reservedSize: 42,
                                  ),
                                ), // 아래쪽 축
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 28,
                                    interval: 1,
                                    getTitlesWidget: leftTitles,
                                  ),
                                ),
                              ), // 왼쪽 축
                              borderData: FlBorderData(
                                show: false,
                              ),
                              barGroups: showingBarGroupsDay,
                              gridData: const FlGridData(show: true),
                            ),
                          ),
                        ),

                      ],
                    ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSalesRow(String title, String value, String change, Color iconColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.monetization_on, size: 16, color: iconColor),
              Text(' $title :', style: _textStyle),
            ],
          ),
          Text('$value ($change)', style: _textStyle),
        ],
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomDayTitles(double value, TitleMeta meta) {
    final titles = <String>['월', '화', '수', '목', '금', '토', '일'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  Widget bottomWeekTitles(double value, TitleMeta meta) {
    final titles = <String>['1주', '2주', '3주', '4주', '5주', '6주'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  Widget bottomMonthTitles(double value, TitleMeta meta) {
    final titles = <String>['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: barColorLeft,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: barColorRight,
          width: width,
        ),
      ],
    );
  }

  // 데이터를 표시하기 위한 위젯을 생성하는 함수
  Widget buildBarDataWidget(double value) {
    return Positioned(
      left: 0,
      right: 0,
      top: value + 1, // 데이터 표시 위치 조절
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value.toStringAsFixed(2), // 데이터 포맷을 원하는 형태로 수정
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          // 추가적인 데이터 표시 UI를 원하는 형태로 추가할 수 있습니다.
        ],
      ),
    );
  }

}