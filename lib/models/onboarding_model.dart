class Onboarding {
  final String title;
  final String image;

  Onboarding({
    required this.title,
    required this.image
  });


  static List<Onboarding> onboardingContents = [
    Onboarding(
      title: "Save Food\n with our new\n Feature!",
      image: "assets/startup/onboarding/onboarding1.png"
    ),
    Onboarding(
      title: "Set preferences for\n multiple users from\n various restaurants!",
      image: "assets/startup/onboarding/onboarding2.png"
    ),
    Onboarding(
      title: "Fast, rescued\n food at your\n service.",
      image: "assets/startup/onboarding/onboarding3.png"
    ),
  ];
}