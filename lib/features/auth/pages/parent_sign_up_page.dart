import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ParentSignUpPage extends StatefulWidget {
  const ParentSignUpPage({super.key});

  @override
  State<ParentSignUpPage> createState() => _ParentSignUpPageState();
}

class _ParentSignUpPageState extends State<ParentSignUpPage> {
    final TextEditingController _parentEmailController = TextEditingController();
    final TextEditingController _parentPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfroReadsColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBold("Parent log in",
                      fontSize: 16,
                      color: AfroReadsColors.textColor,
                      ),
                      TextBody(
                        "Parents, manage and customize the\nreading experirnce here.",
                        fontSize: 13,
                        color: AfroReadsColors.textColor,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                TextBody('Email Address', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _parentEmailController,
                  placeholder: 'abcdef@gmail.com',
                ),
                const Gap(16),
                 TextBody('Password', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _parentPasswordController,
                  password: true,
                  placeholder: '6+ characters',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
