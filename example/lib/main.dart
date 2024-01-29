import 'package:flutter/material.dart';
import 'package:yogathon_registration/barcode_list_scanner_controller.dart';
import 'package:yogathon_registration/barcode_scanner_controller.dart';
import 'package:yogathon_registration/barcode_scanner_returning_image.dart';
import 'package:yogathon_registration/barcode_scanner_without_controller.dart';

void main() => runApp(const MaterialApp(home: MyHome()));

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yogathon Registration App')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             const BarcodeListScannerWithController(),
            //       ),
            //     );
            //   },
            //   child: const Text('MobileScanner with List Controller'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerWithController(),
                  ),
                );
              },
              child: const Text('Scan with QR Code'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const BarcodeScannerReturningImage(),
            //       ),
            //     );
            //   },
            //   child:
            //       const Text('MobileScanner with Controller (returning image)'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             const BarcodeScannerWithoutController(),
            //       ),
            //     );
            //   },
            //   child: const Text('MobileScanner without Controller'),
            // ),
          ],
        ),
      ),
    );
  }
}
