import 'package:afroreads/app/styles/fonts.dart';
import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BusyButton extends StatefulWidget {
  const BusyButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.active = true,
    this.titleColor = AfroReadsColors.white,
    this.buttonColor = AfroReadsColors.primaryColor,
    this.borderColor = AfroReadsColors.primaryColor,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final bool active;
  final Color buttonColor;
  final Color titleColor;
  final Color borderColor;
  @override
  State<BusyButton> createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.active ? widget.onTap : null,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: widget.borderColor),
          color: widget.active
              ? widget.buttonColor
              : widget.buttonColor.withOpacity(0.4),
        ),
        child: Center(
          child: TextBold(
            widget.title,
            color: widget.titleColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
