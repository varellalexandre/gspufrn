import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/bar.dart';
import 'package:gspufrn/design/field/vertex.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/sidebar.dart';
import 'package:gspufrn/design/field/crud_dialog.dart';
import 'package:gspufrn/design/views/main.dart';

class Comsoal extends StatelessWidget{
	Linha linha_model=get_example();

	@override
	Widget build(BuildContext context){

		return Scaffold(
			appBar:NavBar(),
			drawer:sidebar(model:linha_model),
			body:Container(
				child:Main(model:linha_model),
			),
			floatingActionButton:FloatingActionButton.extended(
				onPressed:(){
					Job job = Job(
						tempo:0,
						nome:'Nova Atividade'
					);
					showDialog(
						context:context,
						builder:(_)=>crudDialog(
							linha_model:linha_model,
							job_model:job,
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