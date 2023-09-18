import 'package:flutter/material.dart';
import '../info/info.dart';
import '../main.dart';
import '../order/review.dart';

class Order extends StatefulWidget {
  const Order({Key? key, required String message}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int _currentIndex = 2;
  var category = ['신메뉴', '추천', '메인', '세트', '주류', '직원호출'];

  void _navigateToPage(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHome()));
          break;
        case 4:
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Info()));
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 8, // 전체 세로 화면 높이의 8분의 1,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xff7f7f7f),
            ),
            child: Center(
              child: Text(
                "광고",
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffFEE500),
            ),
            child: Center(
              child: Text(
                "가게",
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHome()));
                },
                child: Text("메뉴"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Review()));
                },
                child: Text("리뷰"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHome()));
                },
                child: Text("정보"),
              ),
            ],
          ),
          Expanded( // Added Expanded
            child: ListView( // Use ListView for Scrollable Content
              scrollDirection: Axis.horizontal, // 가로 스크롤
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6, // 가로 너비 지정
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(category[index]),
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*5 / 6, // 가로 너비 지정
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('List 2 - Item $index'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _currentIndex == 2 ? Colors.yellowAccent : Colors.yellow,
        child: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
        onPressed: () {
          _navigateToPage(2);
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
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
            _buildBottomNavigationBarItem(Icons.home, '결제'),
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
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}