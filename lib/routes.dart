import 'package:flutter/material.dart';
import 'package:gspufrn/views/comsoal/app.dart';
import 'package:gspufrn/views/aboutus/app.dart';

final _routes = {
	'/comsoal':(context)=>SafeArea(child:Comsoal()),
	'/sobre':(context)=>SafeArea(child:Aboutus())
};

get routes => _routes;
