import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/bar.dart';
import 'package:gspufrn/design/field/vertex.dart';

class Comsoal extends StatelessWidget{
	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar:NavBar(),
			body:Stack(
				children:[
					Vertex(x:0.5,y:0.5)
				],
			)
		);
	}

}