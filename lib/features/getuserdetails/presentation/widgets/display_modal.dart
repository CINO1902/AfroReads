import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/provider/theme_provider.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DisplayModal extends StatelessWidget {
  final ThemeProvider themeProvider;

  const DisplayModal({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AfroReadsColors.white,
          borderRadius: BorderRadius.only(
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
                'Select Theme Mode:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(15),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    borderRadius: BorderRadius.circular(5)),
                height: MediaQuery.of(context).size.height * 0.21,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RadioListTile<ThemeModeType>(
                      title: const Text('Light'),
                      value: ThemeModeType.light,
                      groupValue: themeProvider.themeModeType,
                      onChanged: (value) {
                        themeProvider.setThemeMode(value!);
                      },
                    ),
                    RadioListTile<ThemeModeType>(
                      title: const Text('Dark'),
                      value: ThemeModeType.dark,
                      groupValue: themeProvider.themeModeType,
                      onChanged: (value) {
                        themeProvider.setThemeMode(value!);
                      },
                    ),
                    RadioListTile<ThemeModeType>(
                      title: const Text('System'),
                      value: ThemeModeType.system,
                      groupValue: themeProvider.themeModeType,
                      onChanged: (value) {
                        themeProvider.setThemeMode(value!);
                      },
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
