import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class kidprogilesetting extends StatefulWidget {
  const kidprogilesetting({super.key});

  @override
  State<kidprogilesetting> createState() => _kidprogilesettingState();
}

class _kidprogilesettingState extends State<kidprogilesetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Manage Profile',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteName.createkidprofile);
          },
          child: SizedBox(
              height: 24,
              width: 200,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(AppAssets.addcircle),
                Gap(5),
                Text(
                  'Add New Profile',
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
