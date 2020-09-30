import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/models/group.dart';
import 'package:gspufrn/design/field/draggroup.dart';
import 'package:scoped_model/scoped_model.dart';

//draggable
class Main extends StatelessWidget{
	Linha linha_model;
	List<Group> groups;
	Group disponiveis;

	Main({this.linha_model}){
		this.groups = List<Group>();
		this.disponiveis = Group();
		linha_model.atividades.keys.forEach((job){
			this.disponiveis.addJob(linha_model.atividades[job]);
		});
	}

	@override
	Widget build(BuildContext context){
		return Container(
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
													int last_pos = this.groups.length-1;
													this.groups[last_pos].jobs.forEach((job){
														this.disponiveis.addJob(job);
													});
													this.groups.removeAt(
														this.groups.length-1
													);
													linha_model.notifyListeners();
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
												linha_model.notifyListeners();
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
											return Container(
												constraints:BoxConstraints(minWidth:300),
												width:0.5*MediaQuery.of(context).size.width,
												height:(MediaQuery.of(context).size.height),
												child:draggroup(
													title:'Atividades',
													models:this.disponiveis,
													linha_modelo:model,
													direction:Axis.horizontal,
													remove:(String id_atv){
														Job element;
														this.disponiveis.jobs.forEach((job){
															if(job.id_atv == id_atv){
																element = job;
															}
														});
														this.disponiveis.removeJob(element);
														model.notifyListeners();
													},
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
															linha_modelo:model,
															remove:(String id_atv){
																Job element;
																elemento.jobs.forEach((job){
																	if(job.id_atv == id_atv){
																		element = job;
																	}
																});
																elemento.removeJob(element);
																model.notifyListeners();
															},
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
		);
	}

}