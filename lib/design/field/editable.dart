import 'package:flutter/material.dart';
class editable extends StatelessWidget{
	bool beingEdited;
	TextEditingController controller;

	editable({
		this.beingEdited,
		this.controller
	});

	@override
	Widget build(BuildContext context){
		return Row(
				children:[
				Expanded(
					flex:5,
					child:TextField(
						controller:controller,
						readOnly:beingEdited,
					)
				),
				Expanded(
					flex:1,
					child:Container(
						child:FittedBox(
							child:Icon(Icons.edit),
							fit:BoxFit.scaleDown
						)
					)
				),
			]
		);
	}
}