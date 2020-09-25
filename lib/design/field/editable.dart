import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';

class editable extends StatefulWidget{
	TextEditingController controller;
	bool numeric;

	editable({
		this.controller,
		this.numeric=false,
	});

	@override
	_editableState createState()=> _editableState(
		controller:controller,
		numeric:numeric,
	);
}

class _editableState extends State<editable>{
	TextEditingController controller;
	bool numeric;
	RegExp numeric_regex = RegExp(r"\d{1,}(\.|\,){0,1}\d{0,}");

	_editableState({
		this.controller,
		this.numeric=false,
	});

	TextEditingValue numericValidator(TextEditingValue oldValue, TextEditingValue newValue){
		if(oldValue.text == ''){
			return newValue.copyWith(text:'0.0');
		}
		return newValue.copyWith(text:numeric_regex.stringMatch(newValue.text));
	}

	@override
	Widget build(BuildContext context){
		TextInputType keyboard = TextInputType.name;
		List<TextInputFormatter> formatter = List();
		if(numeric == true){
			keyboard = TextInputType.numberWithOptions(decimal:true);
			formatter.add(TextInputFormatter.withFunction(numericValidator));
		}
		return TextField(
			keyboardType:keyboard,
			controller:controller,
			inputFormatters:formatter,
		);
	}
}