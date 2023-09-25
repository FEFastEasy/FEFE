import 'package:flutter/material.dart';

class Employeeadd extends StatefulWidget {

  const Employeeadd({Key? key}) : super(key: key);

  @override
  State<Employeeadd> createState() => _EmployeeaddState();
}

class _EmployeeaddState extends State<Employeeadd> {

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
        title: Text("직원등록"),
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
            ],
          ),
        ),
      ),
    );
  }
}
