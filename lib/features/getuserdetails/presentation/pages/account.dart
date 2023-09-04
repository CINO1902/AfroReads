import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/auth/widgets/verfication_successful_modal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfroReadsColors.background,
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
                text: "Child Profile",
                textt: "Manage your personal information",
                image: AppAssets.profile,
                onTap: (){
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
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
                }
              ),
              const Gap(7),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                text: "Saved Books",
                textt: "Access comics you have bookmarked to read later",
                image: AppAssets.mylibrary,
              ),
              const Gap(7),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                text: "About Rootts Books",
                textt: "Get to know about us and what we stand for.",
                image: AppAssets.about,
              ),
              const Gap(7),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                text: "Help & Support",
                textt: "Get support or assist whenever you need it",
                image: AppAssets.help,
              ),
              const Gap(7),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                text: "Settings",
                textt: "Control other aspects of your app experience",
                image: AppAssets.setting,
                onTap: (){
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
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
                }
              ),
              const Gap(7),
              Divider(color: Colors.grey.withOpacity(0.3)),
              myAccountContainer(
                text: "Log Out",
                textt: "Log out of your account",
                image: AppAssets.logout,
              ),
              const Gap(7),
              Divider(color: Colors.grey.withOpacity(0.3)),
            ]),
          ),
        ),
      ),
    );
  }

  GestureDetector myAccountContainer({text, textt, image, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AfroReadsColors.background,
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
                      fontSize: 14,
                    ),
                    const Gap(3),
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
