import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gspufrn/design/field/editable.dart';
import 'package:gspufrn/design/field/list_controller.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;
import 'package:gspufrn/design/field/crud_dialog.dart';

class Vertex extends StatelessWidget{
	Job model;
	List<String> dependencies;
	Linha linha;
	ScrollController scroll_controller = ScrollController(
		initialScrollOffset:0.0,
		keepScrollOffset:true,
		debugLabel:'Scroll',
	);
	Vertex({
		this.model,
		this.dependencies,
		this.linha,
	});


	@override
	Widget build(BuildContext context){
		return ScopedModel<Job>(
			model:model,
			child:ScopedModelDescendant<Job>(
				builder:(context,child,model){
					List<Chip> depends_on = List();
					dependencies.forEach(
						(element)=>depends_on.add(
							Chip(
								label:Text(
									'${element}',
									style:TextStyle(
										color:theme.primary_back,
									),
								),
								backgroundColor:theme.secundary,
							)
						)
					);
					return Container(
						child:Card(
							color:theme.background,
							child:Padding(
								padding:EdgeInsets.all(10.0),
								child:Container(
									child:Column(
										children:[
											Expanded(
												flex:2,
												child:Row(
													children:[
														Expanded(
															flex:8,
															child:Container()
														),
														Expanded(
															flex:1,
															child:FittedBox(
																fit:BoxFit.scaleDown,
																child:IconButton(
																	icon:Icon(Icons.edit),
																	onPressed: (){
																		showDialog(
																			context:context,
																			builder:(_)=>crudDialog(
																				job_model:model,
																				action:crudDialogAction.edit,
																				linha_model:linha,
																			),
																		);
																	}
																)
															)
														),
														Expanded(
															flex:1,
															child:FittedBox(
																fit:BoxFit.scaleDown,
																child:IconButton(
																	icon:Icon(Icons.close),
																	onPressed: (){
																		model.delete(model.id_atv);
																		linha.notifyListeners();
																	}
																)
															)
														)
													]
												)
											),
											Expanded(
												flex:4,
												child:Align(
													alignment:Alignment.centerLeft,
													child:FittedBox(
														fit:BoxFit.scaleDown,
														child:Text('Nome : ${model.nome}')
													),
												)
											),
											Expanded(
												flex:4,
												child:Align(
													alignment:Alignment.centerLeft,
													child:FittedBox(
														fit:BoxFit.scaleDown,
														child:Text('Tempo : ${model.tempo}')
													),
												)
											),
											Expanded(
												flex:13,
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
															child:list_controller(
																controller:scroll_controller,
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