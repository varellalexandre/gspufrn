import 'package:flutter/material.dart';


PreferredSizeWidget NavBar(){
	return AppBar(
		title:Text(
			'GSP3 UFRN',
			style:TextStyle(
				color:Color(0xFF554800),
			)
		),
		backgroundColor:Color(0xFFFFF2AA),
		actions:[
			Image(image:AssetImage('images/ufrn.png')),
		]
	);
}