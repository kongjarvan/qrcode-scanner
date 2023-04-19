import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanner/constants/size.dart';
import 'package:qrscanner/controller/scan_controller.dart';
import 'package:qrscanner/qr_code_scanner.dart';
import 'package:qrscanner/view_qr_code.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getBodyHeight(context);
    getBodyWidth(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          GetBuilder<ScanController>(
            builder: (controller) {
              return Text(
                controller.code == null ? 'dialog 확인용' : controller.code!,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              );
            },
          ),
          Flexible(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return QRCodeScanner();
                        },
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent),
                      child: Center(
                        child: Text(
                          'QR Code Scan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ViewQRCode();
                        },
                      ));
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent),
                      child: Center(
                        child: Text(
                          'View QR Code',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
