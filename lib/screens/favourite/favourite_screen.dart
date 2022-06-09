import 'package:catering/config/text_styles.dart';
import 'package:catering/screens/local_organization_details/widgets/glassmorphism.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavouriteScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => FavouriteScreen(), settings: RouteSettings(name: routeName));
  }

  const FavouriteScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                  "Любимые",
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xFF8C9099)),
                ),
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          children: [
            _buildMenuItem(context, "https://cdn.shopify.com/s/files/1/0205/9582/articles/20220211142347-margherita-9920_ba86be55-674e-4f35-8094-2067ab41a671.jpg?crop=center&height=800&v=1644590192&width=800", "Marghertia", 2200),
            _buildMenuItem(context, "https://xo.kz/astana/wp-content/uploads/sites/5/2020/04/coca-cola-1000ml.jpg", "Coca-Cola", 600),
            _buildMenuItem(context, "https://www.saveur.com/uploads/2019/07/08/JTPSD2ONPYISBHIP4CJ5HDW55A.jpg?auto=webp", "Mozarella", 2500)
          ]
        ),
      )
    );
  }
}

Widget _buildMenuItem(BuildContext context, String urlImage, String name, double price) {
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(urlImage),
                    fit: BoxFit.cover
                  )
              ),
            ),

            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${price.toStringAsFixed(2)} тг",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFFFE724C)),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 10,
              right: 10,
              child: Glassmorphism(
                blur: 5,
                opacity: 0.1,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                    },
                    // iconSize: 16,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      CupertinoIcons.heart_fill,
                      color: appColor2,
                    )
                  ),
                ),
              )
            )
          ],
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        )
      ],
    ),
  );
}