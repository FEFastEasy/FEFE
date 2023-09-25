import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // 카테고리를 저장할 리스트
  List<String> category = [];
  List<String> menuname = [];
  List<String> menucate = [];
  List<String> menuprice = [];

  XFile? _image; // 선택된 이미지 파일을 저장할 변수

  // 이미지를 갤러리에서 선택하는 함수
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
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
                },
                decoration: InputDecoration(labelText: '카테고리 이름'),
              ),
              if (newCategory.length > 4)
                Text(
                  '카테고리 이름은 4글자 이하여야 합니다.',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newCategory.isNotEmpty && newCategory.length <= 4) {
                  setState(() {
                    category.add(newCategory); // 새로운 카테고리를 추가
                  });
                  Navigator.pop(context); // 다이얼로그 닫기
                }
              },
              child: Text('추가'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: Text('취소'),
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
          title: Text('카테고리 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  editedCategory = value;
                },
                controller: TextEditingController(text: category[index]), // 현재 카테고리 이름으로 초기화
                decoration: InputDecoration(labelText: '수정된 카테고리 이름'),
              ),
              if (editedCategory.length > 4)
                Text(
                  '카테고리 이름은 4글자 이하여야 합니다.',
                  style: TextStyle(color: Colors.red),
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
                if (editedCategory.isNotEmpty && editedCategory.length <= 4) {
                  setState(() {
                    category[index] = editedCategory; // 선택한 카테고리 이름 수정
                  });
                  Navigator.pop(context); // 다이얼로그 닫기
                }
              },
              child: Text('저장'),
            ),
          ],
        );
      },
    );
  }

// '+' 버튼을 누르면 호출되는 함수
  void _showAddMenuItemDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    String selectedCategory = category.isNotEmpty ? category.first : '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('새로운 메뉴 추가'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이미지 선택:'),
                InkWell(
                  onTap: _pickImage,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffFEE500),
                    ),
                    child: Center(
                      child: _image != null
                          ? Image.file(
                              File(_image!.path),
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
                final String name = nameController.text;
                final String priceText = priceController.text;
                final double? price = double.tryParse(priceText);

                if (name.isNotEmpty && price != null) {
                  final String newItem =
                      '$name $selectedCategory $price'; // 문자열로 합쳐서 추가

                  if (_image != null) {
                    // 이미지 경로도 필요한 경우 문자열로 추가할 수 있습니다.
                    final String imagePath = _image!.path;
                    menuname.add('$newItem $imagePath');
                  } else {
                    menuname.add(newItem);
                  }

                  setState(() {
                    // category, menuname, menucate, menuprice 리스트 업데이트
                    menuname.add(newItem);
                    menucate.add(selectedCategory);
                    menuprice.add(price.toString());
                  });

                  Navigator.pop(context); // 다이얼로그 닫기
                }
              },
              child: Text('추가'),
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
              onTap: _pickImage,
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffFEE500),
                ),
                child: Center(
                  child: _image != null
                      ? Image.file(
                          File(_image!.path),
                          width: 100,
                          height: 100,
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
                      padding: EdgeInsets.all(3),
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
                          return ListTile(
                            title: GestureDetector(
                              onTap: () {
                                _showEditCategoryDialog(index); // 카테고리를 클릭하면 수정 다이얼로그를 표시
                              },
                              child: Text(
                                category[index],
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
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
                      itemCount: menuname.length + 1, // menuname 리스트의 길이로 수정
                      itemExtent: 100.0, // 각 항목의 높이 설정
                      padding: EdgeInsets.all(3),
                      itemBuilder: (context, index) {
                        if (index == menuname.length) {
                          // 마지막 항목일 때 IconButton을 표시
                          return ListTile(
                            title: IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: _showAddMenuItemDialog,
                            ),
                          );
                        } else {
                          return ListTile(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      menuname[index], // 메뉴 이름을 표시
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      menucate[index], // 메뉴 카테고리를 표시
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      menuprice[index] + "원", // 메뉴 가격을 표시
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ]),
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
