import 'package:flutter/material.dart';

class Store extends StatefulWidget {

  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {

  static final TextStyle _textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

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
        title: Text("매장현황"),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이콘과 "오늘 매출"을 왼쪽에, "1,000,000원"을 오른쪽에 배치
                  children: [
                    Row(
                      children: [
                        Icon(Icons.monetization_on, size: 16, color: Colors.green,),
                        Text('오늘 매출 :', style: _textStyle),
                      ],
                    ),
                    Text('1,000,000원', style: _textStyle),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이콘과 "오늘 매출"을 왼쪽에, "1,000,000원"을 오른쪽에 배치
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_alarms, size: 16),
                        Text('웨이팅 현황 :', style: _textStyle),
                      ],
                    ),
                    Text('12팀', style: _textStyle),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이콘과 "오늘 매출"을 왼쪽에, "1,000,000원"을 오른쪽에 배치
                  children: [
                    Row(
                      children: [
                        Icon(Icons.table_bar, size: 16, color: Colors.brown,),
                        Text('테이블 현황(사용/전체) :', style: _textStyle),
                      ],
                    ),
                    Text('7/10개', style: _textStyle),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(10), color: Colors.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('테이블 01', style: _textStyle),
                    Text('주문금액 : 50,000원', style: _textStyle),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(10), color: Colors.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('테이블 02', style: _textStyle),
                    Text('주문금액 : 30,000원', style: _textStyle),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(10), color: Colors.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('테이블 03', style: _textStyle),
                    Text('주문금액 : 20,000원', style: _textStyle),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(10), color: Colors.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('테이블 04', style: _textStyle),
                    Text('주문금액 : 40,000원', style: _textStyle),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(10), color: Colors.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('테이블 05', style: _textStyle),
                    Text('주문금액 : 10,000원', style: _textStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
