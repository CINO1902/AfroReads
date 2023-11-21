import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DailyScreenTimeModal extends StatefulWidget {
  final ThemeProvider themeProvider;

  const DailyScreenTimeModal({super.key, required this.themeProvider});

  @override
  State<DailyScreenTimeModal> createState() => _DailyScreenTimeModalState();
}

class _DailyScreenTimeModalState extends State<DailyScreenTimeModal> {
  bool isSwitched = false;
  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              "Set Caleb’s daily time",
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
                      const Text("Set the same limit every day"),
                      Radio(
                          activeColor: AfroReadsColors.primaryColor,
                          value: 1,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = false;
                              selectedValue = value;
                            });
                          }),
                    ],
                  ),
                  if (!isSwitched)
                    Container(
                      color: Colors.red,
                      child: Visibility(
                        visible: !isSwitched,
                        maintainSize: false,
                        maintainAnimation: false,
                        child: const Column(
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Time"),
                                Text("2h"),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Set a custom time limit"),
                      Radio(
                          activeColor: AfroReadsColors.primaryColor,
                          value: 2,
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = true;
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
    );
  }
}
