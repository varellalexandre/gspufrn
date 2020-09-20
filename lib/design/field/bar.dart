import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;

PreferredSizeWidget NavBar(){
	return AppBar(
		title:Text(
			'GSP3 UFRN',
			style:TextStyle(
				color:theme.secundary,
			)
		),
		iconTheme: IconThemeData(color:theme.secundary),
		backgroundColor:theme.background,
		actions:[
			Image(image:AssetImage('images/ufrn.png')),
		]
	);
}