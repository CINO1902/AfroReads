import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/features/getuserdetails/presentation/provider/UserDetails.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../app/view/widget/busy_button.dart';
import '../../../../core/navigators/route_name.dart';

class managekidprofile extends StatefulWidget {
  const managekidprofile({super.key});

  @override
  State<managekidprofile> createState() => _managekidprofileState();
}

class _managekidprofileState extends State<managekidprofile> {
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
      body: ListView(
        children: [
          Consumer<userdetails>(builder: (context, value, child) {
            return Container(
              height: MediaQuery.of(context).size.height * .8,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: value.decoded.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    height: 250,
                    child: Column(
                      children: [
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset(AppAssets.childavatar)),
                        Gap(10),
                        Text(
                          value.decoded[index].name,
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        Gap(5),
                        Text(
                          'Last read: 2 hours ago',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColorDark),
                        ),
                        Gap(15),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Consumer<userdetails>(
                                builder: (context, value, child) {
                              return BusyButton(
                                  title: "Create Profile",
                                  onTap: () async {
                                    // handlerequest(value);
                                  });
                            })),
                        const Text(
                          'Remove Account',
                          style: TextStyle(fontSize: 15, color: Colors.red),
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
        ],
      ),
    );
  }
}
