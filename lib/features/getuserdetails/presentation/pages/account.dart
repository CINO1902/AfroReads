import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/auth/presentation/widgets/verfication_successful_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/help_support_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/settings_modal.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              const Gap(20),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    TextBold(
                      "My Account",
                      color: themeProvider.themeData.primaryColorDark,
                      fontSize: 20,
                    ),
                    const Gap(15),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AfroReadsColors.primaryColor,
                          )),
                      child: Image.asset(
                        AppAssets.parentOnBoardingImage2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(10),
                    TextBold(
                      "Vincent Florence",
                      color: themeProvider.themeData.primaryColorDark,
                      fontSize: 16,
                    ),
                    const Gap(5),
                    TextBody(
                      "follybaby1996_12@gmail.com",
                      color: AfroReadsColors.grey,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              const Gap(30),
              myAccountContainer(
                  context: context,
                  text: "Child Profile",
                  textt: "Manage your personal information",
                  image: AppAssets.profile,
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return const VerificationSuccessfulModal();
                        });
                  }),
              const Gap(5),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                context: context,
                text: "Saved Books",
                textt: "Access comics you have bookmarked to read later",
                image: AppAssets.mylibrary,
              ),
              const Gap(5),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                context: context,
                text: "About Rootts Books",
                textt: "Get to know about us and what we stand for.",
                image: AppAssets.about,
              ),
              const Gap(5),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                  context: context,
                  text: "Help & Support",
                  textt: "Get support or assist whenever you need it",
                  image: AppAssets.help,
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return const HelpSupportModal();
                        });
                  }),
              const Gap(5),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                  context: context,
                  text: "Settings",
                  textt: "Control other aspects of your app experience",
                  image: AppAssets.setting,
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return const SettingsModal();
                        });
                  }),
              const Gap(5),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                context: context,
                text: "Log Out",
                textt: "Log out of your account",
                image: AppAssets.logout,
              ),
              const Gap(5),
              Divider(color: Colors.grey.withOpacity(0.3)),
            ]),
          ),
        ),
      ),
    );
  }

  GestureDetector myAccountContainer(
      {text, textt, image, onTap, required BuildContext context}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
