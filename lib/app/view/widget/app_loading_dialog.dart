import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppLoadingDialog extends StatelessWidget {
  const AppLoadingDialog({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194,
      width: 366,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AfroReadsColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AfroReadsColors.primaryColor.withOpacity(0.79),
          ),
          const Gap(13),
          TextSemiBold(
            text,
            fontSize: 15,
            color: AfroReadsColors.primaryColor.withOpacity(0.79),
          )
        ],
      ),
    );
  }
}
