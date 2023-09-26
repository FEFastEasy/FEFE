import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class MenuItem {
  String name;
  String category;
  double price;
  XFile? image; // 각 메뉴 항목에 대한 이미지

  MenuItem({
    required this.name,
    required this.category,
    required this.price,
    this.image,
  });
}

class _MenuState extends State<Menu> {
  // 카테고리를 저장할 리스트
  List<String> category = [];
  List<MenuItem> menuItems = []; // MenuItem 객체를 저장하는 리스트

  String _categoryNameError = ''; // 카테고리 이름 오류 메시지 저장 변수

  // 새로운 메뉴 추가 다이얼로그 내에서 선택한 이미지를 저장할 변수
  XFile? _newMenuItemImage;
  XFile? _storeImage; // 가게 이미지 파일을 저장할 변수
  XFile? _menuImage; // 메뉴 이미지 파일을 저장할 변수

  // 가게 이미지 선택을 위한 함수
  Future<void> _selectStoreImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _storeImage = pickedImage;
      });
    }
  }

  // 메뉴 이미지 선택을 위한 함수
  Future<void> _selectMenuImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _menuImage = pickedImage;
      });
    }
  }

// 하단의 추가 버튼을 눌렀을 때 호출되는 함수
  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newCategory = ''; // 새로운 카테고리 이름을 저장할 변수
        return AlertDialog(
          title: Text('새로운 카테고리 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newCategory = value;
                  // 카테고리 이름 길이 검사
                  if (newCategory.length > 4) {
                    setState(() {
                      _categoryNameError = '카테고리 이름은 4글자 이하여야 합니다.';
                    });
                  } else {
                    setState(() {
                      _categoryNameError = '';
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: '카테고리 이름',
                  labelStyle: TextStyle(color: Colors.blue), // 라벨 텍스트 색상
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                if (newCategory.isNotEmpty) {
                  if (newCategory.length > 4) {
                    // 5글자 이상인 경우 알림을 띄우고 다이얼로그는 닫지 않음
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('카테고리 이름은 4글자 이하여야 합니다.'),
                      ),
                    );
                  } else {
                    setState(() {
                      category.add(newCategory); // 새로운 카테고리를 추가
                    });
                    Navigator.pop(context); // 다이얼로그 닫기
                  }
                }
              },
              child: Text('추가'),
            ),
          ],
        );
      },
    );
  }

  void _showEditCategoryDialog(int index) {
    String editedCategory = category[index]; // 선택한 카테고리 이름을 초기값으로 설정

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('카테고리 이름 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  editedCategory = value;
                  // 카테고리 이름 길이 검사
                  if (editedCategory.length > 4) {
                    setState(() {
                      _categoryNameError = '카테고리 이름은 4글자 이하여야 합니다.';
                    });
                  } else {
                    setState(() {
                      _categoryNameError = '';
                    });
                  }
                },
                controller: TextEditingController(text: category[index]),
                // 현재 카테고리 이름으로 초기화
                decoration: InputDecoration(
                  labelText: '수정할 카테고리 이름',
                  labelStyle: TextStyle(color: Colors.blue), // 라벨 텍스트 색상
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 삭제 버튼을 누르면 해당 카테고리를 삭제
                setState(() {
                  category.removeAt(index);
                });
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: Text(
                '삭제',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (editedCategory.isNotEmpty) {
                  if (editedCategory.length > 4) {
                    // 5글자 이상인 경우 알림을 띄우고 다이얼로그는 닫지 않음
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('카테고리 이름은 4글자 이하여야 합니다.'),
                      ),
                    );
                  } else {
                    setState(() {
                      category.add(editedCategory); // 새로운 카테고리를 추가
                    });
                    Navigator.pop(context); // 다이얼로그 닫기
                  }
                }
              },
              child: Text('저장'),
            ),
          ],
        );
      },
    );
  }

