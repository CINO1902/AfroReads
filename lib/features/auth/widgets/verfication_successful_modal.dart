import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class VerificationSuccessfulModal extends StatelessWidget {
  const VerificationSuccessfulModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AfroReadsColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AfroReadsColors.primaryColor,
                )),
            child: const Center(
              // child: SvgPicture.asset(
              //   AppAssets.mail2,
              //   color: AfroReadsColors.primaryColor,
              //   width: 38,
              //   height: 30,
              // ),
            ),
          ),
          const Gap(12),
          TextSemiBold(
            'Verification Successful',
            color: AfroReadsColors.textColor.withOpacity(0.8),
            fontSize: 24,
          ),
          const Gap(13),
          TextBody(
            'Your email address has been successfully\nverified. Thank you for confirming your',
            fontSize: 16,
            color: AfroReadsColors.grey.withOpacity(0.6),
            textAlign: TextAlign.center,
          ),
          TextBody(
            'authenticity',
            fontSize: 16,
            color: AfroReadsColors.grey.withOpacity(0.6),
            textAlign: TextAlign.center,
          ),
          const Gap(30),
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              // await Navigator.pushNamed(
              //   context,
              //   RouteName.partnerHomeNavbar,
              // );
            },
            child: Container(
              height: 48,
              width: 259,
              decoration: BoxDecoration(
                color: AfroReadsColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextBold(
                  'Continue to App',
                  fontSize: 15,
                  color: AfroReadsColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
