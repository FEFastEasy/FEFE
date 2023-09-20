import 'package:flutter/material.dart';
import '../info/info.dart';
import '../order/order.dart';
import '../cart/pay.dart';
import '../main.dart';

class Cart extends StatefulWidget {
  final List<Map<String, dynamic>> selectedMenus; // 선택된 메뉴들의 정보를 받을 변수

  const Cart({Key? key, required this.selectedMenus}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int _currentIndex = 2;
  late List<Map<String, dynamic>> nonZeroQuantityMenu; // 0 초과 메뉴를 저장할 변수

  void _navigateToPage(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MyHome()));
          break;
        case 3:
          _currentIndex = 3; // '메뉴' 클릭 시 _currentIndex를 3으로 설정
          Navigator.pop(
              context, MaterialPageRoute(builder: (context) => Order(message: "message")));
          break;
        case 4:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Info()));
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
              Navigator.pop(context);
            },
            child: Text(
              '메뉴추가',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
        title: Text("주문목록"),
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
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedMenus.length,
                itemExtent: 100.0,
                padding: EdgeInsets.all(3),
                itemBuilder: (context, index) {
                  final menuItem = widget.selectedMenus[index];
                  return ListTile(
                    contentPadding: EdgeInsets.all(3),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white70,
                        width: 1.0,
                      ),
                    ),
                    leading: Container(
                      width: MediaQuery.of(context).size.width / 6,
                      height: MediaQuery.of(context).size.height / 1,
                      margin: EdgeInsets.zero,
                      color: Colors.blue,
                      child: Center(
                        child: Text('Image'),
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            menuItem['menuName'] ?? '', // 각 메뉴의 이름 가져오기
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 80,
                                height:
                                MediaQuery.of(context).size.height / 30,
                                alignment: Alignment.centerLeft,
                                color: Color(0xffFEE500),
                                child: Text(
                                  menuItem['menuPrice'].toString(), // 각 메뉴의 가격 가져오기,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height:
                                MediaQuery.of(context).size.height / 30,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '수량 :',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        menuItem['quantity'].toString(), // 각 메뉴의 수량 가져오기
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Color(0xffFEE500),
                  borderRadius:
                  BorderRadius.circular(15.0),
                ),
               child: Column(
                 children: [
                   TextButton(
                     onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => Pay()));
                     },
                     child: Text('결제하기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                   ),
                 ],
              ),
              ),
              ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                height: 30,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
        _currentIndex == 2 ? Colors.yellowAccent : Colors.yellow,
        child: Icon(Icons.credit_card, color: Colors.black),
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