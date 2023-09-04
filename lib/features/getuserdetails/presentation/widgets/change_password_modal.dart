import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AfroReadsColors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextSemiBold(
              'Change Password',
              color: AfroReadsColors.textColor.withOpacity(0.8),
              fontSize: 24,
            ),
            const Gap(25)
          ],
        ),
      ),
    );
  }
}
