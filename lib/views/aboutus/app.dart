import 'package:flutter/material.dart';
import 'package:gspufrn/design/field/bar.dart';
import 'package:gspufrn/models/tutor.dart';
import 'dart:io';
import 'dart:convert';



class Aboutus extends StatelessWidget{
	@override
	Widget build(BuildContext context){
		Tutoria atual = Tutoria();
		DefaultAssetBundle.of(context)
		.loadString('tutor/2020-6.json')
		.then(
			(resp){
				atual.updateTutoria(json.decode(resp));
				
			}
		);
		return Scaffold(
			appBar:NavBar(),
			body:Container(
				child:Column(
					children:[
						Expanded(
							flex:4,
							child:Container(),
						),
						Expanded(
							flex:10,
							child:atual.widgettutoria(),
						),	
					]
				),
			)
		);
	}

}