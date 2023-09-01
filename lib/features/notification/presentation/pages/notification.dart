import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AfroReadsColors.background,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Align(
                alignment: Alignment.center,
                child: TextBold(
                  "Notification",
                  fontSize: 20,
                ),
              ),
              const Gap(25),
              InputField(
                controller: TextEditingController(),
                placeholder: 'Search',
                fieldColor: AfroReadsColors.white.withOpacity(0.4),
                validationColor: AfroReadsColors.grey.withOpacity(
                  0.2,
                ),
                prefix: const Padding(
                  padding:  EdgeInsets.only(
                    right: 11,
                  ),
                  // child: SvgPicture.asset(
                  //   // AppAssets.searchIcon,
                  // ),
                ),
              ),
              const Gap(11),
              const Expanded(
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        myContainer(),
                        SizedBox(
                          height: 5,
                        ),
                        myContainer(),
                        SizedBox(
                          height: 5,
                        ),
                        myContainer(),
                        SizedBox(
                          height: 5,
                        ),
                        myContainer(),
                        SizedBox(
                          height: 5,
                        ),
                        myContainer(),
                        SizedBox(
                          height: 5,
                        ),
                        myContainer(),
                        SizedBox(
                          height: 5,
                        ),
                        myContainer(),
                        SizedBox(
                          height: 5,
                        ),
                        myContainer(),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

// ignore: camel_case_types
class myContainer extends StatelessWidget {
  const myContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(.3)),
        borderRadius: BorderRadius.circular(10),
        color: AfroReadsColors.white.withOpacity(0.4),
      ),
      height: 110,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    TextBold(
                  "New Boook Arrival",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 7,
                ),
               FittedBox(
                  child: TextBody(
                    "New Arrival Alert ! Discover the latest addition to our library",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                FittedBox(
                  child: TextBody(
                    "Dive into a world of captivating stories and intriguing characters",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                 TextBody(
                  "Do not miss out this literary masterpiece.",
                  style: const TextStyle(fontSize: 15),
                )
            ],
          ),
        ),
      ),
      // child: FittedBox(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       TextSemiBold(
      //         "Glad you signed up Hammed",
      //         style: const TextStyle(fontSize: 15),
      //       ),
      //       const SizedBox(
      //         height: 7,
      //       ),
      //       FittedBox(
      //         child: TextBody(
      //           "Say HELLO to the smart way of doing your",
      //           style: const TextStyle(fontSize: 15),
      //         ),
      //       ),
      //       FittedBox(
      //         child: TextBody(
      //           "laundry and house cleaning.Book now and",
      //           style: const TextStyle(fontSize: 15),
      //         ),
      //       ),
      //       TextBody(
      //         "enjoy easy laundry and cleaning",
      //         style: const TextStyle(fontSize: 15),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
