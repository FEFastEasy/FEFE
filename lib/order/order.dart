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
  var category = ['신메뉴', '추천', '메인', '세트', '주류', '호출'];
  var menu = [
    '생맥주',
    '김치찌개',
    '된장찌개',
    '순두부찌개',
    '고추장찌개',
    '제육볶음',
    '소불고기',
    '뚝배기불고기',
    '공기밥',
    '소주'
  ];
  List<int> _quantityList = List.filled(10, 0);

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
        case 4:
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Info()));
          break;
        default:
          break;
      }
    }
  }

  void _incrementQuantity(int index) {
    setState(() {
      _quantityList[index]++;
    });
  }

  void _decrementQuantity(int index) {
    if (_quantityList[index] > 0) {
      setState(() {
        _quantityList[index]--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // 수평 스크롤
            child: Row(
              children: [
                Container(
                  width:
                      MediaQuery.of(context).size.width / 1, // 광고 컨테이너의 너비 조정
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                    color: const Color(0xff7f7f7f),
                  ),
                  child: Center(
                    child: Text(
                      '광고1',
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                Container(
                  width:
                      MediaQuery.of(context).size.width / 1, // 광고 컨테이너의 너비 조정
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                    color: const Color(0xff7f7f7f),
                  ),
                  child: Center(
                    child: Text(
                      '광고2',
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ],
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
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const MyHome()));
                },
                child: Text("메뉴"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Review()));
                },
                child: Text("리뷰"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const MyHome()));
                },
                child: Text("정보"),
              ),
            ],
          ),
          Expanded(
            // Added Expanded
            child: ListView(
              // Use ListView for Scrollable Content
              scrollDirection: Axis.horizontal, // 가로 스크롤
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6, // 가로 너비 지정
                  child: ListView.builder(
                    itemCount: 6,
                    itemExtent: 50.0, // 각 항목의 높이 설정
                    padding: EdgeInsets.all(3),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          category[index],
                          style: TextStyle(fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.white70, width: 1.0), // 테두리 추가
                        ),
                        onTap: () {
                          // 탭 이벤트 처리
                        },
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 5 / 6, // 가로 너비 지정
                  child: ListView.builder(
                    itemCount: 10,
                    itemExtent: 100.0,
                    padding: EdgeInsets.all(3),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          menu[index],
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.all(3),
                        // 내용 주위의 패딩
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.white70, width: 1.0), // 테두리 추가
                        ),
                        onTap: () {
                          // 탭 이벤트 처리
                        },
                        leading: Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.height / 6,
                          color: Colors.blue,
                          child: Center(
                            child: Text('Image'),
                          ),
                        ),
                        // 다른 컨테이너 추가
                        subtitle: Container(
                          margin: EdgeInsets.fromLTRB(150, 45, 10, 0),
                          height: MediaQuery.of(context).size.height / 36,
                          decoration: BoxDecoration(
                            color: Color(0xffFEE500),
                            borderRadius:
                                BorderRadius.circular(15.0), // 각을 둥글게 하는 부분
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () => _decrementQuantity(index),
                                  icon: Icon(Icons.remove, size: 15, color: Colors.black),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                color: Colors.white,
                                child: Text('${_quantityList[index]}'),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () => _incrementQuantity(index),
                                  icon: Icon(Icons.add, size: 15, color: Colors.black,),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ),
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
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            _currentIndex == 2 ? Colors.yellowAccent : Colors.yellow,
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

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
