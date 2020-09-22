import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/editable.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;
import 'package:chips_choice/chips_choice.dart';


enum crudDialogAction{
	none,
	add,
	edit,
}


class crudDialog extends StatelessWidget{
	Linha model;
	crudDialogAction action;
	TextEditingController tempo_controller = TextEditingController();
	TextEditingController nome_controller = TextEditingController();

	crudDialog({this.model,this.action});


	@override
	Widget build(BuildContext context){
		if(action == crudDialogAction.add){
			List<ChipsChoiceOption> opts = List();
			List<String> marked = List();
			model.atividades.keys.forEach((value){
				opts.add(
					ChipsChoiceOption(
						value:value,
						label:model.atividades[value].nome,
					)
				);
			});
			return AlertDialog(
				title:Text('Atividade'),
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
									beingEdited:false,
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
									beingEdited:false,
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
								flex:15,
								child:Container(
									child:ChipsChoice.multiple(
										value:marked,
										options: opts,
										onChanged: (val) =>print(val),
									)
								)
							)
						]
					),
				),
			);
		}
	}
}