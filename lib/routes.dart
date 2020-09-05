import 'package:flutter/material.dart';
import 'package:gspufrn/views/comsoal/app.dart';

final _routes = {
	'/home':(context)=>SafeArea(child:Comsoal())
};

get routes => _routes;