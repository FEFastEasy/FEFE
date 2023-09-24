import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fefe/login/terms.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class TermsDetailPage extends StatelessWidget {
  final String term;

  TermsDetailPage({required this.term});

  @override
  Widget build(BuildContext context) {
    String termContent = TermsContent.getTermsContent(term); // 약관 내용 가져오기

    return Scaffold(
      appBar: AppBar(
        title: Text(term),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(termContent), // 약관 내용 표시
      ),
    );
  }
}

class _SignupState extends State<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _mobileAuthController = TextEditingController();

  String? _selectedGender;
  bool _isAgeChecked = false;
  bool _isTermsChecked = false;
  bool _isAllTermsChecked = false;
  bool _isPrivacyChecked = false; // 개인정보 수집/이용 동의 체크박스 상태
  bool _isLocationChecked = false; // 위치기반 서비스 이용 동의 체크박스 상태
  bool _isPromotionChecked = false; // 홍보성 정보 수신에 동의 체크박스 상태

  void _updateAllTermsChecked() {
    setState(() {
      _isAllTermsChecked = _isAgeChecked &&
          _isTermsChecked &&
          _isPrivacyChecked &&
          _isLocationChecked &&
          _isPromotionChecked;
    });
  }

  final TextStyle labelTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  int? _selectedYear;
  int? _selectedMonth;
  int? _selectedDay;

  final List<int> years = List.generate(100, (index) =>
  DateTime
      .now()
      .year - index);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> days = List.generate(31, (index) => index + 1);

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
        title: Text("회원가입"),
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
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              _buildTitle('페페(FEFE) 가입을 환영합니다.', fontSize: 30),
              SizedBox(height: 30),
              _buildFormField('이름', '이름을 입력하세요.'),
              SizedBox(height: 20),
              _buildGenderRadio(),
              SizedBox(height: 20),
              _buildDateDropdowns(),
              SizedBox(height: 20),
              _buildMobile('휴대폰번호', '휴대폰번호를 입력하세요.'),
              SizedBox(height: 20),
              _buildMobileAuth('휴대폰인증', '인증코드를 입력하세요.'),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isAllTermsChecked,
                      onChanged: (value) {
                        setState(() {
                          _isAllTermsChecked = value ?? false;

                          // 모든 체크박스에 전체 동의 상태를 적용
                          _isTermsChecked = _isAllTermsChecked;
                          _isAgeChecked = _isAllTermsChecked;
                          _isPrivacyChecked = _isAllTermsChecked;
                          _isLocationChecked = _isAllTermsChecked;
                          _isPromotionChecked = _isAllTermsChecked;
                        });
                      },
                    ),
                    Text('전체 동의'),
                  ],
                ),
              ),
              _buildCheckBox02(context, '만 14세 이상입니다. (필수)', _isAgeChecked, (value) {
                setState(() {
                  _isAgeChecked = value ?? false;
                  _updateAllTermsChecked(); // 상태 업데이트 후 호출
                });
              }, ),
              _buildCheckBox(context, '이용약관 동의 (필수)', _isTermsChecked, (value) {
                setState(() {
                  _isTermsChecked = value ?? false;
                  _updateAllTermsChecked(); // 상태 업데이트 후 호출
                });
              }, '이용약관'),
              _buildCheckBox(context, '개인정보 수집/이용 동의 (필수)', _isPrivacyChecked, (value) {
                setState(() {
                  _isPrivacyChecked = value ?? false;
                  _updateAllTermsChecked(); // 상태 업데이트 후 호출
                });
              }, '개인정보'),
              _buildCheckBox(context, '위치기반 서비스 이용 동의 (필수)', _isLocationChecked, (value) {
                setState(() {
                  _isLocationChecked = value ?? false;
                  _updateAllTermsChecked(); // 상태 업데이트 후 호출
                });
              }, '위치기반'),
              _buildCheckBox(context, '홍보성 정보 수신에 동의 (선택)', _isPromotionChecked, (value) {
                setState(() {
                  _isPromotionChecked = value ?? false;
                  _updateAllTermsChecked(); // 상태 업데이트 후 호출
                });
              }, '홍보'),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffFEE500),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_isAgeChecked && _isTermsChecked && _isPrivacyChecked && _isLocationChecked) {
                        // Check if all terms except '홍보성 정보 수신에 동의' are agreed upon
                          // Perform the signup logic here
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        // Show an alert that all terms must be agreed upon
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('필수 약관에 동의해야 회원가입이 가능합니다.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('확인'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },

                    child: Text(
                        '회원가입',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
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
          style: labelTextStyle.copyWith(fontSize: fontSize),
        ),
      ),
    );
  }

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

  Widget _buildGenderRadio() {
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
            child: Text('성별', style: labelTextStyle),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 6 / 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio<String>(
                  value: '남',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                Text('남'),
                Radio<String>(
                  value: '여',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                Text('여'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateDropdowns() {
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
            child: Text('생년월일', style: labelTextStyle),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 6 / 10,
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<int>(
                    value: _selectedYear,
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value;
                      });
                    },
                    items: years.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    hint: Text('연도 선택'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<int>(
                    value: _selectedMonth,
                    onChanged: (value) {
                      setState(() {
                        _selectedMonth = value;
                      });
                    },
                    items: months.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    hint: Text('월 선택'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<int>(
                    value: _selectedDay,
                    onChanged: (value) {
                      setState(() {
                        _selectedDay = value;
                      });
                    },
                    items: days.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    hint: Text('일 선택'),
                  ),
                ),
              ],
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

Widget _buildCheckBox02(
    BuildContext context,
    String label,
    bool value,
    ValueChanged<bool?> onChanged,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    ),
  );
}


Widget _buildCheckBox(
    BuildContext context,
    String label,
    bool value,
    ValueChanged<bool?> onChanged,
    String term,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(label),
        if (TermsContent.getTermsContent(term).isNotEmpty)
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsDetailPage(term: term),
                ),
              );
            },
            child: Text(
              '보기',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    ),
  );
}
