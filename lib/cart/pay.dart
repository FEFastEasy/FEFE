import 'package:flutter/material.dart';

class Pay extends StatefulWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  List<Map<String, dynamic>> paymentMethods = [
    {'label': '네이버페이', 'iconData': Icons.payment, 'color': Colors.green},
    {'label': '카카오페이', 'iconData': Icons.payment, 'color': Colors.yellow},
    {'label': '구글페이', 'iconData': Icons.payment, 'color': Colors.white},
    {'label': '애플페이', 'iconData': Icons.payment, 'color': Colors.grey},
  ];

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
        title: Text("결제하기"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xff000000),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Color(0xfffae100),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          height: 30,
          alignment: Alignment.center,
          child: Text(
            '결제수단 선택',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.0),
        Expanded(
          // Added Expanded
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 그리드의 열 수 (2열)
            ),
            itemCount: paymentMethods.length, // 결제수단의 개수에 따라 조정
            itemBuilder: (context, index) {
              final paymentMethod = paymentMethods[index];
              return GestureDetector(
                onTap: () {
                  // 선택한 결제수단 처리 로직 추가
                },
                child: Container(
                  height: 20,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    color: paymentMethod['color'],
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 결제수단 아이콘
                      Icon(paymentMethod['iconData'], size: 36.0),
                      // 'iconData'를 키로 사용
                      SizedBox(width: 5.0),
                      // 결제수단 레이블
                      Text(paymentMethod['label'], style: TextStyle(fontSize: 20)),
                      // 'label'을 키로 사용
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 40),
            decoration: BoxDecoration(
              color: Color(0xffFEE500),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Pay()));
                },
                child: Text('결제하기',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
