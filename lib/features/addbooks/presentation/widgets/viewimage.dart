import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../app/styles/fonts.dart';
import '../../../../provider/theme_provider.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({super.key, required this.image});

  final PlatformFile? image;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeProvider.themeData.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Gap(30),
            Align(
              alignment: Alignment.center,
              child: TextBold(
                "View Image",
                fontSize: 18,
                color: themeProvider.themeData.primaryColorDark,
              ),
            ),
            const Gap(20),
            Image.memory(
              Uint8List.fromList(image!.bytes!),
              width: 200,
              height: 400,
            )
          ],
        ),
      ),
    );
  }
}
