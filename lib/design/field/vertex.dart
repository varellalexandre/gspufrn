import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gspufrn/design/field/editable.dart';
import 'package:gspufrn/design/field/list_controller.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;

class Vertex extends StatelessWidget{
	Job model;
	List<String> dependencies;
	TextEditingController tempo_controller = TextEditingController();
	TextEditingController nome_controller = TextEditingController();
	ScrollController scroll_controller = ScrollController(
		initialScrollOffset:0.0,
		keepScrollOffset:true,
		debugLabel:'Scroll',
	);
	Vertex({
		this.model,
		this.dependencies,
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
												flex:5,
												child:editable(
													beingEdited:false,
													controller:nome_controller,
												)
											),
											Expanded(
												flex:5,
												child:editable(
													beingEdited:false,
													controller:tempo_controller,
													numeric:true,
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