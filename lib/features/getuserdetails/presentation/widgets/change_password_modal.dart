import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/password_successful_modal.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({super.key});

  @override
  State<ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool onFocus = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Container(
        height: 450,
        width: double.infinity,
        decoration: BoxDecoration(
          color: themeProvider.themeData.primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),
              Row(
                children: [
                  TextSemiSemiBold(
                    "Change Password",
                    fontSize: 18,
                    color: themeProvider.themeData.primaryColorDark,
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.cancel_outlined))
                ],
              ),
              const Gap(20),
              TextBody(
                "Old Password",
                fontSize: 15,
                color: themeProvider.themeData.primaryColorDark,
              ),
              const Gap(8),
              InputField(
                controller: _oldPasswordController,
                placeholder: '**********',
                password: true,
                fieldColor: themeProvider.themeData.hintColor,
              ),
              const Gap(10),
              TextBody(
                "New Password",
                fontSize: 15,
                color: themeProvider.themeData.primaryColorDark,
              ),
              const Gap(8),
              InputField(
                controller: _newPasswordController,
                placeholder: '**********',
                password: true,
                fieldColor: themeProvider.themeData.hintColor,
              ),
              const Gap(10),
              TextBody(
                "Confirm Password",
                fontSize: 15,
                color: themeProvider.themeData.primaryColorDark,
              ),
              const Gap(8),
              InputField(
                onChanged: (p0) => setState(() {
                  onFocus = true;
                }),
                controller: _confirmPasswordController,
                placeholder: '**********',
                password: true,
                fieldColor: themeProvider.themeData.hintColor,
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BusyButton(
                    borderColor: onFocus
                        ? AfroReadsColors.primaryColor
                        : AfroReadsColors.grey,
                    buttonColor: onFocus
                        ? AfroReadsColors.primaryColor
                        : AfroReadsColors.grey,
                    title: "Update Password",
                    onTap: () {
                      Navigator.of(context).pop();
                      AwesomeDialog(
                        dialogBackgroundColor: Colors.white60,
                        context: context,
                        headerAnimationLoop: false,
                        animType: AnimType.BOTTOMSLIDE,
                        dialogType: DialogType.NO_HEADER,
                        body: const PasswordSuccesfluModal(),
                      ).show();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
