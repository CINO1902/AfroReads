import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:epub_view/epub_view.dart';
import 'package:internet_file/internet_file.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  late EpubController _epubController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _epubController = EpubController(
      // Load document
      document: document(),

      // Set start point
      epubCfi: 'epubcfi(/6/10[main1]!/4/2/476)',
    );
  }

  Future<EpubBook> document() async {
    Future<EpubBook> doucument = EpubDocument.openData(await InternetFile.get(
        'https://res.cloudinary.com/dlsavisdq/raw/upload/v1694357490/1587558393_the-odyssey-by-homer_uzk17u.epub'));

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
            chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? '',
            textAlign: TextAlign.start,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save_alt),
            color: Colors.white,
            onPressed: () => _showCurrentEpubCfi(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(controller: _epubController),
      ),
      body: EpubView(
        builders: EpubViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(
            loaderSwitchDuration: Duration(seconds: 2),
            chapterPadding: EdgeInsets.all(8),
            paragraphPadding: EdgeInsets.symmetric(horizontal: 0),
            textStyle:
                TextStyle(height: 1.25, fontSize: 25, color: Colors.blue),
          ),
          chapterDividerBuilder: (_) => const Divider(),
          loaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, error) => Center(child: Text(error.toString())),

          // chapterDividerBuilder: (_) => const Divider(),
        ),
        onDocumentLoaded: (document) {
          print('loaded');
          print(_epubController.epubCfi);
          // _epubController.gotoEpubCfi(_epubController.epubCfi ?? '');
        },
        onChapterChanged: (value) {
          // print(value!.chapter);
          _epubController.generateEpubCfi();

          print(_epubController.generateEpubCfi());
        },
        controller: _epubController,
      ),
    );
  }

  void _showCurrentEpubCfi(context) {
    final cfi = _epubController.generateEpubCfi();

    if (cfi != null) {
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
  }
}
