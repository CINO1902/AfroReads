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
  final Widget title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        const Gap(10),
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          color: Colors.red,
          child: Center(
            child: SvgPicture.asset(
              images,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              title,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextBody(
                subTitle,
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: AfroReadsColors.grey,
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
