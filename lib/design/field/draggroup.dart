import 'package:gspufrn/models/group.dart';
import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;
import 'package:random_color/random_color.dart';

class draggroup extends StatelessWidget{
	Group models;
	Linha linha_modelo;
	String title;
	Color color;
	draggroup({this.models,this.linha_modelo,this.title}){
		this.color = RandomColor().randomColor();
	}

	@override
	Widget build(BuildContext context){
		return Column(
			children:[
				Expanded(
					flex:1,
					child:FittedBox(
						fit:BoxFit.scaleDown,
						child:Text(this.title),
					),
				),
				Expanded(
					flex:15,
					child:DragTarget(
						builder:
							(context, List candidateData, rejectedData){
								List<Draggable> elements = List<Draggable>();
								models.jobs.forEach((job){
									elements.add(
										Draggable(
											data:job.id_atv,
											child:Container(
												margin: EdgeInsets.all(15),
												color: RandomColor().randomColor(),
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
								return Container(
									decoration:BoxDecoration(
										border:Border.all(),
										borderRadius:BorderRadius.all(Radius.circular(2)),
										color: theme.background,
									),
									width:0.9*(MediaQuery.of(context).size.width),
									height:(MediaQuery.of(context).size.height),
									margin: EdgeInsets.all(15),
									child:ListView(
										padding:EdgeInsets.all(15),
										children:elements,
									)
								);
						},
						onWillAccept:(data){
							return true;
						},
						onAccept: (data){
						}
					)
				)
			]
		);
	}

}
