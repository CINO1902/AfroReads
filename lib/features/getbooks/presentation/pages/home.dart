import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/getbooks/presentation/pages/book_type/fiction.dart';

import 'package:afroreads/features/getbooks/presentation/pages/book_type/folktales.dart';
import 'package:afroreads/features/getbooks/presentation/pages/book_type/history.dart';
import 'package:afroreads/features/getbooks/presentation/pages/book_type/lifestyle.dart';

import 'package:afroreads/features/search/presentation/Provider/SearchPro.dart';
import 'package:afroreads/features/search/presentation/widgets/searchload.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool loading = true;

class _HomeState extends State<Home> {
  List tabb = [
    const Folktales(),
    const Fiction(),
    const History(),
    const Lifestyle()
  ];
  List<String> tabs = ["Folktales", "History", "Fiction", "Lifestyle"];

  int current = 0;

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 0;
      case 1:
        return 90;
      case 2:
        return 180;
      case 3:
        return 260;

      default:
        return 0;
    }
  }

  double changeContainerWWidth() {
    switch (current) {
      case 0:
        return 70;
      case 1:
        return 65;
      case 2:
        return 60;
      case 3:
        return 70;

      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 24,
                  width: 74,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        AppAssets.menu,
                        color: themeProvider.themeData.primaryColorDark,
                      )),
                ),
                SizedBox(
                  height: 50,
                  width: 70,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        SizedBox(
                            width: 30,
                            child: Image.asset(AppAssets.profileicon)),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Hello Dora,',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                final searchpro = context.read<Searchpro>();
                final color = Theme.of(context);
                showSearch(
                    context: context,
                    delegate: MySearchDelegate(searchpro, color));
              },
              child: Stack(
                children: [
                  InputField(
                    controller: TextEditingController(),
                    placeholder: 'Search',
                    fieldColor: AfroReadsColors.white.withOpacity(0.4),
                    validationColor: AfroReadsColors.grey.withOpacity(
                      0.2,
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.only(
                        right: 11,
                      ),
                      // child: SvgPicture.asset(
                      //   // AppAssets.searchIcon,
                      // ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 70,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
            const Gap(10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.04,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.03,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tabs.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: current == 0 ? 15 : 10,
                                    top: 10,
                                    right: 30),
                                child: Text(
                                  tabs[index],
                                  style: TextStyle(
                                      fontSize: current == index ? 16 : 14,
                                      fontWeight: current == index
                                          ? FontWeight.w400
                                          : FontWeight.w300),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: 0,
                    left: changePositionedOfLine(),
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.only(left: 10),
                      width: changeContainerWWidth(),
                      height: MediaQuery.of(context).size.height * 0.003,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AfroReadsColors.primaryColor),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.58,
              child: tabb[current],
            )
          ],
        ),
      )),
    );
  }
}
