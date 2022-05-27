import 'package:catering/config/text_styles.dart';
import 'package:catering/config/size_config.dart';
import 'package:catering/models/onboarding_model.dart';
import 'package:catering/widgets/logo.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => OnboardingScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}


class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: currentPage == index? KPrimaryColor : Colors.white,
        shape: BoxShape.circle
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(child: Column(
        children: [
          Expanded(
            flex: 9,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: Onboarding.onboardingContents.length,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: OnboardNavBtn(
                        name: "Пропустить >>",
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        }
                      ),
                    ),
                  ),
                  Logo(),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  Text(
                    Onboarding.onboardingContents[index].title,
                    style: kTitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  SizedBox(
                    height: sizeV * 40,
                    child: Image.asset(
                      Onboarding.onboardingContents[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )              
            )
          ),

          Expanded(
            flex: 1,
            child: Column(
              children: [
                currentPage == Onboarding.onboardingContents.length - 1
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: SizeConfig.blockSizeH! * 15.5,
                    width: SizeConfig.blockSizeH! * 80,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text(
                          "Начать!",
                          style: TextStyle(color: KPrimaryColor, fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                  ),
                )
                
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(Onboarding.onboardingContents.length, (index) => dotIndicator(index)),
                  ),
              ],
            )
          )
        ],
      )),
    );
  }
}

class OnboardNavBtn extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const OnboardNavBtn({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          name,
          style: kBodyText1,
        ),
      )
    );
  }
}