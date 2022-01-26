import 'package:flutter/material.dart';

import 'package:airplane/shared/theme.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.textEditingController,
    this.inputType = TextInputType.none,
    this.suffixIcon,
    this.obscureText = false,
    this.endForm = false,
  }) : super(key: key);

  final String? title;
  final String? hintText;
  final TextInputType? inputType;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? endForm;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: endForm == true
          ? EdgeInsets.only(bottom: 30)
          : EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
          ),
          SizedBox(height: 6),
          TextFormField(
            cursorColor: kBlackColor,
            autofocus: false,
            keyboardType: inputType,
            controller: textEditingController,
            obscureText: obscureText!,
            decoration: InputDecoration(
              hintText: hintText ?? '',
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(
                  color: kInactiveColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
