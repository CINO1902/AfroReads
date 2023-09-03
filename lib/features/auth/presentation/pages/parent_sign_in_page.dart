import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ParentSignUpPage extends StatefulWidget {
  const ParentSignUpPage({super.key});

  @override
  State<ParentSignUpPage> createState() => _ParentSignUpPageState();
}

class _ParentSignUpPageState extends State<ParentSignUpPage> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        "Parent log in",
                        fontSize: 20,
                        color: AfroReadsColors.textColor,
                      ),
                      const Gap(10),
                      TextBody(
                        "Parents, manage and customize the\nreading experirnce here.",
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
                          //  context.read<AuthPro>().createaccount();
                          // if(value)
                          Navigator.pushNamed(context, RouteName.indexPage);
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
    );
  }
}
