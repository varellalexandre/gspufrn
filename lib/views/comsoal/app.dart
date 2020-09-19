import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/bar.dart';
import 'package:gspufrn/design/field/vertex.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/sidebar.dart';

class Comsoal extends StatelessWidget{
	num maxX=0;
	num maxY=0;

	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar:NavBar(),
			drawer:sidebar(),
			body:Container(
				child:Row(
					children:[
						Expanded(
							flex:2,
							child:Container()
						),
						Expanded(
							flex:7,
							child:Container(),
						)
					],
				)
			)
		);
	}

}