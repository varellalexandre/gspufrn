import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/vertex.dart';
import 'package:gspufrn/models/job.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gspufrn/design/field/linha.dart';

class sidebar extends StatelessWidget{
	Linha model;

	sidebar({this.model});

	@override
	Widget build(BuildContext context){
		return ScopedModel<Linha>(
			model:model,
			child:ScopedModelDescendant<Linha>(
				builder:(context,child,model){
					List<Vertex> children_list = List<Vertex>();

					model.atividades.keys.forEach(
						(atividade)=>children_list.add(
							Vertex(
								model:model.atividades[atividade],
								dependencies:model.depends_on(
									model.atividades[atividade].id_atv,
								),
							)
						)
					);
					model.calculateComsoal();

					return Drawer(
						child:Container(
							child:Column(
								children:[
									Expanded(
										flex:1,
										child:Align(
											alignment:Alignment.center,
											child:FittedBox(
												child:Text('Linha de Produção'),
												fit:BoxFit.scaleDown,
											),
										),
									),
									Expanded(
										flex:9,
										child:linha(model:model),
									),
									Expanded(
										flex:1,
										child:Align(
											alignment:Alignment.center,
											child:FittedBox(
												child:Text('Atividades'),
												fit:BoxFit.scaleDown,
											),
										),
									),
									Expanded(
										flex:21,
										child:GridView.count(
											crossAxisCount:1,
											children:children_list,
										)
									),
								]

							)
						)
					);
				}
			)
		);
	}
}