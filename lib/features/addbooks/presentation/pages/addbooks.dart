import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/navigators/route_name.dart';

class Addbooks extends StatefulWidget {
  const Addbooks({super.key});

  @override
  State<Addbooks> createState() => _AddbooksState();
}

class _AddbooksState extends State<Addbooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Add Books',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: InkWell(
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
      ),
    );
  }
}
