import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/addbooks/presentation/provider/uploadimageprovider.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SelectAgeModal extends StatefulWidget {
  final ThemeProvider themeProvider;

  const SelectAgeModal({super.key, required this.themeProvider});

  @override
  State<SelectAgeModal> createState() => _SelectAgeModalState();
}

class _SelectAgeModalState extends State<SelectAgeModal> {
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
                "Select Appropraite age For this book",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.21,
                child: ListView(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Below age 8"),
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
                        const Text("Age  9 - 13"),
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
                        const Text("Age 13 - 16"),
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
                    context
                        .read<uploadimageprovider>()
                        .collectbookage(selectedValue);
                    Navigator.of(context).pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
