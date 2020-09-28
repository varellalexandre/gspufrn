import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;


class grouplist extends StatelessWidget{
	
//	grouplist({});

	@override
	Widget build(BuildContext context){
		return DragTarget(
			builder:
				(context, List candidateData, rejectedData){
					print(candidateData);
					return Container(
						width:200,
						height:0.8*MediaQuery.of(context).size.height,
						margin: EdgeInsets.all(15),
						color: theme.secundary.withOpacity(1),
					);
			},
			onWillAccept:(data){
				return true;
			},
			onAccept: (data){
				print('hello');
				print(data);
			},
		);
	}
}