import 'package:flutter/material.dart';

Color _primary = Color(0xFF666666);
Color _primary_back = Colors.black;
Color _secundary = Colors.white;
Color _background = Color(0xFF4c4c4c);
ThemeData _theme_data = ThemeData(
	brightness:Brightness.dark,
	primaryColor: _primary,
	accentColor: _secundary,
	fontFamily:'Abel',
);

Color get primary=>_primary;
Color get primary_back=>_primary_back;
Color get background=>_background;
Color get secundary=>_secundary;
ThemeData get theme_data =>_theme_data;