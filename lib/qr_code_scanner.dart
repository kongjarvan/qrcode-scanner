import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrscanner/controller/scan_controller.dart';

import 'constants/size.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    double width = getBodyHeight(context);
    double height = getBodyWidth(context);
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: width / 3,
        height: height / 2,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 0.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: _buildQrView(context, width),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: (result != null)
                    ? GetBuilder<ScanController>(
                        builder: (controller) {
                          return InkWell(
                            onTap: () {
                              controller.saveQRCode('${result!.code}');
                              Get.log('${result!.code}');
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'),
                            ),
                          );
                        },
                      )
                    : Center(child: Text('Scan a code')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context, double width) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = width / 7;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.yellow,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
