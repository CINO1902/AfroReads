// ignore_for_file: unnecessary_string_interpolations
import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/app_loading_dialog.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  String? selectedOption;

  // List of options for the dropdown
  List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

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
                const Gap(20),
                const AfroReadsBackButton(),
                const Gap(23),
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
                const Gap(25),
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
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
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
                PopupMenuButton<String>(
                  color: AfroReadsColors.white,
                  onSelected: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return options.map((String option) {
                      return PopupMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList();
                  },
                  child: IgnorePointer(
                    child: InputField(
                      controller: _passwordController,
                      placeholder: '${selectedOption ?? "My pet name"}',
                      suffix: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ),
                const Gap(16),
                TextBody('Answer', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _answerController,
                  placeholder: 'Cino',
                ),
                const Gap(48),
                Consumer<AuthPro>(builder: (context, value, child) {
                  return BusyButton(
                    title: 'Create an Account',
                    onTap: () {
                      handlerequest(value);
                    },
                  );
                }),
                const Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handlerequest(AuthPro value) async {
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
    await context.read<AuthPro>().createaccount(
        _firstnameController.text,
        _emailController.text,
        _passwordController.text,
        _dateOfBirthController.text,
        selectedOption,
        _answerController.text);
    Navigator.pop(context);
    if (value.status == 'fail') {
      SmartDialog.showToast(value.msg);
    } else {
      SmartDialog.showToast(value.msg);
      Navigator.pushNamed(context, RouteName.signUpVerificationPage);
    }
  }
}