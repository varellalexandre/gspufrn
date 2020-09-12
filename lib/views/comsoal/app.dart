import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/bar.dart';
import 'package:gspufrn/design/field/vertex.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:gspufrn/models/job.dart';

class Comsoal extends StatelessWidget{
	num maxX=0;
	num maxY=0;

	@override
	Widget build(BuildContext context){
		Job test_model = Job(
			tempo:0.5,
			x:0.5,
			y:0.5,
			nome:'Doidera'
		);
		return Scaffold(
			appBar:NavBar(),
			body:Container(
				child:Row(
					children:[
						Expanded(
							flex:2,
							child:GridView.count(
								crossAxisCount:1,
								children:[
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
									Vertex(model:test_model),
								]
							)
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