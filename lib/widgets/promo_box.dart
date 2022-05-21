import 'package:catering/models/promo_model.dart';
import 'package:flutter/material.dart';

class PromoBox extends StatelessWidget {
  final Promo promo;

  const PromoBox({ Key? key, required this.promo }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(right: 5),
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.primary,
            image: DecorationImage(
                image: NetworkImage(promo.imageUrl),
                fit: BoxFit.cover)
        ),
      ),

      ClipPath(
        clipper: PromoCustomClipper(),
        child: Container(
          margin: const EdgeInsets.only(right: 5),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.primary,
          ),
      
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 15,
              right: 125
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(promo.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white)),
              
              SizedBox(height: 15,),
      
              Text(promo.description,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white)),
            ]),
          ),
        ),
      ),
    ]);
  }
}

class PromoCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(225, size.height);
    path.lineTo(275, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
  
}