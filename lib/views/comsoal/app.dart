import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/bar.dart';
import 'package:gspufrn/design/field/vertex.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/sidebar.dart';
import 'package:gspufrn/design/field/crud_dialog.dart';

class Comsoal extends StatelessWidget{
	Linha linha_model=get_example();

	@override
	Widget build(BuildContext context){

		return Scaffold(
			appBar:NavBar(),
			drawer:sidebar(model:linha_model),
			body:Container(
				child:Column(
					children:[
						Expanded(
							flex:2,
							child:Container(
							),
						),
						Expanded(
							flex:7,
							child:Container(
							),
						),
					],
				)
			),
			floatingActionButton:FloatingActionButton.extended(
				onPressed:(){
					print('hello');
					showDialog(
						context:context,
						builder:(_)=>crudDialog(
							model:linha_model,
							action:crudDialogAction.add,
						),
					);
				},
				label:Text('Adicionar Atividade'),
				icon:Icon(Icons.add),
			),

		);
	}

}