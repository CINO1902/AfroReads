// ignore_for_file: use_key_in_widget_constructors

import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/onboarding/widgets/onboarding_first_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController? _pageController;
  int currentIndex = 0;

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  nextFunction() {
    _pageController!.nextPage(duration: _kDuration, curve: _kCurve);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfroReadsColors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView(
              controller: _pageController,
              onPageChanged: onChangedFunction,
              children: const [
                OnboardingFirstPage(
                  images: AppAssets.onBoardingImage,
                  subTitle:
                      'Rootts Book App’s library is thoughtfully curated, ensuring every title mirrors the depth, diversity, and richness of African narratives. ',
                  title: "Quality at the Heart of Selection",
                ),
                OnboardingFirstPage(
                  images: AppAssets.onBoardingImage1,
                  subTitle:
                      'Our parental controls are designed to empower you, making every reading session safe, engaging, and tailored to your childs unique pace. ',
                  title: "Parental Controls",
                ),
                OnboardingFirstPage(
                  images: AppAssets.onBoardingImage2,
                  subTitle:
                      'Rootts Book App brings together tales woven with the vibrant threads of culture, heritage, and imagination. Dive into a treasure trove of stories from the African continent.',
                  title: "Embark on a Literary Adventure",
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Indicator(
                positionIndex: 0,
                currentIndex: currentIndex,
              ),
              const Gap(15),
              Indicator(
                positionIndex: 1,
                currentIndex: currentIndex,
              ),
              const Gap(15),
              Indicator(
                positionIndex: 2,
                currentIndex: currentIndex,
              ),
            ],
          ),
          const Gap(40),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              children: [
                BusyButton(
                  title: 'Create an Account',
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signUpPage);
                  },
                ),
                const Gap(20),
                BusyButton(
                  title: 'Sign in',
                  titleColor: AfroReadsColors.textColor,
                  borderColor: AfroReadsColors.primaryColor,
                  buttonColor: AfroReadsColors.white,
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.indexPage);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 127,
        decoration: BoxDecoration(
          color: AfroReadsColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: TextSemiBold(
            'Continue',
            color: AfroReadsColors.white,
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({
    required this.currentIndex,
    required this.positionIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: positionIndex == currentIndex ? 10 : 10,
      width: positionIndex == currentIndex ? 10 : 10,
      decoration: BoxDecoration(
        border: Border.all(
          color: AfroReadsColors.grey,
        ),
        shape: BoxShape.circle,
        color: positionIndex == currentIndex
            ? AfroReadsColors.primaryColor
            : AfroReadsColors.white,
      ),
    );
  }
}