// '+ 버튼을 누르면 호출되는 함수
  void _showAddMenuItemDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    String selectedCategory = category.isNotEmpty ? category.first : '';
    XFile? menuItemImage; // 메뉴 항목 이미지

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('새로운 메뉴 추가'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이미지'),
                InkWell(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

                    if (pickedImage != null) {
                      setState(() {
                        menuItemImage = pickedImage; // 선택한 이미지 업데이트
                      });
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffFEE500),
                    ),
                    child: Center(
                      child: menuItemImage != null
                          ? Image.file(
                              File(menuItemImage!.path),
                              width: 60,
                              height: 60,
                            )
                          : Icon(
                              Icons.add_a_photo,
                              size: 30,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('메뉴 이름:'),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: '메뉴 이름 입력',
                  ),
                ),
                SizedBox(height: 10),
                Text('가격:'),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(
                    hintText: '가격 입력 (숫자만 입력)',
                  ),
                ),
                SizedBox(height: 10),
                Text('카테고리 선택:'),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: category.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                final String name = nameController.text;
                final String priceText = priceController.text;
                final double? price = double.tryParse(priceText);

                if (name.isNotEmpty && price != null) {
                  setState(() {
                    menuItems.add(MenuItem(
                      name: name,
                      category: selectedCategory,
                      price: price,
                      image: menuItemImage, // 선택한 이미지 업데이트
                    ));
                  });

                  Navigator.pop(context);
                }
              },
              child: Text('추가'),
            ),
          ],
        );
      },
    );
  }

  // 메뉴 항목을 클릭하여 수정 다이얼로그를 열기 위한 함수
  void _showEditMenuItemDialog(int index) async {
    final MenuItem selectedItem = menuItems[index]; // 선택된 메뉴 항목 가져오기

    // 메뉴 항목의 정보 가져오기
    String selectedName = selectedItem.name;
    String selectedCategory = selectedItem.category;
    double selectedPrice = selectedItem.price;

    // 컨트롤러 초기화
    TextEditingController nameController =
        TextEditingController(text: selectedName);
    TextEditingController priceController =
        TextEditingController(text: selectedPrice.toString());

    // Define variables for the new image and image path
    XFile? newImage;
    String? newImagePath;

    // Check if the user wants to change the image
    bool changeImage = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('메뉴 수정'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이미지'),
                // 이미지 선택 UI는 수정되지 않아도 됩니다.
                InkWell(
                  onTap: _selectMenuImage, // 이미지 선택 함수 호출
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffFEE500),
                    ),
                    child: Center(
                      child: changeImage
                          ? Image.file(
                              File(newImage!.path),
                              width: 60,
                              height: 60,
                            )
                          : Icon(
                              Icons.add_a_photo,
                              size: 30,
                            ),
                    ),
                  ),
                ),
                Text('메뉴 이름:'),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: '메뉴 이름 입력',
                  ),
                ),
                SizedBox(height: 10),
                Text('가격:'),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  // 소수점 입력 불가
                  // 소수점 입력 제한
                  decoration: InputDecoration(
                    hintText: '가격 입력 (숫자만 입력)',
                  ),
                ),
                SizedBox(height: 10),
                Text('카테고리 선택:'),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: category.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 수정된 내용을 저장하고 다이얼로그 닫기
                final String name = nameController.text;
                final String priceText = priceController.text;
                final double? price = double.tryParse(priceText);

                if (name.isNotEmpty && price != null) {
                  String updatedItem = '$name $selectedCategory $price';

                  if (changeImage && newImage != null) {
                    // If the user changed the image, update the image path
                    newImagePath = newImage.path;
                  } else {
                    // If the user didn't change the image, keep the existing image path
                    newImagePath = _menuImage?.path;
                  }

                  // Update menu item with new data, including the image path
                  setState(() {
                    menuItems[index].name = name;
                    menuItems[index].category = selectedCategory;
                    menuItems[index].price = price;
                    if (changeImage && newImage != null) {
                      // If the user changed the image, update the image path
                      menuItems[index].image = XFile(newImage!.path);
                    } else {
                      // If the user didn't change the image, keep the existing image path
                      menuItems[index].image = _menuImage;
                    }
                  });

                  Navigator.pop(context);
                }
              },
              child: Text('저장'),
            ),
          ],
        );
      },
    );
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
        title: Text("메뉴관리"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xff000000),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Color(0xfffae100),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Divider(
              color: Colors.grey, // 회색 구분선 색상 설정
              thickness: 1.0, // 구분선 두께 설정
            ),
            Center(
                child: Text('가게 이미지 설정',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Divider(
              color: Colors.grey, // 회색 구분선 색상 설정
              thickness: 1.0, // 구분선 두께 설정
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: _selectStoreImage, // 가게 이미지 선택 함수 호출
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffFEE500),
                ),
                child: Center(
                  child: _storeImage != null
                      ? Image.file(
                          File(_storeImage!.path),
                          width: 100,
                          height: MediaQuery.of(context).size.height / 8,
                        )
                      : Icon(
                          Icons.add_a_photo,
                          size: 50,
                        ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.grey, // 회색 구분선 색상 설정
              thickness: 1.0, // 구분선 두께 설정
            ),
            Center(
                child: Text('가게 메뉴 설정',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Divider(
              color: Colors.grey, // 회색 구분선 색상 설정
              thickness: 1.0, // 구분선 두께 설정
            ),
            Row(children: [
              Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 5,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Center(
                      child: Text('카테고리',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)))),
              Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Center(
                      child: Text('메뉴',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)))),
            ]),
            SizedBox(height: 10),
            Expanded(
              // Added Expanded
              child: ListView(
                // Use ListView for Scrollable Content
                scrollDirection: Axis.horizontal, // 가로 스크롤
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: ListView.builder(
                      itemCount: category.length + 1, // itemCount를 +1 해줌
                      itemExtent: 50.0, // 각 항목의 높이 설정
                      itemBuilder: (context, index) {
                        if (index == category.length) {
                          // 마지막 항목일 때 IconButton을 표시
                          return ListTile(
                            title: IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: _showAddCategoryDialog,
                            ),
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey), // 테두리 스타일 지정
                            ),
                            child: ListTile(
                              title: GestureDetector(
                                onTap: () {
                                  _showEditCategoryDialog(
                                      index); // 카테고리를 클릭하면 수정 다이얼로그를 표시
                                },
                                child: Text(
                                  category[index],
                                  maxLines: 1, // 최대 1줄까지 표시
                                  style: TextStyle(
                                    fontSize: 16,
                                    overflow: TextOverflow
                                        .ellipsis, // 글자가 넘칠 때 생략 부호 (...) 표시
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    child: ListView.builder(
                      itemCount: menuItems.length + 1,
                      itemExtent: 140.0,
                      itemBuilder: (context, index) {
                        if (index == menuItems.length) {
                          return ListTile(
                            title: IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: _showAddMenuItemDialog,
                            ),
                          );
                        } else {
                          final MenuItem menuItem = menuItems[index];
                          final XFile? menuItemImage = menuItem.image;

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _showEditMenuItemDialog(index);
                              },
                              child: ListTile(
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    margin: EdgeInsets.only(top: 5),
                                    color: Colors.grey,
                                    child: menuItemImage != null
                                        ? Image.file(
                                            File(menuItemImage.path),
                                            fit: BoxFit.fill,
                                          )
                                        : Center(
                                            child: Text('준비중'),
                                          ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 120,
                                    height: 120,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            menuItem.name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            menuItem.category,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            menuItem.price.toStringAsFixed(0) +
                                                "원",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
