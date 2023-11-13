import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
class KidReadingLevelModal extends StatefulWidget {
  final ThemeProvider themeProvider;

  const KidReadingLevelModal({super.key, required this.themeProvider});

  @override
  State<KidReadingLevelModal> createState() => _KidReadingLevelModalState();
}

class _KidReadingLevelModalState extends State<KidReadingLevelModal> {
  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.42,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.themeProvider.themeData.primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Select your kid’s reading level",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.21,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Beginner"),
                        Radio(
                            activeColor: AfroReadsColors.primaryColor,
                            value: 1,
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            }),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Intermediate"),
                        Radio(
                            activeColor: AfroReadsColors.primaryColor,
                            value: 2,
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            }),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Advanced"),
                        Radio(
                            activeColor: AfroReadsColors.primaryColor,
                            value: 3,
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(30),
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
}
