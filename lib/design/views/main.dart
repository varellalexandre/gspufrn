import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/models/group.dart';
import 'package:gspufrn/models/resposta.dart';
import 'package:gspufrn/design/field/draggroup.dart';
import 'package:gspufrn/design/field/answer_dialog.dart';
import 'package:gspufrn/design/field/map_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

//draggable
class Main extends StatelessWidget{
	Resposta response;
	Linha problem_info;

	Main({
		this.response,
		this.problem_info
	});

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
												icon:Icon(Icons.map_outlined),
												onPressed: (){
													showDialog(
														context:context,
														builder:(_)=>mapdialog(
															problem_info:this.problem_info
														)
													);
												}
											)
										)
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
													if(this.response.groups.length == 0){
														showDialog(
															context:context,
															builder:(_)=>answerdialog(
																text:'Crie grupos nos botões de +/- \n',
																correct:false,
															)
														);
														return;
													}
													if(this.response.disponiveis.jobs.length > 0){
														showDialog(
															context:context,
															builder:(_)=>answerdialog(
																text:'Aloque todas as tarefas!\n',
																correct:false,
															)
														);
														return;
													}
													bool dependencies_answer = this.response.isDependenciesValid(this.problem_info);
													if(!dependencies_answer){
														showDialog(
															context:context,
															builder:(_)=>answerdialog(
																text:'Verifique se a sequência de atividades está correta',
																correct:false,
															)
														);
														return;
													}
													Resposta correta = this.problem_info.calculateComsoal();
													if(correta == null){
														showDialog(
															context:context,
															builder:(_)=>answerdialog(
																text:'Erro na quantidade de peças',
																correct:false,
															)
														);
														return;
													}
													bool time_answer = this.response.isTimeValid(this.problem_info.takt_time);
													if(!time_answer){
														showDialog(
															context:context,
															builder:(_)=>answerdialog(
																text:'Verifique se os tempos estão corretamente alocados',
																correct:false,
															)
														);
														return;
													}
													if(!correta.compare(this.response,this.problem_info.takt_time)){
														showDialog(
															context:context,
															builder:(_)=>answerdialog(
																text:'Você pode melhorar essa eficiência\n',
																correct:false,
															)
														);
														return;
													}
													showDialog(
														context:context,
														builder:(_)=>answerdialog(
															text:'Parabéns! você acertou',
															correct:true,
														)
													);
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
										flex:4,
										child:ScopedModelDescendant<Resposta>(
											builder:(context,child,model){
												return Container(
													constraints:BoxConstraints(minWidth:300),
													width:0.75*MediaQuery.of(context).size.width,
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
																title:'Estágio ${lista_grupos.length+1}',
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