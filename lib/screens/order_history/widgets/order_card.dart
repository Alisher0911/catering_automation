import 'package:catering/config/text_styles.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final int index;

  const OrderCard({ Key? key, required this.index }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(vertical: 4),
          title: Text(
              "Код заказа: $index",
              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white
            ),
          ),
          trailing: SizedBox(
            width: 110,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  minimumSize: const Size.fromHeight(40),
                  side: BorderSide(width: 2, color: KPrimaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )),
              onPressed: () {},
              child: Text(
                "Подробно",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: KPrimaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}