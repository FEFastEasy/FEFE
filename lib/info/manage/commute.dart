import 'package:flutter/material.dart';
import '../manage/commutelist.dart';

class Commute extends StatefulWidget {

  const Commute({Key? key}) : super(key: key);

  @override
  State<Commute> createState() => _CommuteState();
}

class _CommuteState extends State<Commute> {

  // 공통 스타일 상수
  static final BoxDecoration _boxDecoration = BoxDecoration(
    color: Color(0xfffae100),
    borderRadius: BorderRadius.circular(15),
  );

  static final TextStyle _textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // 공통 위젯 생성 함수
  Widget _buildItem(BuildContext context, String title, Widget page) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      tileColor: Color(0xfffae100),
      title: Container(
        decoration: _boxDecoration,
        child: Center(
            child: Text(title, style: _textStyle)
        ),
      ),
    );
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
        title: Text("출퇴근 등록"),
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
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 40),
              _buildItem(context, '출근', Commutelist()),
              SizedBox(height: 20),
              _buildItem(context, '출퇴근 기록', Commutelist()),
              SizedBox(height: 20),
              _buildItem(context, '퇴근', Commutelist()),
            ],
          ),
        ),
      ),
    );
  }
}
