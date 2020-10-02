import 'package:gspufrn/models/group.dart';
import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;
import 'package:random_color/random_color.dart';
import 'package:gspufrn/models/resposta.dart';
import 'package:scoped_model/scoped_model.dart';

class draggroup extends StatelessWidget{
	Resposta response;
	Group model;
	String title;
	Axis direction;
	draggroup({
		this.response,
		this.model,
		this.title,
		this.direction:Axis.vertical
	});

	@override
	Widget build(BuildContext context){
		int flex_val;
		if(direction == Axis.horizontal){
			flex_val = 3;
		}else{
			flex_val = 1;
		}
		return Column(
			children:[
				Expanded(
					flex:flex_val,
					child:ScopedModel<Group>(
						model:this.model,
						child:ScopedModelDescendant<Group>(
							builder:(context,child,model){
								return FittedBox(
									fit:BoxFit.scaleDown,
									child:Text("${this.title}\nTempo : ${this.model.totalTime()} "),
								);
							}
						)
					),
				),
				Expanded(
					flex:15,
					child:DragTarget(
						builder:
							(context, List candidateData, rejectedData){
								return ScopedModel<Group>(
									model:this.model,
									child:ScopedModelDescendant<Group>(
										builder:(context,child,model){
											List<Draggable> elements = List<Draggable>();
											model.jobs.forEach((job){
												elements.add(
													Draggable(
														data:job.id_atv,
														child:Container(
															margin: EdgeInsets.all(5),
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
														onDragEnd:(DraggableDetails details){
															if(details.wasAccepted){
																this.model.removeJob(job);
																this.model.notifyListeners();
															}

														},
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
													border:Border.all(
														color:theme.background,
													),
													borderRadius:BorderRadius.all(Radius.circular(3)),
													color: theme.background,
												),
												width:0.9*(MediaQuery.of(context).size.width),
												height:(MediaQuery.of(context).size.height),
												margin: EdgeInsets.all(15),
												child:ListView(
													scrollDirection:this.direction,
													padding:EdgeInsets.all(15),
													children:elements,
												)
											);
										}
									)
								);

						},
						onWillAccept:(data){
							return true;
						},
						onAccept: (data){
							Job draggedJob;
							this.response.all_jobs.jobs.forEach((job){
								if(job.id_atv == data){
									draggedJob = job;
									this.model.addJob(draggedJob);
								}
							});
							this.model.notifyListeners();
						}
					)
				)
			]
		);
	}

}
