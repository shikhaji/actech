// FONT FAMILY
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'color_utils.dart';


//FONT WEIGHT

class FontWeightClass {
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiB = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraB = FontWeight.w800;
  static const black = FontWeight.w900;
}

class FontTextStyle {
  // Title

  static TextStyle poppinsS35W7BlackColor = GoogleFonts.poppins(
      fontSize: 35.sp,
      color: ColorUtils.blackColor,
      fontWeight: FontWeightClass.bold
  );

  static TextStyle poppinsS20W7BlackColor = GoogleFonts.poppins(
      fontSize: 20.sp,
      color: ColorUtils.blackColor,
      fontWeight: FontWeightClass.bold
  );

  static TextStyle poppinsS16W7WhiteColor = GoogleFonts.poppins(
      fontSize: 16.sp,
      color: ColorUtils.whiteColor,
      fontWeight: FontWeightClass.bold
  );

  static TextStyle poppinsS14HintColor = GoogleFonts.poppins(
      fontSize: 14.sp,
      color: ColorUtils.labelColor,
      fontWeight: FontWeightClass.regular
  );
  static TextStyle poppinsS12HintColor = GoogleFonts.poppins(
      fontSize: 12.sp,
      color: ColorUtils.labelColor,
      fontWeight: FontWeightClass.regular
  );

  static TextStyle poppinsS10HintColor = GoogleFonts.poppins(
      fontSize: 10.sp,
      color: ColorUtils.labelColor,
      fontWeight: FontWeightClass.regular
  );

  static TextStyle poppinsS12W4BlackColor =
  poppinsS12HintColor.copyWith(color:ColorUtils.blackColor);

  static TextStyle poppinsS14W4BlackColor =
  poppinsS14HintColor.copyWith(color:ColorUtils.blackColor);

  static TextStyle poppinsS14W4WhiteColor =
  poppinsS14HintColor.copyWith(color:ColorUtils.whiteColor);

  static TextStyle poppinsS14W7BlackColor =
  poppinsS14HintColor.copyWith(color:ColorUtils.blackColor,fontWeight: FontWeightClass.bold);


  static TextStyle montserratS12W7BlackColor = GoogleFonts.montserrat(
      fontSize: 12.sp,
      color: ColorUtils.blackColor,
      fontWeight: FontWeightClass.bold
  );

  static TextStyle montserratS12W4WhiteColor =
  montserratS12W7BlackColor.copyWith(color:ColorUtils.whiteColor,fontWeight: FontWeightClass.regular);

  static TextStyle montserratS10W4WhiteColor =
  montserratS12W7BlackColor.copyWith(color:ColorUtils.whiteColor,fontWeight: FontWeightClass.regular,fontSize: 11.sp);


  static TextStyle montserratS10W4GreyColor =
  montserratS12W7BlackColor.copyWith(color:ColorUtils.grey,fontWeight: FontWeightClass.regular,fontSize: 10.sp);

}