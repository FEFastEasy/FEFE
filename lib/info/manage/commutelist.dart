import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // intl 패키지 추가

class Commutelist extends StatefulWidget {
  const Commutelist({Key? key}) : super(key: key);

  @override
  State<Commutelist> createState() => _CommutelistState();
}

class WorkRecord {
  final String startDay;
  final String startTime;
  final String endTime;

  WorkRecord(this.startTime, this.endTime)
      : startDay = "$startTime".substring(0, 8); // 날짜 부분 추출하여 초기화
}

// 실제 데이터를 생성합니다.
List<WorkRecord> workRecords = [
  WorkRecord("23/09/01 09:00", "23/09/01 18:00"),
  WorkRecord("23/09/02 10:00", "23/09/03 01:00"),
  WorkRecord("23/09/03 07:00", "23/09/03 21:00"), // 수정: startDay 값을 포함
  // 원하는 만큼 데이터를 추가할 수 있습니다.
];

class _CommutelistState extends State<Commutelist> {
  static final TextStyle _textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  String getWorkingHours(String startTime, String endTime) {
    // 날짜와 시간을 "yyyy-MM-dd HH:mm:ss" 형식으로 변환
    final startDateTime = DateFormat("yy/MM/dd HH:mm").parse("$startTime");
    final endDateTime = DateFormat("yy/MM/dd HH:mm").parse("$endTime");

    // 두 시간 사이의 차를 계산합니다.
    final Duration difference = endDateTime.difference(startDateTime);

    // 시간과 분으로 나누어 표시합니다.
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    return '$hours시간 $minutes분';
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
        title: Text("출퇴근 기록"),
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
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 20),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 40),
              buildHoursRow("일 근무시간", "8시간", "평균 : ", Colors.green),
              buildHoursRow("주 근무시간", "40시간", "평균 : ", Colors.green),
              buildHoursRow("월 근무시간", "180시간", "평균 : ", Colors.green),
              buildHoursRow("연 근무시간", "2,000시간", "평균 : ", Colors.green),
              SizedBox(height: 20),
              Container(
                color: Colors.blueAccent,
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Center(
                        child: Text('근무일자', style: _textStyle),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Center(
                        child: Text('근무시간', style: _textStyle),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Center(
                        child: Text('출근시간', style: _textStyle),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Center(
                        child: Text('퇴근시간', style: _textStyle),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: workRecords.length,
                shrinkWrap: true, // 리스트뷰가 필요한 공간만 차지하도록 설정
                physics: NeverScrollableScrollPhysics(), // 스크롤 금지
                itemBuilder: (context, index) {
                  final record = workRecords[index];
                  return Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // 테두리 색상
                        width: 1.0, // 테두리 너비
                      ),// 테두리 모서리 둥글기
                    ),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Container(
                            height: 38,
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(
                              child: Text(
                              "${record.startDay}",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ),
                          Container(
                            height: 38,
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(
                              child: Text(
                              "${getWorkingHours(record.startTime, record.endTime)}",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ),
                          Container(
                            height: 38,
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(
                              child: Text(
                              "${record.startTime}",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ),
                          Container(
                            height: 38,
                            width: MediaQuery.of(context).size.width / 5,
                            child: Center(
                              child: Text(
                              "${record.endTime}",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHoursRow(
      String title, String value, String change, Color iconColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: iconColor),
              Text(' $title :', style: _textStyle),
            ],
          ),
          Text('$value ($change)', style: _textStyle),
        ],
      ),
    );
  }
}
