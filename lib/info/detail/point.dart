import 'package:flutter/material.dart';

class Point extends StatefulWidget {

  const Point({Key? key}) : super(key: key);

  @override
  State<Point> createState() => _PointState();
}

class _PointState extends State<Point> {

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
        title: Text("포인트"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xff000000),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Color(0xfffae100),
      ),
      body: Container(
        margin: EdgeInsets.all(2.0),
        child: Column(
          children: [
            Container(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
