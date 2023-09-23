import 'package:flutter/material.dart';

class TermsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: buildAppBar(context, '이용약관'), // Pass the term as a parameter
        body: Center(
          child: Text(
            TermsContent.getTermsContent('이용약관'), // Example usage of TermsContent
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, String term) { // Receive term as a parameter
    // Define the default AppBar color
    Color appBarColor = Colors.yellow;

    // Check if the term is "위치기반" and set a different color if needed
    if (term == '위치기반') {
      appBarColor = Colors.orange; // Change the color for "위치기반" term
    }

    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.keyboard_backspace),
        color: Colors.black,
      ),
      title: Text(
        "회원가입",
        style: TextStyle(
          color: Colors.black, // 타이틀 텍스트 색상
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true, // 타이틀 가운데 정렬
      backgroundColor: appBarColor, // Use the determined color
    );
  }

  static String getTermsContent(String term) {
    // 여기에서 약관 내용을 가져오는 로직을 구현합니다.
    // 예를 들어, 약관 이름에 따라 다른 내용을 반환하도록 작성할 수 있습니다.
    if (term == '이용약관') {
      return '이용약관 내용입니다.';
    } else if (term == '개인정보') {
      return '개인정보 처리방침 내용입니다.';
    } else if (term == '위치기반') {
      return '위치기반 서비스 이용 내용입니다.';
    } else if (term == '홍보') {
      return '홍보성 정보 수신 내용입니다.';
    } else {
      return '약관 내용이 없습니다.';
    }
  }
}

void main() {
  runApp(TermsContent());
}
