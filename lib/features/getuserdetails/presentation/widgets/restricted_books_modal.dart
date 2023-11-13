import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/age_content_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/kid_reading_level_modal.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/kid_unsuitable_genres.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
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
                              textt: "Set unsuitable genres for Caleb",
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
                                      );
                                    });
                              }),
                          const Gap(5),
                          Divider(color: Colors.grey.withOpacity(0.3)),
                          myAccountContainer(
                              context: context,
                              text: "Reading level",
                              textt: "Select a reading level for Caleb",
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
              BusyButton(
                  title: "Done",
                  onTap: () {
                    Navigator.of(context).pop();
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
