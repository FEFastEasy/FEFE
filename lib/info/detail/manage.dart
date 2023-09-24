import 'package:flutter/material.dart';
import '../infodetail/manage/analysis.dart';
import '../infodetail/manage/employee.dart';
import '../infodetail/manage/sales.dart';
import '../infodetail/manage/store.dart';

class Manage extends StatelessWidget {
  const Manage({Key? key}) : super(key: key);

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
        title: Text("매장관리", style: TextStyle(color: Color(0xff000000))),
        centerTitle: true,
        backgroundColor: Color(0xfffae100),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 40),
              _buildItem(context, '직원현황', Employee()),
              SizedBox(height: 20),
              _buildItem(context, '매장현황', Store()),
              SizedBox(height: 20),
              _buildItem(context, '매출현황', Sales()),
              SizedBox(height: 20),
              _buildItem(context, '고객분석', Analysis()),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
