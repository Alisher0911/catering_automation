import 'dart:io';

import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/screens/local_organization_details/local_organization_details.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({ Key? key }) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

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
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )
                ),
                title: Text(
                  "Сканировать QR",
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xFF8C9099)),
                ),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
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
          // Expanded(
          //   flex: 1,
          //   child: Center(
          //     child: (result != null)
          //         ? Text(
          //             'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'
          //           )
          //         : Text('Scan a code'),
          //   ),
          // )
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
      // BlocListener<RestaurantBloc, RestaurantState>(
      //   listener: (context, state) {
      //     if (state is RestaurantLoaded) {
      //       pushNewScreenWithRouteSettings(
      //         context,
      //         settings: RouteSettings(name: RestaurantDetailsScreen.routeName),
      //         screen: RestaurantDetailsScreen(restaurant: state.restaurants.firstWhere((restaurant) => restaurant.id.toString() == result!.code)),
      //         withNavBar: true,
      //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
      //       );
      //     } else {
      //       print("not loaded");
      //     }
      //   },
      // );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}