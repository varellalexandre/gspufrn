import 'package:flutter/material.dart';
import 'package:gspufrn/routes.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;

void main() {
  runApp(
    MaterialApp(
      title:'GSPUFRN',
      initialRoute:'/comsoal',
      routes:routes,
      theme:theme.theme_data,
    )
  );
}
