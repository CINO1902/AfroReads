import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AfroReadsBackButton extends StatelessWidget {
  const AfroReadsBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 36,
        width: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AfroReadsColors.darkBackground,
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(
              Icons.arrow_back_ios,
              color: AfroReadsColors.background,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
