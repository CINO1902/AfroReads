import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class DebitCardModal extends StatelessWidget {
  const DebitCardModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 197,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextSemiBold(
              'Card',
              fontSize: 24,
            ),
            const Gap(24),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 17,
              ),
              leading: Image.asset(
                AppAssets.addcircle,
                height: 19,
                width: 30,
              ),
              title: TextBody(
                '4833 - First Bank of Nigeria',
                color: AfroReadsColors.darkBackground,
                fontSize: 15,
              ),
              trailing: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.debitCardScreen);
                  },
                  child: TextBody(
                    'Switch',
                    fontSize: 12,
                    color: AfroReadsColors.primaryColor,
                  )),
            ),
            TextBody(
              'Expires 08/2026',
              fontSize: 12,
              color: AfroReadsColors.darkBackground,
            )
          ],
        ),
      ),
    );
  }
}
