import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;


class draggablejob extends StatelessWidget{
	List<Job> jobs;

	draggablejob({this.jobs});


	@override
	Widget build(BuildContext context){
		List<Draggable> elements = List<Draggable>();
		jobs.forEach((job){
			elements.add(
				Draggable(
					child:Container(
						margin: EdgeInsets.all(15),
						color: theme.primary,
						child:Align(
							alignment:Alignment.center,
							child:RichText(
								text:TextSpan(
									text:'${job.nome}',
									style:TextStyle(color:Colors.white),
								),
							),
						),
						width:200,
						height:50,
					),
					feedback:Container(
						margin: EdgeInsets.all(15),
						color: theme.primary,
						child:Align(
							alignment:Alignment.center,
							child:RichText(
								text:TextSpan(
									text:'${job.nome}',
									style:TextStyle(color:Colors.white),
								),
							),
						),
						width:200,
						height:50,
					),
					childWhenDragging: Container(
						margin: EdgeInsets.all(15),
						color: theme.background,
						width:50,
						height:50,
					),
				)
			);
		});
		return ListView(
			padding: EdgeInsets.all(15),
			children:elements,

		);
	}

}