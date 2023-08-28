import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/features/getbooks/presentation/pages/home.dart';
import 'package:afroreads/features/getbooks/presentation/pages/libary.dart';
import 'package:afroreads/features/getuserdetails/presentation/pages/account.dart';
import 'package:afroreads/features/notification/presentation/pages/notification.dart';
import 'package:afroreads/features/search/presentation/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Homelanding extends StatefulWidget {
  const Homelanding({Key? key}) : super(key: key);

  @override
  State<Homelanding> createState() => _HomelandingState();
}

class _HomelandingState extends State<Homelanding> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  static const screens = [
    Home(),
    Library(),
    Search(),
    NotificationPage(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? Scaffold(
            body: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
                iconSize: 20,
                //  backgroundColor: Colors.grey[3],
                currentIndex: currentIndex,
                onTap: (index) => setState(() {
                      currentIndex = index;
                    }),
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Theme.of(context).colorScheme.onBackground,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.homeicon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.homeicon,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.bookicon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.bookicon,
                    ),
                    label: 'Library',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.searchicon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.searchicon,
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.notificationicon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.notificationicon,
                    ),
                    label: 'Notification',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.accounticon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.accounticon,
                    ),
                    label: 'Account',
                  )
                ]),
            tabBuilder: (BuildContext context, int index) {
              return IndexedStack(
                index: currentIndex,
                children: screens,
              );
            },
          ))
        : Scaffold(
            body: IndexedStack(
              index: currentIndex,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: true,
                //backgroundColor: Theme.of(context).primaryColor,
                currentIndex: currentIndex,
                onTap: (index) => setState(() {
                      currentIndex = index;
                    }),
                selectedItemColor: AfroReadsColors.primaryColor,
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
                unselectedItemColor: AfroReadsColors.grey,
                items: [
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.homeicon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.homeicon,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.bookicon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.bookicon,
                    ),
                    label: 'Library',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.searchicon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.searchicon,
                    ),
                    label: 'Search',
                    //  backgroundColor: Color.fromARGB(200, 39, 39, 39),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.notificationicon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.notificationicon,
                    ),
                    label: 'Notification',
                    //  backgroundColor: Color.fromARGB(200, 39, 39, 39),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.accounticon,
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.accounticon,
                    ),
                    label: 'Account',
                    //  backgroundColor: Color.fromARGB(200, 39, 39, 39),
                  )
                ]),
          );
  }
}
