import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Infoedit extends StatefulWidget {
  const Infoedit({Key? key}) : super(key: key);

  @override
  State<Infoedit> createState() => _InfoeditState();
}

class UserProfile {
  final String nickname;
  final String profileImage;

  UserProfile(this.nickname, this.profileImage);
}


class _InfoeditState extends State<Infoedit> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _mobileAuthController = TextEditingController();
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

// 회원 정보를 가져와 입력 칸에 설정하는 함수
  Future<void> fetchMemberInfo() async {
    final url = Uri.parse('https://example.com/api/get_member_info'); // 실제 API 엔드포인트를 사용하세요.
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> memberInfo = json.decode(response.body);
      setState(() {
        _nicknameController.text = memberInfo['nickname'] ?? '';
        _usernameController.text = memberInfo['username'] ?? '';
        _mobileController.text = memberInfo['mobileNumber'] ?? '';
        // 다른 필드도 필요에 따라 설정
      });
    } else {
      // 실패한 경우 예외 처리
      throw Exception('Failed to load member info');
    }
  }

  // initState에서 회원 정보 가져오기
  @override
  void initState() {
    super.initState();
    fetchMemberInfo().catchError((error) {
      // 오류 처리
      print('Error fetching member info: $error');
    });
  }

  final TextStyle labelTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

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
            SizedBox(height: 20.0),
            _buildNicknameField('닉네임', '닉네임을 입력하세요.'),
            SizedBox(height: 20.0),
            _buildFormField('이름', '이름을 입력하세요.'),
            SizedBox(height: 20.0),
            _buildFormField('생년월일', '생년월일을 입력하세요.'),
            SizedBox(height: 20),
            _buildMobile('휴대폰번호', '휴대폰번호를 입력하세요.'),
            SizedBox(height: 20),
            _buildMobileAuth('휴대폰인증', '인증코드를 입력하세요.'),
          ],
        ),
      ),
    );
  }

  // TextField를 생성하는 함수
  Widget _buildNicknameField(String label, String hintText) {
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
                .width * 6 / 10,
            child: TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: _usernameController.text.isEmpty ? hintText : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TextField를 생성하는 함수
  Widget _buildFormField(String label, String hintText) {
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
                .width * 6 / 10,
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: _usernameController.text.isEmpty ? hintText : null,
              ),
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