// ignore_for_file: unused_import

import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class OnboardingFirstPage extends StatelessWidget {
  const OnboardingFirstPage({
    Key? key,
    required this.images,
    required this.subTitle,
    required this.title,
  }) : super(key: key);
  final String images;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        const Gap(50),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Center(
            child: Image.asset(
              images,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1
          ),
          child: Column(
            children: [
              TextBody(
                title,
                color: AfroReadsColors.primaryColor,
                fontSize: 20,
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextBody(
                subTitle,
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: AfroReadsColors.textColor,
                maxLines: 10,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
