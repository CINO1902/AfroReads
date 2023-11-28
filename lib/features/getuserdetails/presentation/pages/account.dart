import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/help_support_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/settings_modal.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/navigators/route_name.dart';
import '../provider/UserDetails.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getloguser();
  }

  String parentlog = '';
  String kidlog = '';
  String publisherlog = '';
  void getloguser() async {
    final pref = await SharedPreferences.getInstance();
    parentlog = pref.getString('tokenlogforparent') ?? '';
    kidlog = pref.getString('tokenlogforkid') ?? '';
    publisherlog = pref.getString('tokenlogforpublisher') ?? '';
    
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userdetail = context.watch<userdetails>();
    final parentdetails = context.watch<AuthPro>();
    final pubbooks = context.watch<GetbookPro>();
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
                    const Divider(
                      color: Colors.grey,
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
                    kidlog != ''
                        ? TextBold(
                            userdetail.kidloading
                                ? ''
                                : userdetail.decoded[0].username,
                            color: themeProvider.themeData.primaryColorDark,
                            fontSize: 16,
                          )
                        : publisherlog != ''
                            ? TextBold(
                                userdetail.publoading
                                    ? ''
                                    : userdetail.decodedpub[0].name,
                                color: themeProvider.themeData.primaryColorDark,
                                fontSize: 16,
                              )
                            : parentlog != ''
                                ? TextBold(
                                    parentdetails.parentloading
                                        ? ''
                                        : parentdetails.decoded[0].fullname,
                                    color: themeProvider
                                        .themeData.primaryColorDark,
                                    fontSize: 16,
                                  )
                                : SizedBox(),
                    const Gap(5),
                    kidlog != ''
                        ? SizedBox()
                        : publisherlog != ''
                            ? TextBody(
                                userdetail.publoading
                                    ? ''
                                    : userdetail.decodedpub[0].email,
                                color: AfroReadsColors.grey,
                                fontSize: 12,
                              )
                            : parentlog != ''
                                ? TextBody(
                                    parentdetails.parentloading
                                        ? ''
                                        : parentdetails.decoded[0].email,
                                    color: AfroReadsColors.grey,
                                    fontSize: 12,
                                  )
                                : SizedBox(),
                  ],
                ),
              ),
              const Gap(30),
              kidlog != ''
                  ? myAccountContainer(
                      context: context,
                      text: "My Profile",
                      textt: "Manage your personal information",
                      image: AppAssets.profile,
                      onTap: () {
                        userdetail.childprofileexist
                            ? Navigator.pushNamed(
                                context, RouteName.managekidprofile)
                            : Navigator.pushNamed(
                                context, RouteName.kidprofilesetting);
                      })
                  : parentlog != ''
                      ? myAccountContainer(
                          context: context,
                          text: "Child Profile",
                          textt: "Manage your Child's information",
                          image: AppAssets.profile,
                          onTap: () {
                            userdetail.childprofileexist
                                ? Navigator.pushNamed(
                                    context, RouteName.managekidprofile)
                                : Navigator.pushNamed(
                                    context, RouteName.kidprofilesetting);
                          })
                      : publisherlog != ''
                          ? myAccountContainer(
                              context: context,
                              text: "My books",
                              textt: "Manage your Book information",
                              image: AppAssets.profile,
                              onTap: () {
                                pubbooks.bookdetails.isEmpty
                                    ? Navigator.pushNamed(
                                        context, RouteName.addbook)
                                    : Navigator.pushNamed(
                                        context, RouteName.managebooks);
                              })
                          : SizedBox(),
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
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      headerAnimationLoop: false,
                      animType: AnimType.topSlide,
                      title: 'Warning',
                      desc: 'This action would log you out of your account',
                      btnCancelOnPress: () {},
                      onDismissCallback: (type) {},
                      btnOkOnPress: () async {
                        final pref = await SharedPreferences.getInstance();
                        pref.remove('tokenlogforparent');
                        pref.remove('tokenlogforkid');
                        pref.remove('tokenlogforpublisher');
                        Navigator.pushNamed(
                            context, RouteName.onboardingScreen);
                      },
                    ).show();
                  }),
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
