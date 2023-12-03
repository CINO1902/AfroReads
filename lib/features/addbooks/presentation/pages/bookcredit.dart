import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/features/addbooks/presentation/provider/uploadimageprovider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/navigators/route_name.dart';
import '../../../getbooks/presentation/provider/GetbooksPro.dart';

class BookCredit extends StatefulWidget {
  const BookCredit({super.key});

  @override
  State<BookCredit> createState() => _BookCreditState();
}

class _BookCreditState extends State<BookCredit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Credit',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl:
                      context.watch<uploadimageprovider>().CreditClickedBook[0],
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  context.watch<uploadimageprovider>().CreditClickedBook[1],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Theme.of(context).primaryColorDark),
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context
                          .watch<uploadimageprovider>()
                          .CreditClickedBook[4]
                          .toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(.6)),
                    ),
                    Text('-'),
                    Text(
                      context
                          .watch<uploadimageprovider>()
                          .CreditClickedBook[2]
                          .toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(.6)),
                    ),
                  ],
                ),
                Gap(20),
                SizedBox(
                  width: 200,
                  child: BusyButton(
                      title: 'View Book',
                      onTap: () {
                        context.read<GetbookPro>().clickbookurl(
                            Provider.of<uploadimageprovider>(context,
                                    listen: false)
                                .CreditClickedBook[5]);
                        Navigator.pushNamed(context, RouteName.pdfpage);
                      }),
                )
              ],
            ),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Last 7 days',
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(.6)),
                  ),
                ),
                Gap(15),
                creditdetails(
                  title: 'Viewed By:',
                  metrics: '1,897',
                ),
                Gap(15),
                creditdetails(
                  title: 'Read By:',
                  metrics: '947',
                ),
                Gap(15),
                creditdetails(
                  title: 'Searches Appeared:',
                  metrics: '447',
                ),
                Gap(15),
                creditdetails(
                  title: 'Completely Read By:',
                  metrics: '16',
                ),
              ],
            ),
          ),
          Gap(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Last 30 days',
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(.6)),
                  ),
                ),
                Gap(15),
                creditdetails(
                  title: 'Viewed By:',
                  metrics: '1,897',
                ),
                Gap(15),
                creditdetails(
                  title: 'Read By:',
                  metrics: '947',
                ),
                Gap(15),
                creditdetails(
                  title: 'Searches Appeared:',
                  metrics: '447',
                ),
                Gap(15),
                creditdetails(
                  title: 'Completely Read By:',
                  metrics: '205',
                ),
              ],
            ),
          ),
          Gap(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'All Time',
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(.6)),
                  ),
                ),
                Gap(15),
                creditdetails(
                  title: 'Viewed By:',
                  metrics: '1,897',
                ),
                Gap(15),
                creditdetails(
                  title: 'Read By:',
                  metrics: '947',
                ),
                Gap(15),
                creditdetails(
                  title: 'Searches Appeared:',
                  metrics: '447',
                ),
                Gap(15),
                creditdetails(
                  title: 'Completely Read By:',
                  metrics: '205',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class creditdetails extends StatelessWidget {
  creditdetails({
    super.key,
    required this.title,
    required this.metrics,
  });

  String title;
  String metrics;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Theme.of(context).primaryColorLight.withOpacity(.7)),
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark.withOpacity(.6)),
            ),
            Text(
              metrics,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColorDark.withOpacity(.6)),
            ),
          ],
        ),
      ),
    );
  }
}
