import 'package:gspufrn/models/group.dart';
import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;

class draggroup extends StatelessWidget{
	Group models;
	Linha linha_modelo;
	draggroup({this.models,this.linha_modelo});

	@override
	Widget build(BuildContext context){
		return DragTarget(
			builder:
				(context, List candidateData, rejectedData){
					List<Draggable> elements = List<Draggable>();
					models.jobs.forEach((job){
						elements.add(
							Draggable(
								data:job.id_atv,
								child:Container(
									margin: EdgeInsets.all(15),
									color: theme.primary,
									child:Align(
										alignment:Alignment.center,
										child:RichText(
											text:TextSpan(
												text:'${job.nome}',
												style:TextStyle(color:Colors.white),
											),
										),
									),
									width:200,
									height:50,
								),
								feedback:Container(
									margin: EdgeInsets.all(15),
									color: theme.primary,
									child:Align(
										alignment:Alignment.center,
										child:RichText(
											text:TextSpan(
												text:'${job.nome}',
												style:TextStyle(color:Colors.white),
											),
										),
									),
									width:200,
									height:50,
								),
								childWhenDragging: Container(
									margin: EdgeInsets.all(15),
									color: theme.background,
									width:50,
									height:50,
								),
							)
						);
					});
					return ListView(
						padding:EdgeInsets.all(15),
						children:elements,
					);
			},
			onWillAccept:(data){
				return true;
			},
			onAccept: (data){
				print('hello');
				print(data);
			}
		);
	}

}
