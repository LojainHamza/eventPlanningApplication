import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppStyles {
  /// =============== primary ===============
  static TextStyle bold20Primary = GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: MyAppColors.primaryLight);
  static TextStyle bold16Primary = GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: MyAppColors.primaryLight);
  static TextStyle bold14Primary = GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: MyAppColors.primaryLight);
  static TextStyle medium24Primary = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: MyAppColors.primaryLight);
  static TextStyle medium20Primary = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: MyAppColors.primaryLight);
  static TextStyle medium16Primary = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: MyAppColors.primaryLight);
  static TextStyle regular22Primary = GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 22,
      color: MyAppColors.primaryLight);

  /// =============== black ===============
  static TextStyle bold24Black = GoogleFonts.inter(
      fontWeight: FontWeight.bold, fontSize: 24, color: MyAppColors.blackColor);
  static TextStyle bold20Black = GoogleFonts.inter(
      fontWeight: FontWeight.bold, fontSize: 20, color: MyAppColors.blackColor);
  static TextStyle medium18Black = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 18, color: MyAppColors.blackColor);
  static TextStyle medium16Black = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 16, color: MyAppColors.blackColor);
  static TextStyle medium14Black = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 14, color: MyAppColors.blackColor);

  /// =============== white ===============

  static TextStyle bold24White = GoogleFonts.inter(
      fontWeight: FontWeight.bold, fontSize: 24, color: MyAppColors.whiteColor);
  static TextStyle bold12White = GoogleFonts.inter(
      fontWeight: FontWeight.bold, fontSize: 12, color: MyAppColors.whiteColor);
  static TextStyle medium20White = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 20, color: MyAppColors.whiteColor);
  static TextStyle medium16White = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 16, color: MyAppColors.whiteColor);
  static TextStyle medium14White = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 14, color: MyAppColors.whiteColor);
  static TextStyle regular14White = GoogleFonts.inter(
      fontWeight: FontWeight.w400, fontSize: 14, color: MyAppColors.whiteColor);

  /// =============== gray ===============
  static TextStyle medium16Gray = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 16, color: MyAppColors.grayColor);
}
