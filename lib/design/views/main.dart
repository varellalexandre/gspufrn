import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/models/group.dart';
import 'package:gspufrn/design/field/draggablejob.dart';
import 'package:gspufrn/design/field/grouplist.dart';
import 'package:scoped_model/scoped_model.dart';

//draggable
class Main extends StatelessWidget{
	Linha model;
	List<Group> groups; 

	Main({this.model}){
		this.groups = List<Group>();
	}

	@override
	Widget build(BuildContext context){
		return ScopedModel<Linha>(
			model:model,
			child:Container(
				child:Column(
					children:[
						Expanded(
							flex:1,
							child:Row(
								children:[
									Expanded(
										flex:13,
										child:Container()
									),
									Expanded(
										flex:1,
										child:FittedBox(
											fit:BoxFit.scaleDown,
											child:IconButton(
												icon:Icon(Icons.add),
												onPressed: (){

												}
											)
										)
									),
									Expanded(
										flex:1,
										child:FittedBox(
											fit:BoxFit.scaleDown,
											child:IconButton(
												icon:Icon(Icons.send),
												onPressed: (){

												}
											)
										)
									)
								]
							)
						),
						Expanded(
							flex:1,
							child:Container()
						),
						Expanded(
							flex:15,
							child:Row(
								children:[
									Expanded(
										flex:3,
										child:ScopedModelDescendant<Linha>(
											builder:(context,child,model){
												List<Job> jobs = List<Job>();
												model.atividades.keys.forEach((key){
													jobs.add(model.atividades[key]);
												});
												return draggablejob(jobs:jobs);
											}
										)
									),
									Expanded(
										flex:9,
										child:grouplist(),
									)
								]
							),
						)
					]
				)
			)
		);
	}

}