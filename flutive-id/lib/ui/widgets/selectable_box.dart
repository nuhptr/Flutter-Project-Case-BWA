import 'package:flutter/material.dart';

import '/theme.dart';

class SelectableBox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double width;
  final double height;
  final String text;
  final Function onTap;
  final TextStyle textStyle;

  SelectableBox(this.text,
      {this.isSelected = false,
      this.isEnabled = true,
      this.width = 144,
      this.height = 60,
      this.onTap,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (!isEnabled)
                ? grayColor
                : isSelected
                    ? yellowColor
                    : Colors.transparent,
            border: Border.all(
                color: (!isEnabled)
                    ? grayColor
                    : isSelected
                        ? Colors.transparent
                        : grayColor)),
        child: Center(
            child: Text(
          text ?? "none",
          style: textStyle ??
              blackRalewayRegular.copyWith(fontSize: 16, color: Colors.black),
        )),
      ),
    );
  }
}
