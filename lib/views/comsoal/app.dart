import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/bar.dart';

class Comsoal extends StatelessWidget{
	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar:NavBar(),
			body:Container(
				color:Color(0xFFD4C56A),
				child:Text('Aqui')
			)
		);
	}

}