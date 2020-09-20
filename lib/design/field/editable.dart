import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';

class editable extends StatefulWidget{
	bool beingEdited;
	TextEditingController controller;
	bool numeric;

	editable({
		this.beingEdited,
		this.controller,
		this.numeric=false,
	});

	@override
	_editableState createState()=> _editableState(
		beingEdited:beingEdited,
		controller:controller,
		numeric:numeric,
	);
}

class _editableState extends State<editable>{
	bool beingEdited;
	TextEditingController controller;
	bool numeric;
	RegExp numeric_regex = RegExp(r"\d{1,}(\.|\,){0,1}\d{0,}");

	_editableState({
		this.beingEdited,
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
		Icon icone;
		List<TextInputFormatter> formatter = List();
		if(numeric == true){
			keyboard = TextInputType.numberWithOptions(decimal:true);
			formatter.add(TextInputFormatter.withFunction(numericValidator));
		}
		if(beingEdited==false){
			icone = Icon(Icons.edit);
		}else{
			icone = Icon(Icons.save);
		}
		return Row(
				children:[
				Expanded(
					flex:7,
					child:TextField(
						keyboardType:keyboard,
						controller:controller,
						readOnly:!beingEdited,
						inputFormatters:formatter,
					)
				),
				Expanded(
					flex:1,
					child:Container(
						child:FittedBox(
							child:IconButton(
								icon:icone,
								onPressed:(){
									setState((){
										controller.notifyListeners();
										beingEdited = !beingEdited;
									});
								}
							),
							fit:BoxFit.scaleDown
						)
					)
				),
			]
		);
	}
}