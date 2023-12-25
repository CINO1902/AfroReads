import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class BankModal extends StatelessWidget {
  const BankModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextSemiBold(
              'Bank Transfer',
              fontSize: 24,
            ),
            const Gap(24),
            TextBody(
              'Transfer order payment to any of the account number below.',
              fontSize: 15,
              color: AfroReadsColors.darkBackground,
            ),
            const Gap(29),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextSemiBold(
                  'Access Bank',
                  fontSize: 15,
                  color: AfroReadsColors.darkBackground,
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                  color: AfroReadsColors.darkBackground,
                ),
              ],
            ),
            const Gap(29),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextSemiBold(
                  'Wema Bank',
                  fontSize: 15,
                  color: AfroReadsColors.darkBackground,
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                  color: AfroReadsColors.darkBackground,
                ),
              ],
            ),
            const Gap(29),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextSemiBold(
                  'Sterling Bank',
                  fontSize: 15,
                  color: AfroReadsColors.darkBackground,
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                  color: AfroReadsColors.darkBackground,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
