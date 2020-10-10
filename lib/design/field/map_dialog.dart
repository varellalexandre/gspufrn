import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';


class mapdialog extends StatelessWidget{
	Linha problem_info;

	mapdialog({this.problem_info});

	Widget build(BuildContext context){
		List dep = this.problem_info.orderDependencies();
		print(dep);
		return AlertDialog(
			title:Row(
				children:[
					Expanded(
						flex:2,
						child:Text('Mapa das Atividades'),
					),
					Expanded(
						flex:10,
						child:Container(),
					),
					Expanded(
						flex:3,
						child:Align(
							alignment:Alignment.centerRight,
							child:IconButton(
								icon:Icon(Icons.close),
								onPressed: (){
									Navigator.pop(context);
								}
							)
						)
					),
				]
			),
			titlePadding:EdgeInsets.all(10.0),
			content:
		);
	}

}