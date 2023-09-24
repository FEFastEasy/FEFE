import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fefe/order/order.dart';
import 'package:fefe/login/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

final TextEditingController _mobileController = TextEditingController();

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

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _checkBoxValue = false;

  // 공통된 스타일을 사용하는 ElevatedButton 위젯을 생성하는 함수
  Widget _buildElevatedButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: backgroundColor ?? Color(0xffFEE500),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xff000000),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
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
        title: Text("로그인"),
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
            _buildLogo(),
            SizedBox(height: 16.0),
            _buildMobile('휴대폰번호', '휴대폰번호를 입력하세요.'),
            SizedBox(height: 16.0),
            _buildPasswordField('비밀번호', '비밀번호를 입력하세요.'),
            SizedBox(height: 25.0),
            // 로그인 버튼
            _buildElevatedButton(
              text: '로그인',
              onPressed: _loginButtonPressed,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signup()));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text("회원가입"),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                      value: _checkBoxValue,
                      onChanged: (value) {
                        setState(() {
                          _checkBoxValue = value ?? false;
                        });
                      },
                    ),
                    Text("로그인정보 기억하기"),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // 아이디 찾기 버튼 동작
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text("아이디 찾기"),
                ),
                Text(" / "),
                TextButton(
                  onPressed: () {
                    // 패스워드 찾기 버튼 동작
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text("패스워드 찾기"),
                ),
              ],
            ),
            // 다양한 소셜 로그인 버튼
            _buildElevatedButton(
              text: '카카오 로그인',
              onPressed: _loginButtonPressed,
              backgroundColor: Color(0xffFEE500),
            ),
            SizedBox(height: 16.0),
            _buildElevatedButton(
              text: '네이버 로그인',
              onPressed: _loginButtonPressed,
              backgroundColor: Color(0xff00ff33),
            ),
            SizedBox(height: 16.0),
            _buildElevatedButton(
              text: '구글 로그인',
              onPressed: _loginButtonPressed,
              backgroundColor: Color(0x9effffff),
            ),
            SizedBox(height: 16.0),
            _buildElevatedButton(
              text: '애플 로그인',
              onPressed: _loginButtonPressed,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffFEE500),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          "페페(FEFE)",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
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

  Widget _buildPasswordField(String label, String hintText) {
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
            width: MediaQuery.of(context).size.width * 6 / 10,
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: _passwordController.text.isEmpty ? hintText : null,
              ),
              obscureText: true, // 이 부분을 추가하여 비밀번호가 * 모양으로 표시됩니다.
            ),
          ),
        ],
      ),
    );
  }

  void _loginButtonPressed() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Perform login validation here
    if (username == 'user' && password == 'user') {
      // Login successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Order(message: DateTime.now().toString()),
        ),
      );
    } else {
      // Login failed
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Invalid username or password.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
