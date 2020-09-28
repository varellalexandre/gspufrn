import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';


class draggablejob extends StatelessWidget{
	List<Job> jobs;

	draggablejob({this.jobs});


	@override
	Widget build(BuildContext context){
		List<Expanded> elements = List<Expanded>();
		jobs.forEach((job){
			elements.add(
				Expanded(
					flex:1,
					child:Text('${job.nome}'),
				)
			);
		});
		return Container(
			child:Column(
				children:elements,
			)
		);
	}

}