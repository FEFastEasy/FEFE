import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Password extends StatefulWidget {

  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

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

class _PasswordState extends State<Password> {

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _mobileAuthController = TextEditingController();

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
        title: Text("비밀번호 찾기"),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildMobile('휴대폰번호', '휴대폰번호를 입력하세요.'),
            SizedBox(height: 20),
            _buildMobileAuth('휴대폰인증', '인증코드를 입력하세요.'),
          ],
        ),
      ),
    );
  }

Widget _buildMobile(String label, String hintText) {
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
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width * 2 / 10,
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
          width: MediaQuery.of(context).size.width * 4 / 10,
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
    width: MediaQuery.of(context).size.width * 8 / 10,
    alignment: Alignment.center,
    child: Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 2 / 10,
          child: Text(label, style: labelTextStyle),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 4 / 10,
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
          width: MediaQuery.of(context).size.width * 2 / 10,
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