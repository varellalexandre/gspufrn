import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/vertex.dart';
import 'package:gspufrn/models/job.dart';

class sidebar extends StatelessWidget{



	@override
	Widget build(BuildContext context){
		Linha exemplo = get_example();
		List<Vertex> children_list = List<Vertex>();

		exemplo.atividades.forEach(
			(atividade)=>children_list.add(
				Vertex(model:atividade)
			)
		);
		exemplo.calculateComsoal();
		return Drawer(
			child:Container(
				child:Column(
					children:[
						Expanded(
							flex:3,
							child:Container(),
						),
						Expanded(
							flex:7,
							child:GridView.count(
								crossAxisCount:1,
								children:children_list,
							)
						),
					]

				)
			)
		);
	}
}