import 'dart:async';
import 'dart:io';

import 'package:catering/config/text_styles.dart';
import 'package:catering/screens/local_organization_details/local_organization_details.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  static const String routeName = '/qr-scanner';

  // static Route route() {
  //   return MaterialPageRoute(
  //       builder: (_) => QRScannerScreen(),
  //       settings: RouteSettings(name: routeName));
  // }

  const QRScannerScreen({Key? key, required this.qrListener, required this.controller})
      : super(key: key);

  final Function(PersistentTabController controller, Function onClose) qrListener;
  final PersistentTabController controller;
  // const QRScannerScreen({ Key? key, }) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    widget.qrListener(widget.controller, () {
      if (controller != null) {
        controller!.dispose();
        controller!.pauseCamera();
      }
    });
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.white30,
                blurRadius: 3.0,
              )
            ],
            color: Theme.of(context).colorScheme.background
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                automaticallyImplyLeading: false, 
                elevation: 0,
                titleSpacing: 0,
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(
                  "Сканировать QR",
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xFF8C9099)),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      controller!.resumeCamera();
                    },
                    icon: Icon(
                      Icons.refresh)
                    )
                ],
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            // flex: 5,
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                borderColor: KPrimaryColor,
                borderLength: 20,
                borderWidth: 10,
                borderRadius: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8
              ),
              onQRViewCreated: _onQRViewCreated,
            ),
          ),

          // Container(
          //   height: 100,
          //   color: Colors.transparent,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ElevatedButton(
          //         onPressed: () {
          //           controller!.pauseCamera();
          //         }, 
          //         child: Text("Pause")
          //       ),
          //       ElevatedButton(
          //         onPressed: () {
          //           controller!.resumeCamera();
          //         }, 
          //         child: Text("Resume")
          //       )
          //     ],
          //   )
          // ),
        ],
      ),
    );
  }


  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      this.controller!.pauseCamera();
      setState(() {
        result = scanData;
      });
      final id = int.parse(result!.code!);
      pushNewScreenWithRouteSettings(
        context,
        settings: RouteSettings(name: LocalOrganizationDetailsScreen.routeName),
        screen: LocalOrganizationDetailsScreen(id: id),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}