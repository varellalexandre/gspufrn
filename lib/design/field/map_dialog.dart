import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:graphite/core/matrix.dart';
import 'package:graphite/core/typings.dart';
import 'package:graphite/graphite.dart';
import 'dart:convert';


class mapdialog extends StatelessWidget{
	Linha problem_info;

	mapdialog({this.problem_info});

	Widget build(BuildContext context){
		List dep = this.problem_info.orderDependencies();
		return AlertDialog(
			title:Row(
				children:[
					Expanded(
						flex:2,
						child:Text('Mapa das Atividades'),
					),
					Expanded(
						flex:7,
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
			content:Container(
				width:0.8*(MediaQuery.of(context).size.width),
				height:0.8*(MediaQuery.of(context).size.height),
				child:DirectGraph(
					list:nodeInputFromJson(json.encode(dep)),
					cellWidth:200,
					cellPadding:10,
        			contactEdgesDistance: 10.0,
					orientation:MatrixOrientation.Horizontal,
				)
			),
		);
	}

}
//https://pub.dev/packages/graphite