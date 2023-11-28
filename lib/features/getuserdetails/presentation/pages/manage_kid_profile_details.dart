import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/getuserdetails/presentation/provider/UserDetails.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/restricted_books_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/screen_time_modal.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ManageKidProfileDetais extends StatefulWidget {
  const ManageKidProfileDetais({super.key});

  @override
  State<ManageKidProfileDetais> createState() => _ManageKidProfileDetaisState();
}

class _ManageKidProfileDetaisState extends State<ManageKidProfileDetais> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<userdetails>().fetchchildID();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userdetail = context.watch<userdetails>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          userdetail.loading ? '' : userdetail.profileclicklist[0].name,
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            const Gap(10),
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(AppAssets.childavatar)),
                  const Gap(15),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Name: ${userdetail.profileclicklist[0].name}"),
                        Text(
                            "Age:  ${userdetail.calculateage(userdetail.profileclicklist[0].dateOfBirth).toString()} years"),
                        Text("Last seen: 2 hours ago")
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Gap(12),
            TextBold(
              'Edit Profile',
              color: AfroReadsColors.primaryColor,
              fontSize: 14,
            ),
            const Gap(35),
            myAccountContainer(
                context: context,
                text: "Category List",
                textt: "Manage your kid's Category List",
                image: AppAssets.profile,
                onTap: () {}),
            const Gap(5),
            Divider(color: Colors.grey.withOpacity(0.3)),
            myAccountContainer(
                context: context,
                text: "Restricted books",
                textt: "Customize your child's reading options",
                image: AppAssets.mylibrary,
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
                        return RestrictedBooksModal(
                          themeProvider: themeProvider,
                        );
                      });
                }),
            const Gap(5),
            Divider(color: Colors.grey.withOpacity(0.3)),
            const Gap(5),
            myAccountContainer(
                context: context,
                text: "Reading Timer & Screen time",
                textt: "Set limits for healthy screen habits",
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
                        return ScreenTimeModal(
                          themeProvider: themeProvider,
                        );
                      });
                }),
            const Gap(5),
            Divider(color: Colors.grey.withOpacity(0.3)),
            myAccountContainer(
              context: context,
              text: "Achievement & Progress",
              textt: "Track their growth, book by book",
              image: AppAssets.about,
            ),
            const Gap(5),
            Divider(color: Colors.grey.withOpacity(0.3)),
            myAccountContainer(
              context: context,
              text: "Subscription",
              textt: "Stay updated on your subscription perks",
              image: AppAssets.about,
            ),
            const Gap(5),
            Divider(color: Colors.grey.withOpacity(0.3)),
          ],
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
