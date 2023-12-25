import 'dart:async';

import 'package:afroreads/core/constants/app_assets.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:epub_view/epub_view.dart' as Epubview;
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:internet_file/internet_file.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';

class ContinueReading extends StatefulWidget {
  const ContinueReading({super.key});

  @override
  State<ContinueReading> createState() => _ContinueReadingState();
}

class _ContinueReadingState extends State<ContinueReading> {
  late Epubview.EpubController _epubController;

  var cfi = '';
  int pagenumber = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _epubController = Epubview.EpubController(
      // Load document
      document: document(),

      // Set start point

      //  epubCfi: 'epubcfi(/6/0[pgepubid00000]!/4/6[pgepubid00000])',
    );
     context.read<GetbookPro>().getsavedbooks();
    checkexist();
  }

  Future<Epubview.EpubBook> document() async {
    final getbooksdetails = context.read<GetbookPro>();
    Future<Epubview.EpubBook> doucument = Epubview.EpubDocument.openData(
        await InternetFile.get(getbooksdetails.bookurl));
    return doucument;
  }

  @override
  void dispose() {
    _epubController.dispose();

    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
     context.read<GetbookPro>().GetReadBook();
  }

  void checkexist() async {
    final pref = await SharedPreferences.getInstance();
    // pref.remove('progress');
    final saveprogress = pref.getStringList('progress');
    final progress = saveprogress ?? [];

    final getbooksdetails = Provider.of<GetbookPro>(context, listen: false);
    final bookexit = getbooksdetails.clickedbooks[0];
    // print(bookexit);
    // print(progress);
    if (progress.contains(bookexit)) {
      print(true);
    }
  }

  String selectedOption = 'Match Device';
  late StateSetter _setState;
  // List of options for the dropdown
  List<String> options = [
    'Light',
    'Dark',
    'Match Device',
  ];
  String selectedfamily = 'Normal';
  double _currentSliderPrimaryValue = 1.5;
  double fontsizes = 22;
  bool boldword = false;
  bool boldwords = false;
  @override
  Widget build(BuildContext context) {
    final getbooksdetails = Provider.of<GetbookPro>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AfroReadsColors.grey,
        title: Epubview.EpubViewActualChapter(
            controller: _epubController,
            loader: const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AfroReadsColors.primaryColor,
            )),
            builder: (chapterValue) => Text(
                  chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ??
                      '',
                  textAlign: TextAlign.start,
                )),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (context, StateSetter setstate) {
                      _setState = setstate;
                      return Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: selectedOption == 'Light'
                            ? Colors.white
                            : selectedOption == 'Dark'
                                ? Colors.black
                                : Theme.of(context).primaryColorLight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Theme & Settings',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: selectedOption == 'Dark'
                                          ? Colors.white
                                          : selectedOption == 'Light'
                                              ? Colors.black
                                              : Theme.of(context)
                                                  .primaryColorDark,
                                    ),
                                  ),
                                  Icon(
                                    Icons.cancel,
                                    size: 25,
                                  )
                                ],
                              ),
                              Gap(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context)
                                            .primaryColorLight
                                            .withOpacity(.4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            fontsizes--;
                                          },
                                          child: Text(
                                            'A',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                        // Image.asset(name)
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              fontsizes++;
                                            });
                                          },
                                          child: Text(
                                            'A',
                                            style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        boldword = !boldword;
                                      });
                                      _setState(() {});
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Theme.of(context)
                                              .primaryColorLight
                                              .withOpacity(.4)),
                                      child: Center(
                                          child: Text(
                                        'B',
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: boldword
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      )),
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    color: selectedOption == 'Light'
                                        ? Colors.white
                                        : selectedOption == 'Dark'
                                            ? Colors.black
                                            : Theme.of(context)
                                                .primaryColorLight,
                                    onSelected: (value) {
                                      setState(() {
                                        selectedOption = value;
                                      });
                                      _setState(() {});
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return options.map((String option) {
                                        return PopupMenuItem<String>(
                                          value: option,
                                          child: Container(
                                            width: 400,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    selectedOption == option
                                                        ? SizedBox(
                                                            width: 20,
                                                            child: SvgPicture
                                                                .asset(
                                                              AppAssets.tick,
                                                              color: selectedOption ==
                                                                      'Dark'
                                                                  ? Colors.white
                                                                  : selectedOption ==
                                                                          'Light'
                                                                      ? Colors
                                                                          .black
                                                                      : Theme.of(
                                                                              context)
                                                                          .primaryColorDark,
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            width: 20,
                                                          ),
                                                    Gap(20),
                                                    Text(
                                                      option,
                                                      style: TextStyle(
                                                        color: selectedOption ==
                                                                'Dark'
                                                            ? Colors.white
                                                            : selectedOption ==
                                                                    'Light'
                                                                ? Colors.black
                                                                : Theme.of(
                                                                        context)
                                                                    .primaryColorDark,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                option == 'Light'
                                                    ? SizedBox(
                                                        height: 15,
                                                        width: 15,
                                                        child: SvgPicture.asset(
                                                          AppAssets.lighttheme,
                                                          color: selectedOption ==
                                                                  'Dark'
                                                              ? Colors.white
                                                              : selectedOption ==
                                                                      'Light'
                                                                  ? Colors.black
                                                                  : Theme.of(
                                                                          context)
                                                                      .primaryColorDark,
                                                        ),
                                                      )
                                                    : option == 'Dark'
                                                        ? SizedBox(
                                                            height: 15,
                                                            width: 15,
                                                            child: SvgPicture
                                                                .asset(
                                                              AppAssets
                                                                  .darktheme,
                                                              color: selectedOption ==
                                                                      'Dark'
                                                                  ? Colors.white
                                                                  : selectedOption ==
                                                                          'Light'
                                                                      ? Colors
                                                                          .black
                                                                      : Theme.of(
                                                                              context)
                                                                          .primaryColorDark,
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            height: 15,
                                                            width: 15,
                                                            child: SvgPicture
                                                                .asset(
                                                              AppAssets.system,
                                                              color: selectedOption ==
                                                                      'Dark'
                                                                  ? Colors.white
                                                                  : selectedOption ==
                                                                          'Light'
                                                                      ? Colors
                                                                          .black
                                                                      : Theme.of(
                                                                              context)
                                                                          .primaryColorDark,
                                                            ),
                                                          )
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    child: IgnorePointer(
                                      child: Container(
                                          height: 30,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Theme.of(context)
                                                  .primaryColorLight
                                                  .withOpacity(.4)),
                                          child: Center(
                                              child: selectedOption ==
                                                      'Match Device'
                                                  ? SvgPicture.asset(
                                                      AppAssets.system,
                                                      height: 16,
                                                      width: 16,
                                                      color: Theme.of(context)
                                                          .primaryColorDark)
                                                  : selectedOption == 'Dark'
                                                      ? SvgPicture.asset(
                                                          AppAssets.darktheme,
                                                          height: 16,
                                                          width: 16,
                                                          color: Theme.of(context)
                                                              .primaryColorDark)
                                                      : SvgPicture.asset(
                                                          AppAssets.lighttheme,
                                                          height: 16,
                                                          width: 16,
                                                          color: Theme.of(context)
                                                              .primaryColorDark))),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(20),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Line Spacing',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedOption == 'Dark'
                                          ? Colors.white
                                          : selectedOption == 'Light'
                                              ? Colors.black
                                              : Theme.of(context)
                                                  .primaryColorDark,
                                    ),
                                  )),
                              Slider(
                                min: 1,
                                max: 3,
                                activeColor: Theme.of(context).primaryColor,
                                value: _currentSliderPrimaryValue,
                                label: _currentSliderPrimaryValue
                                    .round()
                                    .toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    _currentSliderPrimaryValue = value;
                                  });
                                  _setState(() {});
                                },
                              ),
                              Gap(20),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Font Style',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedOption == 'Dark'
                                          ? Colors.white
                                          : selectedOption == 'Light'
                                              ? Colors.black
                                              : Theme.of(context)
                                                  .primaryColorDark,
                                    ),
                                  )),
                              Gap(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  fontfamily('Normal'),
                                  fontfamily('Ubuntu'),
                                  fontfamily('Roboto')
                                ],
                              ),
                              Gap(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  fontfamily('Bebas_Neue'),
                                  fontfamily('Poppins'),
                                  fontfamily('Noto_Sans')
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Epubview.EpubViewTableOfContents(
          controller: _epubController,
        ),
      ),
      body: Stack(
        children: [
          Epubview.EpubView(
            controller: _epubController,
            builders: Epubview.EpubViewBuilders<Epubview.DefaultBuilderOptions>(
              options: Epubview.DefaultBuilderOptions(
                loaderSwitchDuration: const Duration(seconds: 1),
                chapterPadding: const EdgeInsets.all(8),
                paragraphPadding: const EdgeInsets.symmetric(horizontal: 0),
                textStyle: TextStyle(
                  fontFamily: selectedfamily,
                  backgroundColor: selectedOption == 'Light'
                      ? Colors.white
                      : selectedOption == 'Dark'
                          ? Colors.black
                          : Theme.of(context).primaryColorLight,
                  height: _currentSliderPrimaryValue,
                  fontWeight: boldword ? FontWeight.bold : FontWeight.normal,
                  fontSize: fontsizes,
                  color: selectedOption == 'Light'
                      ? Colors.black
                      : selectedOption == 'Dark'
                          ? Colors.white
                          : Theme.of(context).primaryColorDark,
                ),
              ),
              chapterDividerBuilder: (_) => const Divider(),
              loaderBuilder: (_) => const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AfroReadsColors.primaryColor,
              )),
              errorBuilder: (_, error) {
                return Center(child: Text(error.toString()));
              },
            ),
            onDocumentLoaded: (document) async {
              context.read<GetbookPro>().getbookcpi();
              context.read<GetbookPro>().savebookprogress(
                  getbooksdetails.clickedbooks[0],
                  _epubController.generateEpubCfi());
              // print(e[0].startIndex);
              Future.delayed(Duration(milliseconds: 100), () {
                _epubController
                    .gotoEpubCfi(context.read<GetbookPro>().currentcpi);
              });
              //
            },
            onChapterChanged: (value) async {
              setState(() {
                pagenumber = value?.progress.ceil() ?? 0;

                context.read<GetbookPro>().savebookprogress(
                    getbooksdetails.clickedbooks[0],
                    _epubController.generateEpubCfi());
              });

              // print(_epubController.generateEpubCfi());
              final pref = await SharedPreferences.getInstance();
              pref.setString('cpi', _epubController.generateEpubCfi()!);
            },
          ),
          // Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Container(
          //       color: AfroReadsColors.grey,
          //       height: 80,
          //       width: double.infinity,
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             EpubViewActualChapter(
          //                 loader: const Center(
          //                     child: CircularProgressIndicator(
          //                   strokeWidth: 2,
          //                   color: AfroReadsColors.primaryColor,
          //                 )),
          //                 controller: _epubController,
          //                 builder: (chapterValue) => Text(
          //                       'Chapter ${chapterValue?.chapterNumber.toString()}',
          //                       textAlign: TextAlign.start,
          //                       style: TextStyle(
          //                           fontSize: 18, fontWeight: FontWeight.bold),
          //                     )),
          //             Text(pagenumber.toString()),
          //           ],
          //         ),
          //       ),
          //     ))
        ],
      ),
    );
  }

  InkWell fontfamily(familyname) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedfamily = familyname;
        });
        _setState(() {});
      },
      child: Container(
        height: 100,
        width: 110,
        decoration: BoxDecoration(
            border: selectedfamily == familyname
                ? Border.all(
                    color: selectedOption == 'Dark'
                        ? Colors.white
                        : selectedOption == 'Light'
                            ? Colors.black.withOpacity(.5)
                            : Theme.of(context)
                                .primaryColorDark
                                .withOpacity(.5),
                    width: 3)
                : Border(),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Aa',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                familyname,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: familyname,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCurrentEpubCfi(context) {
    cfi = _epubController.generateEpubCfi()!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(cfi),
        action: SnackBarAction(
          label: 'GO',
          onPressed: () {
            _epubController.gotoEpubCfi(cfi);
          },
        ),
      ),
    );
  }

  // String _taketovalidcfi() {
  //   String newcfi = '';
  //   String? cfi = _epubController.generateEpubCfi();
  //   var parts = cfi!.split('(');
  //   var prefix = parts[1].trim();
  //   var main = prefix.split('/')[0];
  //   _epubController.gotoEpubCfi(cfi.);
  //   print(main);
  //   if(main == 'null'){
  //     newcfi =
  //   }
  //   return newcfi;
  // }
}
