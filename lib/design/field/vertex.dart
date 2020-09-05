import 'package:flutter/material.dart';

class Vertex extends StatelessWidget{
	num x;
	num y;

	Vertex({
		this.x,
		this.y,
	});

	@override
	Widget build(BuildContext context){
		return Positioned(
			left:x,
			top:y,
			child:Text('Aqui'),
		);
	}

}