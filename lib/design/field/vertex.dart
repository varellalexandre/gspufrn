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
			left:MediaQuery.of(context).size.width*x,
			top:MediaQuery.of(context).size.height*y,
			child:Text('Aqui'),
		);
	}

}