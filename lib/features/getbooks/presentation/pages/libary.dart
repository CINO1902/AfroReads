import 'dart:io';

import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:afroreads/features/search/presentation/widgets/searchload.dart';
import 'package:afroreads/features/getbooks/presentation/widgets/shimmerwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../search/presentation/Provider/SearchPro.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        centerTitle: false,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            final searchpro = context.read<Searchpro>();
            final color = Theme.of(context);
            showSearch(
                context: context, delegate: MySearchDelegate(searchpro, color));
          },
          child: Icon(
            Icons.search,
            size: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              child: Image.asset(
                AppAssets.filter,
                height: 20,
                width: 20,
              ),
            ),
          )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Library',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 27,
              fontWeight: FontWeight.bold),
        ),
      ),
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
                          return InkWell(
                            onTap: () {
                              context.read<GetbookPro>().getclickedbook(
                                    value.bookdetailslibrary[index].id,
                                    value.bookdetailslibrary[index].bookTitle,
                                    value.bookdetailslibrary[index].authorName,
                                    value.bookdetailslibrary[index].review,
                                    value.bookdetailslibrary[index].noRated,
                                    value.bookdetailslibrary[index].link,
                                    value.bookdetailslibrary[index].addedBy,
                                    value.bookdetailslibrary[index].imageUrl,
                                    value.bookdetailslibrary[index].preview,
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
                                      Text(
                                        value.bookdetailslibrary[index]
                                            .bookTitle,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Gap(5),
                                      Text(
                                        value.bookdetailslibrary[index]
                                            .authorName,
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
