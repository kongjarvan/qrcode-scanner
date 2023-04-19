import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewQRCode extends StatelessWidget {
  const ViewQRCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImage(
          data: "0000000001",
          backgroundColor: Colors.white,
          size: 200,
        ),
      ),
    );
  }
}
