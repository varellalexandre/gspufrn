import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class answerdialog extends StatelessWidget{
	String text;
	bool correct;

	answerdialog({this.text,this.correct});

	Widget build(BuildContext context){
		String title;
		IconData icone;
		Color cor;
		if(this.correct){
			title = 'Resposta Correta';
			cor = Colors.green;
			icone = FontAwesomeIcons.checkCircle;
		}else{
			title = 'Resposta Errada';
			cor = Colors.red;
			icone = FontAwesomeIcons.timesCircle;
		}
		return AlertDialog(
			title:Row(
				children:[
					Expanded(
						flex:3,
						child:FittedBox(
							fit:BoxFit.scaleDown,
							child:Text(title),
						),
					),
					Expanded(
						flex:10,
						child:Container(),
					),
					Expanded(
						flex:1,
						child: IconButton(
							icon:Icon(Icons.close),
							onPressed:(){
								Navigator.pop(context);
							}
						)
					)
				]
			),
			contentPadding:EdgeInsets.all(10),
			content:Column(
				children:[
					Expanded(
						flex:10,
						child:Center(
							child:Container(
								child:FaIcon(
									icone,
									size:0.45*(MediaQuery.of(context).size.width),
									color:cor,
								)
							)
						)
					),
					Expanded(
						flex:5,
						child:FittedBox(
							fit:BoxFit.scaleDown,
							child:Text(this.text),
						),
					),
				]
			)
		);
	}


}