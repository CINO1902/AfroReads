import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    TextBold("My Account"),
                    const Gap(15),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AfroReadsColors.primaryColor,
                          )),
                      child: Image.asset(
                        AppAssets.parentOnBoardingImage2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextBody("Vincent Florence"),
                    const Gap(10),
                    TextBody("follybaby1996_12@gmail.com"),
                  ],
                ),
              ),
              const Gap(30),
              Container(
                color: Colors.pink,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.red,
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBody("Child Profiles"),
                            TextBody("Manage your personal information")
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
