import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gspufrn/design/field/editable.dart';

class Vertex extends StatelessWidget{
	Job model;
	TextEditingController tempo_controller = TextEditingController();
	TextEditingController nome_controller = TextEditingController();
	ScrollController scroll_controller = ScrollController(
		initialScrollOffset:0.0,
		keepScrollOffset:true,
		debugLabel:'Scroll',
	);
	Vertex({
		this.model
	});

	_updateTempo(){
		model.updateTempo(num.parse(tempo_controller.text));
	}
	_updateNome(){
		model.updateNome(nome_controller.text);
	}


	@override
	Widget build(BuildContext context){
		tempo_controller.addListener(_updateTempo);
		nome_controller.addListener(_updateNome);
		return ScopedModel<Job>(
			model:model,
			child:ScopedModelDescendant<Job>(
				builder:(context,child,model){
					tempo_controller.text = "${model.tempo}";
					nome_controller.text = model.nome;

					List<Chip> depends_on = List();
					model.predecessores.forEach(
						(element)=>depends_on.add(
							Chip(
								label:Text(
									'Atividade ${element+1}',
									style:TextStyle(
										color:Colors.white
									),
								),
								backgroundColor:Color(0xFF554800),
							)
						)
					);

					return Container(
						child:Card(
							color:Color(0xFFFFF2AA),
							child:Padding(
								padding:EdgeInsets.all(10.0),
								child:Container(
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
													numeric:true,
												)
											),
											Expanded(
												flex:3,
												child:Column(
													children:[
														Expanded(
															flex:1,
															child:Align(
																alignment:Alignment.bottomLeft,
																child:FittedBox(
																	fit:BoxFit.scaleDown,
																	child:Text('Depende de : ')
																),
															),
														),
														Expanded(
															flex:9,
															child:GridView.count(
																shrinkWrap:true,
																crossAxisCount:1,
																controller:scroll_controller,
																scrollDirection: Axis.horizontal,
																children:depends_on,
															)
														),
														Expanded(
															flex:4,
															child:Row(
																children:[
																	Expanded(
																		flex:1,
																		child:IconButton(
																			icon:Icon(Icons.arrow_left),
																			onPressed:(){
																				ScrollPosition pos = scroll_controller.position;
																				if (scroll_controller.offset > pos.minScrollExtent){
																					num where_to_go =scroll_controller.offset-100.0;
																					if (where_to_go > pos.minScrollExtent){
																						scroll_controller.animateTo(
																							where_to_go,
																							duration:Duration(milliseconds:200),
																							curve: Curves.easeIn,

																						);
																					}else{
																						scroll_controller.animateTo(
																							pos.minScrollExtent,
																							duration:Duration(milliseconds:200),
																							curve: Curves.easeIn,

																						);
																					}
																				}
																				
																			}
																		),
																	),
																	Expanded(
																		flex:3,
																		child:Container(
																		),
																	),
																	Expanded(
																		flex:1,
																		child:IconButton(
																			icon:Icon(Icons.arrow_right),
																			onPressed:(){
																				ScrollPosition pos = scroll_controller.position;
																				if (scroll_controller.offset < pos.maxScrollExtent){
																					num where_to_go =scroll_controller.offset+100.0;
																					if (where_to_go < pos.maxScrollExtent){
																						scroll_controller.animateTo(
																							where_to_go,
																							duration:Duration(milliseconds:200),
																							curve: Curves.easeIn,

																						);
																					}else{
																						scroll_controller.animateTo(
																							pos.maxScrollExtent,
																							duration:Duration(milliseconds:200),
																							curve: Curves.easeIn,

																						);
																					}
																				}
																				
																			}
																		),
																	),
																]
															),
														)
													]
												)
											),
										]
									)
								)
							)
						)
					);
				}
			)
		);
	}

}