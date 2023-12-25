import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/app_loading_dialog.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/usecases/customesnackbar.dart';
import 'package:afroreads/features/getuserdetails/presentation/provider/UserDetails.dart';
import 'package:afroreads/features/getuserdetails/presentation/widgets/daily_screen_time_modal.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ScreenTimeModal extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ScreenTimeModal({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final userdetail = context.watch<userdetails>();
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.42,
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
                'Screen time',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.21,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    myAccountContainer(
                        context: context,
                        text: "Daily screen time",
                        textt: "Set daily checkpoint for screen time",
                        onTap: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return DailyScreenTimeModal(
                                  themeProvider: themeProvider,
                                  customTime: userdetail
                                              .profileclicklist[0].customTime !=
                                          null
                                      ? userdetail
                                          .profileclicklist[0].customTime!
                                      : false,
                                  Weektime: userdetail.profileclicklist[0].time,
                                  gentime: userdetail
                                              .profileclicklist[0].gentime !=
                                          null
                                      ? userdetail.profileclicklist[0].gentime!
                                      : 2,
                                );
                              });
                        }),
                    const Gap(5),
                    Divider(color: Colors.grey.withOpacity(0.3)),
                    myAccountContainer(
                      context: context,
                      text: "Screen time breaks",
                      textt:
                          "Set reminder for Ibidapo to take break from reading.",
                      onTap: () {},
                    ),
                    const Gap(5),
                    Divider(color: Colors.grey.withOpacity(0.3)),
                    myAccountContainer(
                      context: context,
                      text: "Weekly screen time updates",
                      textt:
                          "Stay up-to to -date on bidapo’s time fronm the app. ",
                    ),
                  ],
                ),
              ),
              const Gap(30),
              Consumer<userdetails>(builder: (context, value, child) {
                return BusyButton(
                    title: "Done",
                    onTap: () async {
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
                      // await context.read<userdetails>().changeCustomTime();

                      if (value.restricterror == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          dismissDirection: DismissDirection.up,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 200),
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
                      } else if (value.restricterror == false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          dismissDirection: DismissDirection.up,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 200),
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
                      }
                      Navigator.of(context).pop();
                    });
              })
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
