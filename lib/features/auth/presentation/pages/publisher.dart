import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/core/usecases/customesnackbar.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../app/view/widget/app_loading_dialog.dart';

class PublisherSignInPage extends StatefulWidget {
  const PublisherSignInPage({super.key});

  @override
  State<PublisherSignInPage> createState() => _PublisherSignInPageState();
}

class _PublisherSignInPageState extends State<PublisherSignInPage> {
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
                        "Publisher log in",
                        fontSize: 20,
                        color: AfroReadsColors.textColor,
                      ),
                      const Gap(10),
                      TextBody(
                        "Publisher, Add and update the\nreading experience here.",
                        fontSize: 14,
                        color: AfroReadsColors.textColor,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Gap(30),
                TextBody('Username', color: AfroReadsColors.textColor),
                const Gap(8),
                InputField(
                  controller: _parentEmailController,
                  placeholder: 'caleboruta.co@gmail.com',
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
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.publishersignup);
                      },
                      child: TextSemiBold(
                        "Create Account",
                        fontSize: 14,
                        color: AfroReadsColors.primaryColor,
                      ),
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
    await context
        .read<AuthPro>()
        .loginpub(_parentEmailController.text, _parentPasswordController.text);

    if (value.loginerror == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomeSnackbar(
          topic: 'Oh Snap!',
          msg: value.errormsg,
          color1: Color.fromARGB(255, 171, 51, 42),
          color2: Color.fromARGB(255, 127, 39, 33),
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
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.indexPage, (Route<dynamic> route) => false);
      }
    }
  }
}
