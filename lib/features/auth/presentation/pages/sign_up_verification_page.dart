// ignore_for_file: avoid_print, camel_case_types

import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/app_loading_dialog.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/auth/presentation/widgets/verfication_successful_modal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignUpVerificationPage extends StatefulWidget {
  const SignUpVerificationPage({
    Key? key,
  }) : super(key: key);
  @override
  State<SignUpVerificationPage> createState() => _SignUpVerificationPageState();
}

class _SignUpVerificationPageState extends State<SignUpVerificationPage> {
  final TextEditingController _pinController = TextEditingController();
  verifyCode() {
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () async {
      Navigator.pop(context);
      await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          context: context,
          builder: (context) {
            return const VerificationSuccessfulModal();
          });
    });
  }

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                const AfroReadsBackButton(),
                const Gap(23),
                TextBody(
                  'Verify your account',
                  fontSize: 25,
                ),
                const Gap(16),
                const FittedBox(
                  child: Text.rich(
                    TextSpan(
                        text: 'Check your email',
                        style: TextStyle(
                          color: AfroReadsColors.grey,
                          fontSize: 15,
                          // fontFamily: IklinFont.euclid,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: ' caleboruta14@gmail.com',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AfroReadsColors.textColor),
                          ),
                          TextSpan(
                            text: ' for a code',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AfroReadsColors.grey),
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(53),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    controller: _pinController,
                    cursorHeight: 24,
                    appContext: context,
                    showCursor: true,
                    cursorColor: const Color(0xff37474F),
                    textStyle: const TextStyle(
                      // fontFamily: IklinFont.euclid,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: AfroReadsColors.textColor,
                    ),
                    length: 4,
                    onCompleted: (value) async {
                      print('Verify otp');
                      // await getIt<AuthNotifier>().activateBasicSignnup(
                      //   context,
                      //   email: widget.params.email,
                      //   otp: _pinController.text.trim(),
                      // );
                    },
                    onChanged: (value) {
                      print(_pinController.text);
                    },
                    pinTheme: PinTheme(
                      fieldHeight: 60,
                      activeColor: AfroReadsColors.primaryColor,
                      selectedColor: AfroReadsColors.grey.withOpacity(0.7),
                      inactiveColor: AfroReadsColors.grey.withOpacity(0.7),
                      fieldWidth: 62,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const Gap(10),
                Align(
                  alignment: Alignment.center,
                  child: TextBody(
                    '0.59',
                    fontSize: 15,
                  ),
                ),
                const Gap(20),
                const Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                        text: 'Didn\'t receive a verification code?',
                        style: TextStyle(
                          color: AfroReadsColors.textColor,
                          fontSize: 15,
                          // fontFamily: IklinFont.euclid,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: ' Send again',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AfroReadsColors.primaryColor),
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(60),
                BusyButton(
                    title: "Verify account",
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const AppLoadingDialog(
                                text: 'Verifying Code',
                              ),
                            );
                          });
                      verifyCode();
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
