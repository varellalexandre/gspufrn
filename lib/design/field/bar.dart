import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;
import 'package:gspufrn/design/field/redirect.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

PreferredSizeWidget NavBar(BuildContext context){
	return AppBar(
		title:Tooltip(
			message:'Página do COMSOAL',
			child:redirect(
				path:'/comsoal',
				child:Text(
					'GSP3 UFRN',
					style:TextStyle(
						color:theme.secundary,
					),
				),
				context:context,
			)
		),
		iconTheme: IconThemeData(color:theme.secundary),
		backgroundColor:theme.background,
		actions:[
			Tooltip(
				message:'Sobre a tutoria',
				child:redirect(
					path:'/sobre',
					child:FaIcon(FontAwesomeIcons.users),
					context:context,
				)
			),
			Container(
				width:15,
			),
			Image(image:AssetImage('images/dep.png')),
			Container(
				width: 15
			),
			Image(image:AssetImage('images/ufrn.png')),
			Container(
				width: 15
			),
		]
	);
}
