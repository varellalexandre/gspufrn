import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/models/group.dart';
import 'package:gspufrn/models/resposta.dart';
import 'package:gspufrn/design/field/draggroup.dart';
import 'package:scoped_model/scoped_model.dart';

//draggable
class Main extends StatelessWidget{
	Resposta response;

	Main({this.response});

	@override
	Widget build(BuildContext context){
		return ScopedModel<Resposta>(
			model:this.response,
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
													if(this.response.groups.length > 0){
														int last_pos = this.response.groups.length-1;
														this.response.groups[last_pos].jobs.forEach((job){
															this.response.disponiveis.addJob(job);
														});
														this.response.groups.removeAt(
															last_pos
														);

														this.response.notifyListeners();
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
													this.response.groups.add(
														Group()
													);
													this.response.notifyListeners();
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
										child:ScopedModelDescendant<Resposta>(
											builder:(context,child,model){
												return Container(
													constraints:BoxConstraints(minWidth:300),
													width:0.5*MediaQuery.of(context).size.width,
													height:(MediaQuery.of(context).size.height),
													child:draggroup(
														model:model.disponiveis,
														response:model,
														title:'Atividades',
														direction:Axis.horizontal,
													)
												);
											}
										)
									),
									Expanded(
										flex:9,
										child:ScopedModelDescendant<Resposta>(
											builder:(context,child,model){
												List<Widget> lista_grupos = List();
												model.groups.forEach((elemento){
													lista_grupos.add(
														Container(
															width:300,
															height:(MediaQuery.of(context).size.height),
															child:draggroup(
																title:'Grupo ${lista_grupos.length+1}',
																response:model,
																model:elemento,
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