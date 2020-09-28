import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;


class grouplist extends StatelessWidget{

//	grouplist({});

	@override
	Widget build(BuildContext context){
		return Container(
			width:200,
			height:0.8*MediaQuery.of(context).size.height,
			margin: EdgeInsets.all(15),
			color: theme.secundary.withOpacity(0.5),
			child:DragTarget(
				builder:
					(context, List<int> candidateData, rejectedData){
						print(candidateData);
						return Text('Text');
					},
				onWillAccept: (data){
					print(data);
					return true;
				},
				onAccept: (data){
					print(data);
					return true;
				}
			)
		);
	}
}