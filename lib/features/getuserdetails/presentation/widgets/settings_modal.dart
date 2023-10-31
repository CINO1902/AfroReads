import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/change_password_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/display_modal.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeProvider.themeData.primaryColor,
        borderRadius: const BorderRadius.only(
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
              'Settings',
              color: themeProvider.themeData.primaryColorDark,
              fontSize: 24,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                    backgroundColor: themeProvider.themeData.primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return DisplayModal(
                        themeProvider: themeProvider,
                      );
                    });
              },
              child: settingsContainer(
                context: context,
                text: "Display",
                textt: "Manage how you experience the app",
                image: AppAssets.gallery,
              ),
            ),
            Divider(color: Colors.grey.withOpacity(0.3)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return const ChangePasswordModal();
                    });
              },
              child: settingsContainer(
                context: context,
                text: "Change Password",
                textt: "Customise your password to access your account",
                image: AppAssets.lock,
              ),
            ),
            const Gap(25)
          ],
        ),
      ),
    );
  }

  Container settingsContainer(
      {text, textt, image, onTap, required BuildContext context}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(
                    text,
                    color: themeProvider.themeData.primaryColorDark,
                    fontSize: 14,
                  ),
                  const Gap(5),
                  TextBody(
                    textt,
                    color: AfroReadsColors.grey,
                    fontSize: 12,
                  )
                ],
              ),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: AfroReadsColors.grey.withOpacity(.7),
            size: 30,
          )
        ],
      ),
    );
  }
}
