import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/styles/fonts.dart';
import '../../../../app/view/widget/back_button.dart';
import '../../../../app/view/widget/busy_button.dart';
import '../../../../app/view/widget/input_input.dart';
import '../../../../core/constants/app_colors.dart';

class Createkidprofile extends StatefulWidget {
  const Createkidprofile({super.key});

  @override
  State<Createkidprofile> createState() => _CreatekidprofileState();
}

class _CreatekidprofileState extends State<Createkidprofile> {
  final TextEditingController _parentEmailController = TextEditingController();
  final TextEditingController _parentPasswordController =
      TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfroReadsColors.background,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    const AfroReadsBackButton(),
                    const Gap(13),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextBold(
                            "Create Child Profile",
                            fontSize: 20,
                            color: AfroReadsColors.textColor,
                          ),
                        ],
                      ),
                    ),
                    const Gap(30),
                    TextBody('Child Name', color: AfroReadsColors.textColor),
                    const Gap(8),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        cursorHeight: 15,
                        onChanged: (value) {
                          setState(() {
                            // email = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        // validator: _validateEmail,
                        decoration: InputDecoration(
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.7),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 70, 70, 70),
                                width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 70, 70, 70),
                                width: 1.7),
                          ),
                          hintText: 'Enter Your Email Address',
                        ),
                      ),
                    ),
                    const Gap(16),
                    TextBody('Age', color: AfroReadsColors.textColor),
                    const Gap(8),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        cursorHeight: 15,
                        onChanged: (value) {
                          setState(() {
                            //  email = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        // validator: _validateEmail,
                        decoration: InputDecoration(
                            errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.7),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 70, 70, 70),
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 70, 70, 70),
                                  width: 1.7),
                            ),
                            hintText: 'Enter Your Email Address',
                        hintStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark)),
                      ),
                    ),
                    const Gap(16),
                    TextBody('Child Name', color: AfroReadsColors.textColor),
                    const Gap(8),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        cursorHeight: 15,
                        autocorrect: false,
                        onChanged: (value) {
                          setState(() {
                            // email = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        // validator: _validateEmail,
                        decoration: InputDecoration(
                          errorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.7),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 70, 70, 70),
                                width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 70, 70, 70),
                                width: 1.7),
                          ),
                          hintText: 'Enter Your Email Address',
                        ),
                      ),
                    ),
                    const Gap(50),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: BusyButton(title: "Log In", onTap: () async {})),
                    const Gap(10),
                  ],
                ),
              ))),
    );
  }
}
