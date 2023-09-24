import 'package:flutter/material.dart';
import '../login/login.dart';
import '../info/infoedit.dart';
import '../order/order.dart';
import '../cart/cart.dart';
import '../info/detail/orderlist.dart';
import '../info/detail/reviewlist.dart';
import '../info/detail/like.dart';
import '../info/detail/coupon.dart';
import '../info/detail/point.dart';
import '../info/detail/event.dart';
import '../info/detail/register.dart';
import '../info/detail/manage.dart';
import 'detail/announcement.dart';
import '../info/detail/cs.dart';
import '../info/detail/version.dart';
import '../info/detail/termslist.dart';
import '../main.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int _currentIndex = 4;

  void _navigateToPage(int index) {
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
            context,
            MaterialPageRoute(
              builder: (context) => Cart(selectedMenus: []),
            ),
          );
          break;
        case 3:
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Order(message: "message"))); // '메뉴'
          break;
        default:
          return;
      }
    }
  }

  void _navigateToReplacement(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              _buildProfileButton(),
              SizedBox(height: 20),
              _buildButtonRow(
                buttons: [
                  _buildNavigationButton("주문내역", () => _navigateToReplacement(Orderlist())),
                  _buildNavigationButton("리뷰내역", () => _navigateToReplacement(Reviewlist())),
                ],
              ),
              _buildButtonRow(
                buttons: [
                  _buildNavigationButton("찜한가게", () => _navigateToReplacement(Like())),
                  _buildNavigationButton("쿠폰함", () => _navigateToReplacement(Coupon())),
                ],
              ),
              _buildButtonRow(
                buttons: [
                  _buildNavigationButton("포인트", () => _navigateToReplacement(Point())),
                  _buildNavigationButton("이벤트", () => _navigateToReplacement(Event())),
                ],
              ),
              SizedBox(height: 20),
              _buildStoreButton("매장등록", () => _navigateToReplacement(Register())),
              SizedBox(height: 20),
              _buildStoreButton("매장관리", () => _navigateToReplacement(Manage())),
              SizedBox(height: 20),
              _buildButtonRow(
                buttons: [
                  _buildNavigationButton("공지사항", () => _navigateToReplacement(Announcement())),
                  _buildNavigationButton("고객센터", () => _navigateToReplacement(Cs())),
                ],
              ),
              _buildButtonRow(
                buttons: [
                  _buildNavigationButton("현재버전", () => _navigateToReplacement(Version())),
                  _buildNavigationButton("약관 및 정책", () => _navigateToReplacement(Termslist())),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Copyright FEFE in Korea, All Rights Reserved.'
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
        _currentIndex == 2 ? Colors.yellowAccent : Colors.yellow,
        child: Icon(Icons.credit_card, color: Color(0xff746c1b)),
        onPressed: () {
          _navigateToPage(2);
        },
      ),
    );
  }

  Widget _buildProfileButton() {
    return InkWell(
      onTap: () {
        _navigateToReplacement(Infoedit());
      },
      child: Container(
        padding: EdgeInsets.only(left: 20),
        height: 80,
        decoration: BoxDecoration(
          color: Color(0xfffae100),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Text('닉네임', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow({required List<Widget> buttons}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons,
      ),
    );
  }

  Widget _buildNavigationButton(String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 4 / 10,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)),
        child: Center(
          child: Text(label, style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  Widget _buildStoreButton(String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 8 / 10,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(label, style: TextStyle(fontSize: 20)),
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

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.symmetric(vertical: 1.0),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}