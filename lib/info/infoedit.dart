import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Infoedit extends StatefulWidget {
  const Infoedit({Key? key}) : super(key: key);

  @override
  State<Infoedit> createState() => _InfoeditState();
}

class _InfoeditState extends State<Infoedit> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
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
        title: Text("내정보편집"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xff000000),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Color(0xfffae100),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이미지를 포함한 클릭 가능한 영역
            InkWell(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffFEE500),
                  shape: BoxShape.circle,
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
            SizedBox(height: 16.0),
            _buildTextField(_nameController, '이름'),
            SizedBox(height: 16.0),
            _buildTextField(_nicknameController, '닉네임'),
            SizedBox(height: 16.0),
            _buildTextField(_birthdateController, '생년월일'),
          ],
        ),
      ),
    );
  }

  // TextField를 생성하는 함수
  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  @override
  void dispose() {
    // 페이지가 파기될 때 컨트롤러들을 정리합니다.
    _nameController.dispose();
    _nicknameController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }
}
