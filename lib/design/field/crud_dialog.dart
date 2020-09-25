import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/editable.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;
import 'package:chips_choice/chips_choice.dart';
import 'package:scoped_model/scoped_model.dart';


enum crudDialogAction{
	none,
	add,
	edit,
}


class crudDialog extends StatelessWidget{
	Linha linha_model;
	Job job_model;
	crudDialogAction action;
	Dependencies dep = Dependencies();
	TextEditingController tempo_controller;
	TextEditingController nome_controller;

	crudDialog({this.linha_model,this.action,this.job_model}){
		this.tempo_controller=TextEditingController(text:"${job_model.tempo}");
		this.nome_controller=TextEditingController(text:job_model.nome);
	}

	_updateTempo(){
		job_model.updateTempo(num.parse(tempo_controller.text));
	}
	_updateNome(){
		job_model.updateNome(nome_controller.text);
	}


	@override
	Widget build(BuildContext context){
		nome_controller.addListener(_updateNome);
		tempo_controller.addListener(_updateTempo);
		if(action == crudDialogAction.add){
			List<ChipsChoiceOption> opts = List();
			linha_model.atividades.keys.forEach((value){
				opts.add(
					ChipsChoiceOption(
						value:value,
						label:linha_model.atividades[value].nome,
					)
				);
			});
			return AlertDialog(
				title:Row(
					children:[
						Align(
							alignment:Alignment.centerRight,
							child:IconButton(
								icon:Icon(Icons.close),
								onPressed: (){
									Navigator.pop(context);
								}
							)
						),
						Text('Atividade'),
					]
				),
				titlePadding:EdgeInsets.all(10.0),
				content:Container(
					child:Column(
						children:[
							Expanded(
								flex:1,
								child:Align(
									alignment:Alignment.centerLeft,
									child:FittedBox(
										fit:BoxFit.scaleDown,
										child:Text('Nome :')
									)
								)
							),
							Expanded(
								flex:3,
								child:editable(
									controller:nome_controller,
								)
							),
							Expanded(
								flex:1,
								child:Align(
									alignment:Alignment.centerLeft,
									child:FittedBox(
										fit:BoxFit.scaleDown,
										child:Text('Tempo :')
									)
								)
							),
							Expanded(
								flex:3,
								child:editable(
									controller:tempo_controller,
									numeric:true,
								)
							),
							Expanded(
								flex:1,
								child:Align(
									alignment:Alignment.centerLeft,
									child:FittedBox(
										fit:BoxFit.scaleDown,
										child:Text('Dependencias :')
									)
								)
							),
							Expanded(
								flex:10,
								child:Container(
									child:ScopedModel<Dependencies>(
										model:dep,
										child:ScopedModelDescendant<Dependencies>(
											builder:(context,child,model){
												return ChipsChoice.multiple(
													value:model.dependencies,
													options: opts,
													onChanged: (val)=>model.updateDepedencies(val),
												);
											}
										)
									)
								)
							),
							Expanded(
								flex:2,
								child:Row(
									children:[
										FittedBox(
											fit:BoxFit.scaleDown,
											child:IconButton(
												icon:Icon(Icons.save),
												onPressed: (){

												}
											)
										),
									]

								)
							)
						]
					),
				),
			);
		}
	}
}