import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:afroreads/features/getbooks/presentation/widgets/shimmerwidget.dart';
import 'package:afroreads/features/getuserdetails/presentation/provider/UserDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu_custom/focused_menu.dart';
import 'package:focused_menu_custom/modals.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_scroll/text_scroll.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

bool loading = true;

class _AllState extends State<All> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetbookPro>().getbook();
    context.read<userdetails>().getloguser();
    validateuser();
  }

  bool existbooks = false;
  void validateuser() async {
    context.read<GetbookPro>().getsavedbooks();
    final pref = await SharedPreferences.getInstance();
    final logparent = pref.getString('tokenlogforparent');
    final logkid = pref.getString('tokenlogforkid');
    final logpub = pref.getString('tokenlogforpublisher');
    final saveprogress = pref.getStringList('progress');
    if (logparent != null) {
      context.read<userdetails>().fetchchildID();
      context.read<AuthPro>().fetchparentID();
    } else if (logkid != null) {
      context.read<userdetails>().fetchkidID();
    } else if (logpub != null) {
      context.read<userdetails>().fetchpublisherprofile();
      context.read<GetbookPro>().getmybooks();
    }
    if (saveprogress != null) {
      context.read<GetbookPro>().GetReadBook();
      setState(() {
        existbooks = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookde = Provider.of<GetbookPro>(context);
    return Scaffold(
        body: ListView(children: [
      context.watch<GetbookPro>().existbooks
          ? SizedBox(
              height: 120,
              child: bookde.loadingReadbook
                  ? Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ShimmerWidget.rectangle(width: 200, height: 100),
                          Gap(20),
                          ShimmerWidget.rectangle(width: 200, height: 100),
                        ],
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: context.watch<GetbookPro>().bookd.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          width: 230,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).colorScheme.onSecondary),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  context.read<GetbookPro>().getclickedbook(
                                        bookde.bookd[index].readBookId,
                                        bookde.bookd[index].bookTitle,
                                        bookde.bookd[index].authorName,
                                        bookde.bookd[index].review,
                                        bookde.bookd[index].noRated,
                                        bookde.bookd[index].link,
                                        bookde.bookd[index].addedBy,
                                        bookde.bookd[index].imageUrl,
                                        bookde.bookd[index].preview,
                                        bookde.bookd[index].suitableAge,
                                        bookde.bookd[index].genre,
                                      );
                                  context
                                      .read<GetbookPro>()
                                      .clickbookurl(bookde.clickedbooks[5]);
                                  Navigator.pushNamed(
                                      context, RouteName.continueReading);
                                },
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: bookde.bookd[index].imageUrl,
                                      width: 50,
                                      //   height: 13,
                                    ),
                                    Gap(10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            height: 50,
                                            width: 120,
                                            child: Text(
                                              bookde.bookd[index].bookTitle,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary),
                                            )),
                                        SizedBox(
                                            height: 30,
                                            width: 120,
                                            child: Text(
                                              bookde.bookd[index].authorName,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              FocusedMenuHolder(
                                openWithTap: true,
                                animateMenuItems: true,
                                bottomOffsetHeight: 80.0, // Of
                                menuItemExtent: 45,

                                menuWidth:
                                    MediaQuery.of(context).size.width * 0.6,
                                blurSize: 5.0,
                                menuOffset: 10.0,
                                menuBoxDecoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                duration: Duration(milliseconds: 100),

                                // duration: Duration(milliseconds: 500),
                                onPressed: () {},
                                menuItems: [
                                  FocusedMenuItem(
                                      title: const Text(
                                        'Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailingIcon: Icon(Icons.info)),
                                  FocusedMenuItem(
                                      title: const Text('Share Book',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      trailingIcon: Icon(Icons.share)),
                                  FocusedMenuItem(
                                      title: const Text('Add To save books',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      trailingIcon: Icon(Icons.save_alt)),
                                  FocusedMenuItem(
                                      onPressed: () {
                                        context
                                            .read<GetbookPro>()
                                            .getclickedbook(
                                              bookde.bookd[index].readBookId,
                                              bookde.bookd[index].bookTitle,
                                              bookde.bookd[index].authorName,
                                              bookde.bookd[index].review,
                                              bookde.bookd[index].noRated,
                                              bookde.bookd[index].link,
                                              bookde.bookd[index].addedBy,
                                              bookde.bookd[index].imageUrl,
                                              bookde.bookd[index].preview,
                                              bookde.bookd[index].suitableAge,
                                              bookde.bookd[index].genre,
                                            );
                                        context.read<GetbookPro>().deletebook(
                                            bookde.bookd[index].readBookId);
                                      },
                                      title: const Text(
                                        'Remove From Continue',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      ),
                                      trailingIcon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                                child: SvgPicture.asset(
                                  AppAssets.more,
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            )
          : SizedBox(),
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
                            value.bookdetails[index].pagnitedbookId,
                            value.bookdetails[index].bookTitle,
                            value.bookdetails[index].authorName,
                            value.bookdetails[index].review,
                            value.bookdetails[index].noRated,
                            value.bookdetails[index].link,
                            value.bookdetails[index].addedBy,
                            value.bookdetails[index].imageUrl,
                            value.bookdetails[index].preview,
                            value.bookdetails[index].suitableAge,
                            value.bookdetails[index].genre,
                          );
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
                                  imageUrl: value.bookdetails[index].imageUrl,
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
                                            value.bookdetails[index].bookTitle,
                                            mode: TextScrollMode.bouncing,
                                            velocity: Velocity(
                                                pixelsPerSecond: Offset(15, 0)),
                                            delayBefore:
                                                Duration(milliseconds: 300),
                                            numberOfReps: 30,
                                            pauseBetween:
                                                Duration(milliseconds: 50),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
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
      ),
    ]));
  }
}
