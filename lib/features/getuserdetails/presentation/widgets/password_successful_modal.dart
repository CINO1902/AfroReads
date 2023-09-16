import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PasswordSuccesfluModal extends StatelessWidget {
  const PasswordSuccesfluModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 282,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          const Gap(20),
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AfroReadsColors.primaryColor,
                )),
            child: Center(
              child: Image.asset(
                AppAssets.mark,
                color: AfroReadsColors.primaryColor,
                width: 38,
                height: 30,
              ),
            ),
          ),
          const Gap(10),
          TextSemiBold(
            "Successful !",
            style: const TextStyle(fontSize: 24),
          ),
          const Gap(10),
          TextBody(
            "You have successfully",
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          TextBody(
            "changed your password",
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const Gap(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: BusyButton(
                title: "Continue",
                onTap: () {
                  Navigator.of(context).pop();
                }),
          )
        ],
      ),
    );
  }
}
