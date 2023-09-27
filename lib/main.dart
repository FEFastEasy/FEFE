import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:fefe/order/order.dart';
import 'package:fefe/info/info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR 스캔'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xff000000),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xfffae100),
        automaticallyImplyLeading: false,
      ),
      body: WillPopScope(
        onWillPop: _onWillPop, // 뒤로가기 버튼을 누를 때 호출할 메서드를 지정합니다.
        child: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('앱 종료'),
        content: Text('앱을 종료하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('아니요'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop(); // 앱 종료
            },
            child: Text('예'),
          ),
        ],
      ),
    ) ?? false;
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xfffae100),
      child: InkWell(
        onTap: () {
          // Container를 클릭했을 때 처리할 내용
          _navigateToInfoPage(context);
        },
        child: Container(
          height: 56.0, // 원하는 높이로 조절
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '내정보',
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20, // 원하는 폰트 크기로 조절
                  fontWeight: FontWeight.bold, // 필요에 따라 볼드 처리
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToInfoPage(BuildContext context) {
      // info 페이지로 이동하는 코드를 작성
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Info(), // Info는 이동할 페이지의 위젯입니다.
        ),
      );
  }

  Widget _buildQrView(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Color(0xfffae100),
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: _onPermissionSet,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        // 스캔 결과를 처리하고 사용자 확인을 받은 후에 화면을 전환
        _handleScanResult(context);
      });
    });
  }

  void _handleScanResult(BuildContext context) {
    if (result != null) {
      // 화면 전환
      _navigateToOrderPage(context);
    }
  }

  void _navigateToOrderPage(BuildContext context) {
    if (result != null) {
      // 카메라 작동 멈추기
      controller?.dispose();

      // 화면 전환
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Order(message: DateTime.now().toString()),
        ),
      );
    }
  }


  void _onPermissionSet(QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
