import 'dart:async';

import 'package:flutter/material.dart';

import 'package:epub_view/epub_view.dart';
import 'package:internet_file/internet_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  late EpubController _epubController;
  var cfi = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _epubController = EpubController(
      // Load document
      document: document(),

      // Set start point

      epubCfi: 'epubcfi(/6/0[main1]!/4/2/476)',
    );
  }

  Future<EpubBook> document() async {
    Future<EpubBook> doucument = EpubDocument.openData(await InternetFile.get(
        'https://fb2bookfree.com/uploads/files/2016-01/1452778023_ulysses.epub'));

    return doucument;
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
        title: EpubViewActualChapter(
            controller: _epubController,
            builder: (chapterValue) => Text(
                  chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ??
                      '',
                  textAlign: TextAlign.start,
                )),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save_alt),
            color: Colors.white,
            onPressed: () => _showCurrentEpubCfi(context),
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
      body: EpubView(
        controller: _epubController,
        builders: EpubViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(
            loaderSwitchDuration: Duration(seconds: 2),
            chapterPadding: EdgeInsets.all(8),
            paragraphPadding: EdgeInsets.symmetric(horizontal: 0),
            textStyle:
                TextStyle(height: 1.25, fontSize: 25, color: Colors.black),
          ),
          chapterDividerBuilder: (_) => const Divider(),
          loaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, error) => Center(child: Text(error.toString())),
          // chapterDividerBuilder: (_) => const Divider(),
        ),
        onDocumentLoaded: (document) async {
          for (var epubViewChapter
              in _epubController.tableOfContentsListenable.value) {
            // print(epubViewChapter.startIndex);
            // _epubController.jumpTo(index: epubViewChapter.startIndex);
            // print(
            //     "Chapter: ${epubViewChapter.startIndex}, Name: ${epubViewChapter.title} CFI: ${_epubController.generateEpubCfi()}");
          }
          print('loaded');
          // print(_epubController.epubCfi);
          // final pref = await SharedPreferences.getInstance();
          // final getcpi = pref.getString('cpi');
          // _epubController.gotoEpubCfi(getcpi!);
          // print(getcpi);
        },
        onChapterChanged: (value) async {
          // print(value!.chapter);
          _epubController.generateEpubCfi();
          // print(_epubController.generateEpubCfi());
          final pref = await SharedPreferences.getInstance();
          pref.setString('cpi', _epubController.generateEpubCfi()!);
        },
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
