import 'package:flutter/material.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/design/field/color_theme.dart' as theme;
import 'package:gspufrn/design/field/editable.dart';

class linha extends StatelessWidget{
	Linha model;
	TextEditingController pecas_controller;
	TextEditingController horas_controller;

	_updatePecas(){
		model.updateQtdPecas(num.parse(pecas_controller.text));
	}

	_updateHoras(){
		model.updateHoras(num.parse(horas_controller.text));
	}

	linha({this.model}){
		pecas_controller = TextEditingController(text:'${model.qtd_pecas}');
		horas_controller = TextEditingController(text:'${model.horas_disp}');
	}

	@override
	Widget build(BuildContext context){
		pecas_controller.addListener(_updatePecas);
		horas_controller.addListener(_updateHoras);

		return Container(
			child:Card(
				color:theme.primary,
				child:Padding(
					padding:EdgeInsets.all(10.0),
					child:Container(
						child:Column(
							children:[
								Expanded(
									flex:1,
									child:Align(
										alignment:Alignment.bottomLeft,
										child:FittedBox(
											fit:BoxFit.scaleDown,
											child:Text('Quantidade de Peças'),
										),
									)
								),
								Expanded(
									flex:1,
									child:editable(
										controller:pecas_controller,
										numeric:true,
									),
								),
								Expanded(
									flex:1,
									child:Align(
										alignment:Alignment.bottomLeft,
										child:FittedBox(
											fit:BoxFit.scaleDown,
											child:Text('Quantidade de Horas'),
										),
									)
								),
								Expanded(
									flex:1,
									child:editable(
										controller:horas_controller,
										numeric:true,
									),
								),
							]
						),
					),
				),
			),
		);
	}

}