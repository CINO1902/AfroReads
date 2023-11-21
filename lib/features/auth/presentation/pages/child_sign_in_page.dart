// ignore_for_file: use_build_context_synchronously

import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/core/usecases/customesnackbar.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../app/view/widget/app_loading_dialog.dart';

class ChildSignUpPage extends StatefulWidget {
  const ChildSignUpPage({super.key});

  @override
  State<ChildSignUpPage> createState() => _ChildSignUpPage();
}

class _ChildSignUpPage extends State<ChildSignUpPage> {
    final _formKey = GlobalKey<FormState>();

  final TextEditingController _parentEmailController = TextEditingController();
  final TextEditingController _parentPasswordController =
      TextEditingController();
  bool isChecked = false;

  void handlerequest(AuthPro value) async {
    if (_formKey.currentState!.validate()) {
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
        .read<AuthPro>()
        .login(_parentEmailController.text, _parentPasswordController.text);

    if (value.loginerror == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomeSnackbar(
          topic: 'Oh Snap!',
          msg: 'Something went wrong',
          color1: const Color.fromARGB(255, 171, 51, 42),
          color2: const Color.fromARGB(255, 127, 39, 33),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      if (value.status == 'false') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
        Navigator.pushNamed(context, RouteName.indexPage);
      }
    }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfroReadsColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                          "Child log in",
                          fontSize: 20,
                          color: AfroReadsColors.textColor,
                        ),
                        const Gap(10),
                        TextBody(
                          "Young adventurers, your stories await!",
                          fontSize: 14,
                          color: AfroReadsColors.textColor,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const Gap(30),
                  TextBody('Email Address', color: AfroReadsColors.textColor),
                  const Gap(8),
                   Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(7)),
                      child: TextFormField(
                        controller: _parentEmailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            labelText: 'Ibidapodavid10@gmail.com',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            fillColor: Colors.black54,
                            focusColor: Colors.black54),
                      ),
                    ),
                  // InputField(
                  //   controller: _parentEmailController,
                  //   placeholder: 'abcdef@gmail.com',
                  // ),
                  const Gap(16),
                  TextBody('Password', color: AfroReadsColors.textColor),
                  const Gap(8),
                  // InputField(
                  //   controller: _parentPasswordController,
                  //   password: true,
                  //   placeholder: '6+ characters',
                  // ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(7)),
                      child: TextFormField(
                        controller: _parentPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Field is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            labelText: '6+ characters',
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            fillColor: Colors.black54,
                            focusColor: Colors.black54),
                      ),
                    ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              activeColor: AfroReadsColors.primaryColor,
                              value: isChecked,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked = newValue!;
                                });
                              }),
                          TextBody(
                            "Remember me",
                            fontSize: 14,
                          ),
                        ],
                      ),
                      TextBody(
                        "Forget password",
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const Gap(50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Consumer<AuthPro>(builder: (context, value, child) {
                      return BusyButton(
                          title: "Log In",
                          onTap: () async {
                            handlerequest(value);
                          });
                    }),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextSemiBold(
                        "Don't have an account? ",
                        fontSize: 14,
                      ),
                      TextSemiBold(
                        "Create Account",
                        fontSize: 14,
                        color: AfroReadsColors.primaryColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}
