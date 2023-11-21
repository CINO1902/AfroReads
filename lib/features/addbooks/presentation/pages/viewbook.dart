import 'dart:async';
import 'dart:io';

import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:epub_view/epub_view.dart';
import 'package:internet_file/internet_file.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';

class ViewBook extends StatefulWidget {
  const ViewBook({super.key, required this.path});
  final File? path;

  @override
  State<ViewBook> createState() => _ViewBookState();
}

class _ViewBookState extends State<ViewBook> {
  late EpubController _epubController;
  var cfi = '';
  int pagenumber = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.path);
    _epubController = EpubController(
      // Load document
      document: EpubDocument.openFile(widget.path!),
      // Set start point
      epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
    );
  }

  @override
  void dispose() {
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AfroReadsColors.grey,
        title: EpubViewActualChapter(
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
            icon: const Icon(Icons.save_alt),
            color: Colors.white,
            onPressed: () => _epubController.jumpTo(index: 61),
          ),
        ],
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: _epubController,
          // itemBuilder: (context, index, chapter, itemCount) {
          //   print(chapter.startIndex);
          //   return Text('data');
          // },
        ),
      ),
      body: Stack(
        children: [
          EpubView(
            controller: _epubController,
            builders: EpubViewBuilders<DefaultBuilderOptions>(
              options: DefaultBuilderOptions(
                loaderSwitchDuration: const Duration(seconds: 1),
                chapterPadding: const EdgeInsets.all(8),
                paragraphPadding: const EdgeInsets.symmetric(horizontal: 0),
                textStyle: TextStyle(
                    height: 1.25,
                    fontSize: 22,
                    color: Theme.of(context).primaryColorDark),
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
              // chapterDividerBuilder: (_) => const Divider(),
            ),
            onDocumentLoaded: (document) async {
              Future.delayed(Duration(milliseconds: 100), () {
                // <-- Delay here
                _epubController.scrollTo(
                    index: _epubController
                        .tableOfContentsListenable.value[0].startIndex);
              });
              //

              print('loaded');
            },
            onChapterChanged: (value) async {
              setState(() {
                pagenumber = value?.progress.ceil() ?? 0;
              });

              // print(_epubController.generateEpubCfi());
              final pref = await SharedPreferences.getInstance();
              pref.setString('cpi', _epubController.generateEpubCfi()!);
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: AfroReadsColors.grey,
                height: 80,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EpubViewActualChapter(
                          loader: const Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AfroReadsColors.primaryColor,
                          )),
                          controller: _epubController,
                          builder: (chapterValue) => Text(
                                'Chapter ${chapterValue?.chapterNumber.toString()}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                      Text(pagenumber.toString()),
                    ],
                  ),
                ),
              ))
        ],
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
