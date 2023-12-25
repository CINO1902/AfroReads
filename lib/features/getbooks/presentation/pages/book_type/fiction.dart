import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/navigators/route_name.dart';
import '../../provider/GetbooksPro.dart';
import '../../widgets/shimmerwidget.dart';

class Fiction extends StatefulWidget {
  const Fiction({super.key});

  @override
  State<Fiction> createState() => _FictionState();
}

class _FictionState extends State<Fiction> {
  late ScrollController controller;
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetbookPro>().getlibrarybooks();
    controller = ScrollController()
      ..addListener(() {
        if (controller.position.maxScrollExtent == controller.position.pixels) {
          context.read<GetbookPro>().getlibrarybooksmore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Consumer<GetbookPro>(builder: (context, value, child) {
          if (value.loadinglibrary == true) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  primary: Platform.isAndroid ? true : false,
                  itemCount: 5,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return const SizedBox(
                      width: 130,
                      child: ShimmerWidget.rectangle(
                        width: 130,
                        height: 163,
                      ),
                    );
                  }),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        controller: controller,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        //   primary: Platform.isAndroid ? true : false,
                        itemCount: value.bookdetailslibrary.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 4 / 5,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          var span = TextSpan(
                            text: value.bookdetailslibrary[index].bookTitle,
                          );
                          var tp = TextPainter(
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            text: span,
                          );

                          // trigger it to layout
                          tp.layout(maxWidth: 90);

                          // whether the text overflowed or not
                          var exceeded = tp.didExceedMaxLines;
                          return InkWell(
                            onTap: () {
                              context.read<GetbookPro>().getclickedbook(
                                    value.bookdetailslibrary[index]
                                        .pagnitedbookId,
                                    value.bookdetailslibrary[index].bookTitle,
                                    value.bookdetailslibrary[index].authorName,
                                    value.bookdetailslibrary[index].review,
                                    value.bookdetailslibrary[index].noRated,
                                    value.bookdetailslibrary[index].link,
                                    value.bookdetailslibrary[index].addedBy,
                                    value.bookdetailslibrary[index].imageUrl,
                                    value.bookdetailslibrary[index].preview,
                                    value.bookdetailslibrary[index].suitableAge,
                                    value.bookdetailslibrary[index].genre,
                                  );
                              Navigator.pushNamed(
                                  context, RouteName.bookdetails);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(255, 236, 236, 236)),
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: value
                                              .bookdetailslibrary[index]
                                              .imageUrl,
                                          width: 130,
                                          height: 163,
                                        ),
                                      ),
                                      const Gap(5),
                                      exceeded
                                          ? SizedBox(
                                              width: 80,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextScroll(
                                                    value
                                                        .bookdetailslibrary[
                                                            index]
                                                        .bookTitle,
                                                    mode:
                                                        TextScrollMode.bouncing,
                                                    velocity: Velocity(
                                                        pixelsPerSecond:
                                                            Offset(10, 0)),
                                                    delayBefore: Duration(
                                                        milliseconds: 200),
                                                    numberOfReps: 30,
                                                    pauseBetween: Duration(
                                                        milliseconds: 50),
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.right,
                                                    selectable: true,
                                                  )),
                                            )
                                          : FittedBox(
                                              child: Text(
                                                value.bookdetailslibrary[index]
                                                    .bookTitle,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                      const Gap(5),
                                      Text(
                                        value.bookdetailslibrary[index]
                                            .authorName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  value.isloadmore == true
                      ? Container(
                          height: 70,
                          margin: const EdgeInsets.only(top: 0, bottom: 60),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AfroReadsColors.primaryColor,
                            ),
                          ),
                        )
                      : Container(
                          // height: 70,
                          ),
                  value.hasnextpage == false
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: Container(
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              'You have fetched all content',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            )),
                          ),
                        )
                      : Container(
                          //height: 70,
                          )
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
