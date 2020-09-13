import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/vertex.dart';
import 'package:gspufrn/models/job.dart';

class sidebar extends StatelessWidget{

	@override
	Widget build(BuildContext context){
		Job test_model = Job(
			tempo:0.5,
			x:0.5,
			y:0.5,
			nome:'Doidera'
		);
		return Drawer(
			child:Container(
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
			)
		);
	}
}