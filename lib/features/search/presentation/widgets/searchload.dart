import 'dart:async';
import 'dart:io';

import 'package:afroreads/features/getbooks/domain/entities/getbookpromodel.dart';
import 'package:afroreads/features/getbooks/presentation/pages/home.dart';
import 'package:afroreads/features/search/presentation/Provider/SearchPro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigators/route_name.dart';
import '../../../getbooks/presentation/provider/GetbooksPro.dart';

class MySearchDelegate extends SearchDelegate {
  final Searchpro searchpro;
  final ThemeData color;

  MySearchDelegate(this.searchpro, this.color);
  List<String> suggestion = [
    'On my way',
    'In the middle',
    'what little doesn it offer',
    'The girl who lost the source',
    'Dazzling mirage'
  ];
  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(
        Icons.clear,
        color: Colors.black,
      ),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    );
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => Container(
        child: FutureBuilder<List<Pagnitedbook>>(
          future: searchpro.getsearchresult(query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data!.isEmpty) {
                  print(snapshot.error);
                  return buildNoSuggestions();
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              primary: Platform.isAndroid ? true : false,
                              itemCount: snapshot.data!.length,
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
                                          snapshot.data![index].id,
                                          snapshot.data![index].bookTitle,
                                          snapshot.data![index].authorName,
                                          snapshot.data![index].review,
                                          snapshot.data![index].noRated,
                                          snapshot.data![index].link,
                                          snapshot.data![index].addedBy,
                                          snapshot.data![index].imageUrl,
                                          snapshot.data![index].preview,
                                          snapshot.data![index].suitableAge,
                                          snapshot.data![index].genre,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color.fromARGB(
                                                  255, 236, 236, 236)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl: snapshot
                                                    .data![index].imageUrl,
                                                width: 130,
                                                height: 163,
                                              ),
                                            ),
                                            const Gap(5),
                                            Text(
                                              snapshot.data![index].bookTitle,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Gap(5),
                                            Text(
                                              snapshot.data![index].authorName,
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
                      ],
                    ),
                  );
                }
            }
          },
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        child: FutureBuilder<List<dynamic>>(
          future: searchpro.getsearch(query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data!.isEmpty) {
                  return buildNoSuggestions();
                } else {
                  return buildSuggestionsSuccess(snapshot.data!);
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: color.primaryColorDark),
        ),
      );

  Widget buildSuggestionsSuccess(List<dynamic> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;

              showResults(context);
            },
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: color.primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      color: color.primaryColorDark.withOpacity(.4),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
