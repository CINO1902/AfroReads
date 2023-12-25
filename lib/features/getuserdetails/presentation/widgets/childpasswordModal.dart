import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/app_loading_dialog.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/usecases/customesnackbar.dart';
import 'package:afroreads/features/getuserdetails/presentation/provider/UserDetails.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/daily_screen_time_modal.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ChildPassword extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ChildPassword({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final userdetail = context.watch<userdetails>();
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        width: double.infinity,
        decoration: BoxDecoration(
          color: themeProvider.themeData.colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Child Password',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Username:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              context
                                  .watch<userdetails>()
                                  .profileclicklist[0]
                                  .username,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                    Gap(30),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Password:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  context
                                      .watch<userdetails>()
                                      .profileclicklist[0]
                                      .password,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Gap(10),
                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: Provider.of<userdetails>(context,
                                              listen: false)
                                          .profileclicklist[0]
                                          .password));
                                  SmartDialog.showToast('Password Copied');
                                },
                                child: Icon(
                                  Icons.copy,
                                  size: 17,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector myAccountContainer(
      {text, textt, onTap, required BuildContext context}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBold(
                      text,
                      color: themeProvider.themeData.primaryColorDark,
                      fontSize: 14,
                    ),
                    const Gap(5),
                    TextBody(
                      textt,
                      color: AfroReadsColors.grey,
                      fontSize: 12,
                    )
                  ],
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: AfroReadsColors.grey.withOpacity(.7),
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
