import 'package:afroreads/app/view/widget/back_button.dart';
import 'package:afroreads/app/view/widget/busy_button.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    context.read<GetbookPro>().disposeclickedbook();
  }

  bool clicked = false;
  int maxlinebox = 8;

  @override
  Widget build(BuildContext context) {
    final getbooksdetails = Provider.of<GetbookPro>(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: const AfroReadsBackButton(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: getbooksdetails.clickedbooks[7],
                        width: 170,
                        height: 300,
                      ),
                      Text(
                        getbooksdetails.clickedbooks[1],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      Text(
                        'By ${getbooksdetails.clickedbooks[2]}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Gap(10),
                      Text(
                        'Genre: African Fiction',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Review:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Gap(10),
                          RatingBar.builder(
                            initialRating:
                                double.parse(getbooksdetails.clickedbooks[3]),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Gap(10),
                          Text(
                            getbooksdetails.clickedbooks[3],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Gap(10),
                          Text(
                            '${getbooksdetails.clickedbooks[4]} Ratings',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Gap(15),
                      SizedBox(
                          height: 30,
                          width: 70,
                          child: BusyButton(
                              title: 'Read Now',
                              fontsize: 12,
                              onTap: () {
                                context.read<GetbookPro>().clickbookurl(
                                    getbooksdetails.clickedbooks[5]);
                                Navigator.pushNamed(context, RouteName.pdfpage);
                              })),
                      Gap(15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('About',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: getbooksdetails
                                                .clickedbooks[8].length <
                                            500
                                        ? Text(getbooksdetails.clickedbooks[8])
                                        : Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    getbooksdetails
                                                        .clickedbooks[8],
                                                    maxLines: maxlinebox,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Gap(15),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (clicked == false) {
                                                          maxlinebox = 40;
                                                        } else {
                                                          maxlinebox = 8;
                                                        }
                                                        clicked = !clicked;
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          clicked
                                                              ? 'Read Less'
                                                              : 'Read More',
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AfroReadsColors
                                                                  .primaryColor),
                                                        ),
                                                        Icon(
                                                          clicked
                                                              ? Icons
                                                                  .navigate_before
                                                              : Icons
                                                                  .navigate_next,
                                                          color: AfroReadsColors
                                                              .primaryColor,
                                                          size: 30,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
