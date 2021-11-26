import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color? splashColorBg = Color(0xff4141A4);
Color? titleColor = Color(0xffB3B5C4);
Color? headerColor = Color(0xff272C2F);
Color? appliedColor = Color(0xffECEDF1);
Color? textAppliedColor = Color(0xffA2A6B4);

Color? formColor = Color(0xffF1F0F5);

double defaultMargin = 24.0;

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

TextStyle poppinsRegular = GoogleFonts.poppins(fontWeight: regular);
TextStyle poppinsMedium = GoogleFonts.poppins(fontWeight: medium);
TextStyle poppinsSemiBold = GoogleFonts.poppins(fontWeight: semiBold);
TextStyle poppinsBold = GoogleFonts.poppins(fontWeight: bold);
TextStyle poppinsLight = GoogleFonts.poppins(fontWeight: light);

InputDecoration formDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 20),
  filled: true,
  fillColor: formColor,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: BorderSide.none,
  ),
);
