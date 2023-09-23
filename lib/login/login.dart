import 'package:flutter/material.dart';
import 'package:fefe/order/order.dart';
import 'package:fefe/login/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

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
            _buildTextField(
              controller: _usernameController,
              labelText: '이메일',
            ),
            SizedBox(height: 16.0),
            _buildTextField(
              controller: _passwordController,
              labelText: '패스워드',
              obscureText: true,
            ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
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
