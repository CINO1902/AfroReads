import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FinalSignUpVerificationPage extends StatelessWidget {
  const FinalSignUpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfroReadsColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(30),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: AfroReadsBackButton()),
                const Gap(20),
                FittedBox(
                  child: TextBold(
                    "Who's embarking on this journey today?",
                    fontSize: 20,
                  ),
                ),
                const Gap(30),
                loginContainer(context,
                    text: 'Dive into exciting stories and adventures!',
                    textt:
                        'Log in as a kid to explore our curated collection,\nboookmark favorites, and ennjoy a world of captivating',
                    texttt: 'African tales',
                    textttt: "Kid Log in",
                    image: AppAssets.kidOnBoardingImage,
                    routename: RouteName.kidloginpage),
                const Gap(70),
                loginContainer(context,
                    text:
                        'Manage settings, curate book lists, and monitor\n reading progress',
                    textt:
                        'Log in as a parent to customize the reading experience,\nfor your child, set timers, and gain insight into their',
                    texttt: 'literaty journey',
                    textttt: "Parent Log in",
                    image: AppAssets.parentOnBoardingImage2,
                    routename: RouteName.parentSignUpPage),
                const Gap(70),
                loginContainer(context,
                    text:
                        'Create Books, Edit book lists, and monitor\n your book progress',
                    textt:
                        'Log in as a publisher to customize the reading experience,\nfor your child, set timers, and gain insight into their',
                    texttt: 'literaty journey',
                    textttt: "Publisher Log in",
                    image: AppAssets.parentOnBoardingImage2,
                    routename: RouteName.publisherloginpage),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column loginContainer(BuildContext context,
      {text, textt, texttt, textttt, image, routename}) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AfroReadsColors.primaryColor,
              )),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        const Gap(20),
        TextBold(
          text,
          color: AfroReadsColors.textColor,
          fontSize: 17,
          textAlign: TextAlign.center,
        ),
        const Gap(13),
        TextBody(
          textt,
          fontSize: 13,
          color: AfroReadsColors.textColor,
          textAlign: TextAlign.center,
        ),
        TextBody(
          texttt,
          fontSize: 13,
          color: AfroReadsColors.textColor,
          textAlign: TextAlign.center,
        ),
        const Gap(40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: BusyButton(
              titleColor: AfroReadsColors.textColor,
              borderColor: AfroReadsColors.primaryColor,
              buttonColor: AfroReadsColors.background,
              title: textttt,
              onTap: () => Navigator.pushNamed(context, routename)),
        )
      ],
    );
  }
}
