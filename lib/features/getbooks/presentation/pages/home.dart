import 'package:afroreads/app/view/widget/input_input.dart';
import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:afroreads/features/getuserdetails/presentation/provider/UserDetails.dart';
import 'package:afroreads/features/search/presentation/Provider/SearchPro.dart';
import 'package:afroreads/features/search/presentation/widgets/searchload.dart';
import 'package:afroreads/features/getbooks/presentation/widgets/shimmerwidget.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_scroll/text_scroll.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool loading = true;

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetbookPro>().getbook();
    context.read<userdetails>().getloguser();
    validateuser();
  }

  void validateuser() async {
    final pref = await SharedPreferences.getInstance();
    final logparent = pref.getString('tokenlogforparent');
    final logkid = pref.getString('tokenlogforkid');
    final logpub = pref.getString('tokenlogforpublisher');
    if (logparent != null) {
      context.read<userdetails>().fetchchildID();
      context.read<AuthPro>().fetchparentID();
    } else if (logkid != null) {
      context.read<userdetails>().fetchkidID();
    } else if (logpub != null) {
      context.read<userdetails>().fetchpublisherprofile();
      context.read<GetbookPro>().getmybooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
              child: Consumer<GetbookPro>(builder: (context, value, child) {
                if (value.loading == true) {
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
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.bookdetails.length,
                      itemBuilder: (context, index) {
                        var span = TextSpan(
                          text: value.bookdetails[index].bookTitle,
                        );
                        var tp = TextPainter(
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          text: span,
                        );

                        // trigger it to layout
                        tp.layout(maxWidth: 100);

                        // whether the text overflowed or not
                        var exceeded = tp.didExceedMaxLines;
                        return InkWell(
                          onTap: () {
                            context.read<GetbookPro>().getclickedbook(
                                value.bookdetails[index].id,
                                value.bookdetails[index].bookTitle,
                                value.bookdetails[index].authorName,
                                value.bookdetails[index].review,
                                value.bookdetails[index].noRated,
                                value.bookdetails[index].link,
                                value.bookdetails[index].addedBy,
                                value.bookdetails[index].imageUrl,
                                value.bookdetails[index].preview,
                                value.bookdetails[index].suitableAge,
                                value.bookdetails[index].genre);
                            Navigator.pushNamed(context, RouteName.bookdetails);
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            value.bookdetails[index].imageUrl,
                                        width: 110,
                                        height: 163,
                                      ),
                                    ),
                                    const Gap(5),
                                    exceeded
                                        ? SizedBox(
                                            width: 90,
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextScroll(
                                                  value.bookdetails[index]
                                                      .bookTitle,
                                                  mode: TextScrollMode.bouncing,
                                                  velocity: Velocity(
                                                      pixelsPerSecond:
                                                          Offset(15, 0)),
                                                  delayBefore: Duration(
                                                      milliseconds: 300),
                                                  numberOfReps: 30,
                                                  pauseBetween: Duration(
                                                      milliseconds: 50),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.right,
                                                  selectable: true,
                                                )),
                                          )
                                        : Text(
                                            value.bookdetails[index].bookTitle,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                    const Gap(5),
                                    Text(
                                      value.bookdetails[index].authorName,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(15),
                            ],
                          ),
                        );
                      });
                }
              }),
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
