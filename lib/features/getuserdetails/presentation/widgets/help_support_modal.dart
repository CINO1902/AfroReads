import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/app_loading_dialog.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/helpsuccessmodal.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HelpSupportModal extends StatefulWidget {
  const HelpSupportModal({super.key});

  @override
  State<HelpSupportModal> createState() => _HelpSupportModalState();
}

class _HelpSupportModalState extends State<HelpSupportModal> {
  final TextEditingController _supportSubjectController =
      TextEditingController();
  final TextEditingController _supportMessageController =
      TextEditingController();
  bool onFocus = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Container(
        height: 500,
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
              Align(
                alignment: Alignment.center,
                child: TextBold(
                  "Help & Support",
                  fontSize: 18,
                  color: themeProvider.themeData.primaryColorDark,
                ),
              ),
              const Gap(20),
              TextBody(
                "How can we help you?",
                fontSize: 15,
                color: themeProvider.themeData.primaryColorDark,
              ),
              const Gap(16),
              TextBody(
                "Subject",
                fontSize: 15,
                color: themeProvider.themeData.primaryColorDark,
              ),
              const Gap(8),
              InputField(
                controller: _supportSubjectController,
                placeholder: 'Unable to add to library',
                fieldColor: themeProvider.themeData.hintColor,
              ),
              const Gap(10),
              TextBody(
                "Message",
                fontSize: 15,
                color: themeProvider.themeData.primaryColorDark,
              ),
              const Gap(8),
              InputField(
                onChanged: (p0) => setState(() {
                  onFocus = true;
                }),
                maxLines: 4,
                maxLength: 7,
                fieldHeight: 119,
                fieldColor: themeProvider.themeData.hintColor,
                controller: _supportMessageController,
                placeholder:
                    'I am having issues adding books to library. kindly look into this. Thanks',
              ),
              const Gap(50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BusyButton(
                    borderColor: onFocus
                        ? AfroReadsColors.primaryColor
                        : AfroReadsColors.grey,
                    buttonColor: onFocus
                        ? AfroReadsColors.primaryColor
                        : AfroReadsColors.grey,
                    title: "Submit request",
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const AppLoadingDialog(
                                text: 'Submitting Query',
                              ),
                            );
                          });
                      verifyCode();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
  verifyCode() {
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () async {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        animType: AnimType.BOTTOMSLIDE,
        dialogType: DialogType.NO_HEADER,
        body: const helpsuccessmodal(),
      ).show();
    });
  }
}
