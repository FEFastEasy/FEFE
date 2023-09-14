import 'package:flutter/material.dart';
import '../login/login.dart';
import '../info/infoedit.dart';
import '../order/order.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int _currentIndex = 0;

  void _navigateToPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _navigateToPage(Login());
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                _navigateToPage(Infoedit());
              },
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
                  "내정보 편집",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _currentIndex == 2 ? Colors.yellowAccent : Colors.yellow,
        child: Icon(Icons.shopping_bag_outlined, color: Colors.black),
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
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
          currentIndex: _currentIndex,
          backgroundColor: Colors.yellow,
          selectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            _buildBottomNavigationBarItem(Icons.qr_code, '스캔'),
            _buildBottomNavigationBarItem(Icons.search, '검색'),
            _buildBottomNavigationBarItem(Icons.home, '장바구니'),
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
        child: IconButton(
          onPressed: () {
            if (_currentIndex != 4) {
              _navigateToPage(_currentIndex == 3 ? Order(message: "message") : Info());
            }
          },
          icon: Icon(icon),
        ),
      ),
      label: label,
    );
  }
}
