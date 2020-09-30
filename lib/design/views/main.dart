import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/models/group.dart';
import 'package:gspufrn/design/field/draggroup.dart';
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
												icon:Icon(Icons.remove),
												onPressed: (){
													if(this.groups.length > 0){
														this.groups.removeAt(
															this.groups.length-1
														);
														model.notifyListeners();
													}
												}
											)
										)
									),
									Expanded(
										flex:1,
										child:FittedBox(
											fit:BoxFit.scaleDown,
											child:IconButton(
												icon:Icon(Icons.add),
												onPressed: (){
													this.groups.add(
														Group()
													);
													model.notifyListeners();
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
							flex:15,
							child:Column(
								children:[
									Expanded(
										flex:2,
										child:ScopedModelDescendant<Linha>(
											builder:(context,child,model){
												Group all_jobs = Group();
												model.atividades.keys.forEach((key){
													all_jobs.addJob(model.atividades[key]);
												});
												return 	Container(
													constraints:BoxConstraints(minWidth:300),
													width:0.5*MediaQuery.of(context).size.width,
													height:(MediaQuery.of(context).size.height),
													child:draggroup(
														title:'Atividades',
														models:all_jobs,
														linha_modelo:model
													)
												);
											}
										)
									),
									Expanded(
										flex:9,
										child:ScopedModelDescendant<Linha>(
											builder:(context,child,model){
												List<Widget> lista_grupos = List();
												groups.forEach((elemento){
													lista_grupos.add(
														Container(
															width:300,
															height:(MediaQuery.of(context).size.height),
															child:draggroup(
																title:'Grupo ${lista_grupos.length+1}',
																models:elemento,
																linha_modelo:model
															)
														)
													);
												});
												return Container(
													child:ListView(
														padding:EdgeInsets.all(15),
														scrollDirection:Axis.horizontal,
														children:lista_grupos,
													)
												);
											}
										)
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