import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => QRCodeScreen(), settings: RouteSettings(name: routeName));
  }

  QRCodeScreen({ Key? key }) : super(key: key);

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}


class _QRCodeScreenState extends State<QRCodeScreen> {
  final controller = TextEditingController();

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

      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: controller.text,
                size: 200,
              ),
              SizedBox(height: 40),
              buildTextField(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context) => TextField(
    controller: controller,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16
    ),
    decoration: InputDecoration(
      hintText: "Enter the data",
      hintStyle: TextStyle(color: Colors.grey),
      suffixIcon: IconButton(
        onPressed: () => setState(() {}),
        icon: Icon(Icons.done),
      )
    ),
  );
}