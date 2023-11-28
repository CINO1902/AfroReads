import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:group_button/group_button.dart';


class KidUnsuitableGenresModal extends StatefulWidget {
  final ThemeProvider themeProvider;

  const KidUnsuitableGenresModal({super.key, required this.themeProvider});

  @override
  State<KidUnsuitableGenresModal> createState() =>
      _KidUnsuitableGenresModalState();
}

class _KidUnsuitableGenresModalState extends State<KidUnsuitableGenresModal> {
  List<String> selectedOptions = [];

  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.40,
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
                "Select unsuitable genres",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: 
                Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          activeColor: AfroReadsColors.primaryColor,
          title: const Text('Violent'),
          value: selectedOptions.contains('Violent'),
          onChanged: (value) {
            setState(() {
              updateSelectedOptions('Violent', value!);
            });
          },
        ),
        const Divider(),
        CheckboxListTile(
          activeColor: AfroReadsColors.primaryColor,
          title: const Text('Horror'),
          value: selectedOptions.contains('Horror'),
          onChanged: (value) {
            setState(() {
              updateSelectedOptions('Horror', value!);
            });
          },
        ),
        const Divider(),
        CheckboxListTile(
          activeColor: AfroReadsColors.primaryColor,
          title: const Text('Sexual'),
          value: selectedOptions.contains('Sexual'),
          onChanged: (value) {
            setState(() {
              updateSelectedOptions('Sexual', value!);
            });
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
   void updateSelectedOptions(String option, bool selected) {
    if (selected) {
      selectedOptions.add(option);
    } else {
      selectedOptions.remove(option);
    }
  }
}
