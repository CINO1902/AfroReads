import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/features/getbooks/presentation/widgets/shimmerwidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool loading = true;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
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
                )),
            FutureBuilder(
              future: Future.delayed(
                  const Duration(
                    seconds: 4,
                  ), () async {
                setState(() {
                  loading = false;
                });
              }),
              builder: (context, snapshot) {
                if (loading == true) {
                  return ShimmerWidget.rectangle(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset(AppAssets.banner),
                  );
                }
              },
            ),
            const Gap(15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Books',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'See More',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Gap(10),
            SizedBox(
              height: 230,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  if (loading == true) {
                    return ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 163,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 13,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 16,
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 163,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 13,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 16,
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 163,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 13,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 16,
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAssets.book1,
                              width: 130,
                              height: 163,
                            ),
                            const Gap(5),
                            Text(
                              'Purple Hibiscus',
                              style: TextStyle(fontSize: 13),
                            ),
                            const Gap(5),
                            const Text(
                              'Chimamanda Ngozi Adichie',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ));
                  }
                },
              ),
            ),
            const Gap(15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommeded',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'See More',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Gap(10),
            SizedBox(
              height: 230,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  if (loading == true) {
                    return ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 163,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 13,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 16,
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 163,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 13,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 16,
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 163,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 13,
                                ),
                                Gap(5),
                                ShimmerWidget.rectangle(
                                  width: 130,
                                  height: 16,
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAssets.book2,
                              width: 130,
                              height: 163,
                            ),
                            const Gap(5),
                            const Text(
                              'Purple Hibiscus',
                              style: TextStyle(fontSize: 13),
                            ),
                            const Gap(5),
                            const Text(
                              'Chimamanda Ngozi Adichie',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ));
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
