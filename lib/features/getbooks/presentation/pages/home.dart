import 'package:afroreads/core/constants/app_assets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                      child: SvgPicture.asset(AppAssets.menu)),
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
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Hello Dora,',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(10)),
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Search by Book title, Author',
                  hintStyle: TextStyle(fontSize: 12),
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            const Gap(20),
            const SizedBox(
                height: 30,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Folktales'),
                      Text('History'),
                      Text('Fiction'),
                      Text('Non-Fiction'),
                      Text('Lifestyle')
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
