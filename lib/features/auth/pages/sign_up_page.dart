import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AfroReadsColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(28),
                TextBody(
                  'Create Account',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                const Gap(5),
                TextBody(
                  'We are thrilled to have you here! ',
                  fontSize: 15,
                ),
                const Gap(32),
                TextBody('Full Name', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _firstnameController,
                  placeholder: 'Enter your first name',
                ),
                const Gap(16),
                TextBody('Email Address', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _lastnameController,
                  placeholder: 'abcdef@gmail.com',
                ),
                const Gap(16),
                TextBody('Password', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _passwordController,
                  password: true,
                  placeholder: '6+ characters',
                ),
                const Gap(16),
                TextBody('Confirm Password', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _confirmPasswordController,
                  password: true,
                  placeholder: '6+ characters',
                ),
                const Gap(16),
                TextBody('Date of Birth', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _dateOfBirthController,
                  placeholder: 'DD/MM/YYYY',
                ),
                const Gap(16),
                TextBody('Security Question', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _passwordController,
                  placeholder: 'My pet name',
                ),
                const Gap(16),
                TextBody('Answer', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _answerController,
                  placeholder: 'Cino',
                ),
                const Gap(48),
                BusyButton(
                    title: 'Create an Account',
                    onTap: () {
                      // Navigator.pushNamed(context, RouteName.letsGoScreen);
                    }),
                const Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
