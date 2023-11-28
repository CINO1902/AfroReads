import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/usecases/customesnackbar.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/age_content_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/kid_reading_level_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/kid_unsuitable_genres.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../app/view/widget/app_loading_dialog.dart';
import '../provider/UserDetails.dart';

class RestrictedBooksModal extends StatefulWidget {
  final ThemeProvider themeProvider;
  const RestrictedBooksModal({super.key, required this.themeProvider});

  @override
  State<RestrictedBooksModal> createState() => _RestrictedBooksModalState();
}

class _RestrictedBooksModalState extends State<RestrictedBooksModal> {
  bool isSwitched = false;
  late final themeProvider = Provider.of<ThemeProvider>(context);

  @override
  void initState() {
    // TODO: implement initState
    final userdetail = context.read<userdetails>();
    super.initState();
    setState(() {
      isSwitched = userdetail.profileclicklist[0].restrictionMode != null
          ? userdetail.profileclicklist[0].restrictionMode!
          : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userdetail = context.watch<userdetails>();
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.themeProvider.themeData.primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Content preferences',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBody(
                        "Tailor the content to align with your child's interests\nand what you deem appropriate"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBold(
                          "Restriction Mode",
                          fontSize: 14,
                        ),
                        Switch(
                            activeColor: AfroReadsColors.primaryColor,
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            })
                      ],
                    ),
                    Divider(color: Colors.grey.withOpacity(0.3)),
                    const Gap(2),
                    Visibility(
                      visible: isSwitched,
                      child: Column(
                        children: [
                          myAccountContainer(
                              context: context,
                              text: "Unsuitable Genres",
                              textt:
                                  "Set unsuitable genres for ${userdetail.profileclicklist[0].name}",
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
                                      return KidUnsuitableGenresModal(
                                        themeProvider: themeProvider,
                                        selectedvalue: userdetail
                                                    .profileclicklist[0]
                                                    .unsuitableGenres !=
                                                null
                                            ? userdetail.profileclicklist[0]
                                                    .unsuitableGenres!
                                                    .contains('Violent')
                                                ? 1
                                                : userdetail.profileclicklist[0]
                                                        .unsuitableGenres!
                                                        .contains('Horror')
                                                    ? 2
                                                    : userdetail
                                                            .profileclicklist[0]
                                                            .unsuitableGenres!
                                                            .contains('Sexual')
                                                        ? 3
                                                        : 4
                                            : 4,
                                        restrict: isSwitched,
                                      );
                                    });
                              }),
                          const Gap(5),
                          Divider(color: Colors.grey.withOpacity(0.3)),
                          myAccountContainer(
                              context: context,
                              text: "Age appropriate content",
                              textt:
                                  "select an age range to filter content to be age appropriate",
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
                                      return AgeContentModal(
                                        themeProvider: themeProvider,
                                        selectedvalue: userdetail
                                                    .profileclicklist[0]
                                                    .allowedBookAge !=
                                                null
                                            ? userdetail.profileclicklist[0]
                                                    .allowedBookAge!
                                                    .contains('8')
                                                ? 1
                                                : userdetail.profileclicklist[0]
                                                        .allowedBookAge!
                                                        .contains('13')
                                                    ? 2
                                                    : userdetail
                                                            .profileclicklist[0]
                                                            .allowedBookAge!
                                                            .contains('16')
                                                        ? 3
                                                        : 4
                                            : 4,
                                        restrict: isSwitched,
                                      );
                                    });
                              }),
                          const Gap(5),
                          Divider(color: Colors.grey.withOpacity(0.3)),
                          myAccountContainer(
                              context: context,
                              text: "Reading level",
                              textt:
                                  "Select a reading level for ${userdetail.profileclicklist[0].name}",
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
                                      return KidReadingLevelModal(
                                        themeProvider: themeProvider,
                                        selectedvalue: userdetail
                                                    .profileclicklist[0]
                                                    .readingLevel !=
                                                null
                                            ? userdetail.profileclicklist[0]
                                                    .readingLevel!
                                                    .contains('Beginner')
                                                ? 1
                                                : userdetail.profileclicklist[0]
                                                        .readingLevel!
                                                        .contains(
                                                            'Intermediate')
                                                    ? 2
                                                    : userdetail
                                                            .profileclicklist[0]
                                                            .readingLevel!
                                                            .contains(
                                                                'Advanced')
                                                        ? 3
                                                        : 4
                                            : 4,
                                        restrict: isSwitched,
                                      );
                                    });
                              }),
                          const Gap(5),
                          Divider(color: Colors.grey.withOpacity(0.3)),
                          myAccountContainer(
                            context: context,
                            text: "Content sensitivity filter",
                            textt:
                                "Filter out themes or subjects suitable for your child",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Consumer<userdetails>(builder: (context, value, child) {
                return BusyButton(
                    title: "Done",
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const AppLoadingDialog(
                                text: 'Loading...',
                              ),
                            );
                          });
                      await context
                          .read<userdetails>()
                          .updaterestrictmode(isSwitched, 4);

                      if (value.restricterror == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          dismissDirection: DismissDirection.up,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 200),
                          content: CustomeSnackbar(
                            topic: 'Oh Snap!',
                            msg: value.msg,
                            color1: Color.fromARGB(255, 171, 51, 42),
                            color2: Color.fromARGB(255, 127, 39, 33),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ));
                      } else if (value.restricterror == false) {
                        print('object');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          dismissDirection: DismissDirection.up,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 200),
                          content: CustomeSnackbar(
                            topic: 'Great!',
                            msg: value.msg,
                            color1: Color.fromARGB(255, 25, 107, 52),
                            color2: Color.fromARGB(255, 19, 95, 40),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ));

                        // ignore: use_build_context_synchronously
                      }
                      Navigator.of(context).pop();
                    });
              })
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector myAccountContainer(
      {text, textt, onTap, required BuildContext context}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
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
