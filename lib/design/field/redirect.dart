import 'package:flutter/material.dart';

FlatButton redirect({String path,Widget child,BuildContext context}){
	return FlatButton(
		child:child,
		textColor:Color(0xFFFFFFFF),
		color:Colors.transparent,
		onPressed:() {
			Navigator.pushNamed(context, path);
		}
	);
}
