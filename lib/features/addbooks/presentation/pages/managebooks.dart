import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/navigators/route_name.dart';
import '../../../getuserdetails/presentation/provider/UserDetails.dart';

class managebooks extends StatefulWidget {
  const managebooks({super.key});

  @override
  State<managebooks> createState() => _managebooksState();
}

class _managebooksState extends State<managebooks> {
  @override
  Widget build(BuildContext context) {
    final pubbooks = context.watch<GetbookPro>();
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: value.mybookdetails.length,
                itemBuilder: (context, index) {
                  print(value.mybookdetails.length);
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: 10,
                        top: 3,
                        left: MediaQuery.of(context).size.width * 0.03,
                        right: MediaQuery.of(context).size.width * 0.03),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Align(
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: value.mybookdetails[index].imageUrl,
                              width: 130,
                              height: 163,
                            ),
                          ),
                        ),
                        Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Title: ${value.mybookdetails[index].bookTitle}',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                            Text(
                              'By: ${value.mybookdetails[index].authorName}',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
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
