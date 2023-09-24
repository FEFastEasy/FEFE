import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _mobileAuthController = TextEditingController();
  final TextEditingController _storenumberController = TextEditingController();

  final List<Map<String, String>> countries = [
    {'code': '+1', 'flag': '🇺🇸'},
    {'code': '+44', 'flag': '🇬🇧'},
    {'code': '+81', 'flag': '🇯🇵'},
    {'code': '+82', 'flag': '🇰🇷'},
    {'code': '+86', 'flag': '🇨🇳'},
    {'code': '+91', 'flag': '🇮🇳'},
    {'code': '+92', 'flag': '🇵🇰'},
    {'code': '+93', 'flag': '🇦🇫'},
    {'code': '+94', 'flag': '🇱🇰'},
    {'code': '+95', 'flag': '🇲🇲'},
    {'code': '+98', 'flag': '🇮🇷'},
    {'code': '+99', 'flag': '🌐'},
  ];

  Map<String, String>? _selectedCountry;

  final TextStyle labelTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_backspace),
          color: Colors.black,
        ),
        title: Text("매장등록"),
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
              _buildTitle('매장등록하고 언제어디서나\n매장관리를 쉽고 빠르게'),
              SizedBox(height: 20),
              _buildNumberField('사업자등록번호', '사업자등록번호를 입력해주세요'),
              SizedBox(height: 20),
              _buildMobile('휴대폰번호', '휴대폰번호를 입력하세요.'),
              SizedBox(height: 20),
              _buildMobileAuth('휴대폰인증', '인증코드를 입력하세요.'),
              SizedBox(height: 20),
              InkWell(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffFEE500),
                    border: Border.all(width: 1.0, color: Colors.grey)
                  ),
                  child: Center(
                    child: _image != null
                        ? Image.file(
                      File(_image!.path),
                      width: 210,
                      height: 297,
                    )
                        : Icon(
                      Icons.add_a_photo,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title, {double fontSize = 20}) {
    return Container(
      width: MediaQuery.of(context).size.width * 8 / 10,
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xfffae100),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: Text(
            title,
            style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildNumberField(String label, String hintText) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 8 / 10,
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 2 / 10,
            child: Text(label, style: labelTextStyle),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 6 / 10,
            child: TextField(
              controller: _storenumberController,
              decoration: InputDecoration(
                labelText: _storenumberController.text.isEmpty ? hintText : null,
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile(String label, String hintText) {
    return Container(
      height: 40,
      width: MediaQuery
          .of(context)
          .size
          .width * 8 / 10,
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 2 / 10,
            child: Text(label, style: labelTextStyle),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery
                .of(context)
                .size
                .width * 2 / 10,
            child: DropdownButton<Map<String, String>>(
              value: _selectedCountry,
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
              items: countries.map<DropdownMenuItem<Map<String, String>>>(
                      (Map<String, String> country) {
                    return DropdownMenuItem<Map<String, String>>(
                      value: country,
                      child: Row(
                        children: [
                          Text(country['flag'] ?? ''),
                          SizedBox(width: 6),
                          Text(country['code'] ?? ''),
                        ],
                      ),
                    );
                  }).toList(),
              hint: Text('국가번호'),
            ),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 4 / 10,
            child: TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                labelText: _mobileController.text.isEmpty ? hintText : null,
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileAuth(String label, String hintText) {
    return Container(
      height: 40,
      width: MediaQuery
          .of(context)
          .size
          .width * 8 / 10,
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 2 / 10,
            child: Text(label, style: labelTextStyle),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 4 / 10,
            child: TextField(
              controller: _mobileAuthController,
              decoration: InputDecoration(
                labelText: _mobileAuthController.text.isEmpty ? hintText : null,
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 2 / 10,
            child: ElevatedButton(
              onPressed: () {
                // 인증 코드 전송 동작을 여기에 구현하세요.
              },
              child: Text('코드전송'),
            ),
          ),
        ],
      ),
    );
  }
}