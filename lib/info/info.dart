import 'package:flutter/material.dart';
import '../login/login.dart';
import '../info/infoedit.dart';
import '../order/order.dart';
import '../cart/cart.dart';
import '../main.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int _currentIndex = 4;

  void _navigateToPage(int index) {
    final Map<String, dynamic> data = {
    'menuName': '전달할 메뉴 이름',};
    // 다른 필요한 데이터도 추가 가능
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const MyHome()));
          break;
        case 2:
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Cart(selectedMenus: []),
            ),
          );
          break;
        case 3:
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Order(message: "message"))); // '메뉴'
          break;
        default:
          return;
      }
    }
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
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text(
              '로그인',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
        title: Text("내정보"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xff000000),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Color(0xfffae100),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInkWell("내정보 편집", () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Infoedit()));
            }),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _currentIndex == 2 ? Colors.yellowAccent : Colors.yellow,
        child: Icon(Icons.credit_card, color: Color(0xff746c1b)),
        onPressed: () {
          _navigateToPage(2);
        },
      ),
    );
  }

  Widget _buildInkWell(String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: kBottomNavigationBarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.yellow,
          selectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: _navigateToPage,
          items: [
            _buildBottomNavigationBarItem(Icons.qr_code, '스캔'),
            _buildBottomNavigationBarItem(Icons.search, '검색'),
            _buildBottomNavigationBarItem(Icons.credit_card, '결제'),
            _buildBottomNavigationBarItem(Icons.event, '메뉴'),
            _buildBottomNavigationBarItem(Icons.person, '정보'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.symmetric(vertical: 1.0),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
