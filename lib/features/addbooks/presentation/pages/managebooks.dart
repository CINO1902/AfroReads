import 'package:afroreads/features/addbooks/presentation/provider/uploadimageprovider.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigators/route_name.dart';
import '../../../getuserdetails/presentation/provider/UserDetails.dart';

class managebooks extends StatefulWidget {
  const managebooks({super.key});

  @override
  State<managebooks> createState() => _managebooksState();
}

class _managebooksState extends State<managebooks> {
  late ScrollController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController()
      ..addListener(() {
        if (controller.position.maxScrollExtent == controller.position.pixels) {
          context.read<GetbookPro>().getmybooksmore();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Manage Books',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Consumer<GetbookPro>(builder: (context, value, child) {
            return Container(
              height: MediaQuery.of(context).size.height * .8,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .8,
                    child: ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      itemCount: value.mybookdetails.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: 10,
                              top: 3,
                              left: MediaQuery.of(context).size.width * 0.03,
                              right: MediaQuery.of(context).size.width * 0.03),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.02),
                          height: 80,
                          decoration: BoxDecoration(
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: value.mybookdetails[index].imageUrl,
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    );
                                  },
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Gap(10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Title: ${value.mybookdetails[index].bookTitle}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                    ),
                                    Text(
                                      'By: ${value.mybookdetails[index].authorName}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    context
                                        .read<uploadimageprovider>()
                                        .creditclickbook(
                                            value.mybookdetails[index].imageUrl,
                                            value
                                                .mybookdetails[index].bookTitle,
                                            value.mybookdetails[index].genre,
                                            value.mybookdetails[index]
                                                .pagnitedbookId,
                                                value.mybookdetails[index].authorName,
                                                  value.mybookdetails[index].link,
                                                );
                                    Navigator.pushNamed(
                                        context, RouteName.bookcredit);
                                  },
                                  child: Icon(Icons.more))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  value.mybookisloadmore == true
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 70,
                            margin: const EdgeInsets.only(top: 0, bottom: 60),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AfroReadsColors.primaryColor,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          // height: 70,
                          ),
                  value.mybookhasnextpage == false
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
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
          }),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteName.createbook);
            },
            child: SizedBox(
                height: 24,
                width: 200,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(AppAssets.addcircle),
                  Gap(5),
                  Text(
                    'Add New Book',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold),
                  )
                ])),
          ),
        ],
      ),
    );
  }
}
