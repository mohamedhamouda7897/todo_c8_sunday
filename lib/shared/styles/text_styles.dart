import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles{
 static TextStyle Robto12Black()=>GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.normal,
      color: Colors.black);

 static TextStyle poppins18Light()=>GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold, color: AppColors.lightColor);
 static TextStyle poppins22White()=>GoogleFonts.poppins(
      fontSize: 22, fontWeight: FontWeight.bold,
      color: Colors.white);
}
