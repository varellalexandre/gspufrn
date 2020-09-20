import 'package:flutter/material.dart';

class list_controller extends StatelessWidget{
	ScrollController controller;

	list_controller({this.controller});


	@override
	Widget build(BuildContext context){
		return Row(
			children:[
				Expanded(
					flex:1,
					child:IconButton(
						icon:Icon(Icons.arrow_left),
						onPressed:(){
							ScrollPosition pos = controller.position;
							if (controller.offset > pos.minScrollExtent){
								num where_to_go =controller.offset-100.0;
								if (where_to_go > pos.minScrollExtent){
									controller.animateTo(
										where_to_go,
										duration:Duration(milliseconds:200),
										curve: Curves.easeIn,

									);
								}else{
									controller.animateTo(
										pos.minScrollExtent,
										duration:Duration(milliseconds:200),
										curve: Curves.easeIn,

									);
								}
							}
							
						}
					),
				),
				Expanded(
					flex:3,
					child:Container(
					),
				),
				Expanded(
					flex:1,
					child:IconButton(
						icon:Icon(Icons.arrow_right),
						onPressed:(){
							ScrollPosition pos = controller.position;
							if (controller.offset < pos.maxScrollExtent){
								num where_to_go =controller.offset+100.0;
								if (where_to_go < pos.maxScrollExtent){
									controller.animateTo(
										where_to_go,
										duration:Duration(milliseconds:200),
										curve: Curves.easeIn,

									);
								}else{
									controller.animateTo(
										pos.maxScrollExtent,
										duration:Duration(milliseconds:200),
										curve: Curves.easeIn,

									);
								}
							}
							
						}
					),
				),
			]
		);
	}

}