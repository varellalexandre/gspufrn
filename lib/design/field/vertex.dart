import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gspufrn/design/field/editable.dart';

class Vertex extends StatelessWidget{
	Job model;
	TextEditingController tempo_controller = TextEditingController();
	TextEditingController nome_controller = TextEditingController();

	Vertex({
		this.model
	});

	@override
	Widget build(BuildContext context){
		tempo_controller.text = "${model.tempo}";
		nome_controller.text = model.nome;
		return Container(
			child:Card(
				color:Color(0xFFFFF2AA),
				child:Padding(
					padding:EdgeInsets.all(5.0),
					child:Container(
						child:AspectRatio(
							aspectRatio:4/2,
							child:Row(
								children:[
									Expanded(
										flex:1,
										child:FittedBox(
											fit:BoxFit.fitHeight,
											child:Icon(Icons.remove)
										)
									),
									Expanded(
										flex:5,
										child:Column(
											children:[
												Expanded(
													flex:1,
													child:editable(
														beingEdited:false,
														controller:nome_controller,
													)
												),
												Expanded(
													flex:1,
													child:editable(
														beingEdited:true,
														controller:tempo_controller,
													)
												)
											]
										)
									)
								]
							)
						)
					)
				)
			)
		);
	}

}