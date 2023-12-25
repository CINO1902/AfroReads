import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/usecases/customesnackbar.dart';

import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../app/view/widget/app_loading_dialog.dart';
import '../provider/UserDetails.dart';

class KidReadingLevelModal extends StatefulWidget {
  final ThemeProvider themeProvider;
  int selectedvalue;
  bool restrict;

  KidReadingLevelModal(
      {super.key,
      required this.themeProvider,
      required this.selectedvalue,
      required this.restrict});

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
          color: widget.themeProvider.themeData.colorScheme.primaryContainer,
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
                            groupValue: widget.selectedvalue,
                            onChanged: (value) {
                              setState(() {
                                widget.selectedvalue = value!;
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
                            groupValue: widget.selectedvalue,
                            onChanged: (value) {
                              setState(() {
                                widget.selectedvalue = value!;
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
                            groupValue: widget.selectedvalue,
                            onChanged: (value) {
                              setState(() {
                                widget.selectedvalue = value!;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(30),
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
                      await context.read<userdetails>().updatereadinglevel(
                          widget.restrict, widget.selectedvalue);

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
}
