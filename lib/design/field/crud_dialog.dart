import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/editable.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;


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
		List<Row> activities = List();
		ScrollController scroll_controller = ScrollController(
			initialScrollOffset:0.0,
			keepScrollOffset:true,
			debugLabel:'Scroll',
		);
		model.atividades.keys.forEach(
			(element)=>activities.add(
				Row(
					children:[
						Expanded(
							child:Checkbox(
								value:true,
							)
						)
					]

				)
			)
		);
		if(action == crudDialogAction.add){
			return AlertDialog(
				title:Text('Atividade'),
				titlePadding:EdgeInsets.all(10.0),
				content:Container(
					child:ListView(
						children:[
							Column(
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
										flex:10,
										child:FittedBox(
											fit:BoxFit.scaleDown,
											child:Column(
												children:activities,
											)
										)
									),

								]
							)
						]
					),
				),
			);
		}
	}
}