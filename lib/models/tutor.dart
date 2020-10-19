import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class Tutor extends Model{
	String contato;
	String nome;
	String descricao;
	String email;
	String linkfoto;

	Tutor({
		this.contato,
		this.nome,
		this.descricao,
		this.email,
		this.linkfoto,
	});

	void updateTutor(Map tutor){
		this.contato = tutor['contato'];
		this.nome = tutor['nome'];
		this.descricao = tutor['descricao'];
		this.email = tutor['email'];
		this.linkfoto = tutor['linkfoto'];
	}
	Widget widgetTutor(){
		return ScopedModel<Tutor>(
			model:this,
			child:ScopedModelDescendant<Tutor>(
				builder:(context,child,model){
					Widget pic;
					if(this.linkfoto != null){
						pic = Image.network(this.linkfoto);
					}else{
						pic = FaIcon(FontAwesomeIcons.user);
					}
					return Card(
						child:ListTile(
							contentPadding:EdgeInsets.all(20),
							leading:pic,
							title:Text(this.nome),
							subtitle:Container(
								child:Column(
									crossAxisAlignment:CrossAxisAlignment.start,
									children:[
										FittedBox(
											fit:BoxFit.scaleDown,
											alignment:Alignment.centerLeft,
											child:Text(this.email),
										),
										FittedBox(
											fit:BoxFit.scaleDown,
											alignment:Alignment.centerLeft,
											child:Text(this.descricao),
										),
										FittedBox(
											fit:BoxFit.scaleDown,
											alignment:Alignment.bottomLeft,
											child:IconButton(
												icon:FaIcon(FontAwesomeIcons.envelope),
												onPressed:()async {
													if(await canLaunch(this.contato)){
														await launch(this.contato);
													}else{
														throw 'Não foi possível abrir a página';
													}
												}
											)
										),
									]
								)
							)
						)
					);
				}
			)
		);
	}

}

class Tutoria extends Model{
	List <Tutor> tutores;
	String periodo;
	Tutor orientadora;

	Tutoria();

	void updateOrientadora(Tutor orientadora){
		this.orientadora = orientadora;
		notifyListeners();
	}

	void addTutor(Tutor tutor){
		this.tutores.add(tutor);
		notifyListeners();
	}

	void updateTutoria(Map tutoria){
		this.orientadora = Tutor(
			contato:tutoria['orientadora']['contato'],
			nome:tutoria['orientadora']['nome'],
			email:tutoria['orientadora']['email'],
			descricao:'Professora Orientadora',
			linkfoto:tutoria['orientadora']['linkfoto'],
		);
		notifyListeners();
	}

	Widget widgettutoria(){
		return ScopedModel<Tutoria>(
			model:this,
			child:ScopedModelDescendant<Tutoria>(
				builder:(context,child,model){
					if(this.orientadora == null){
						return Container();
					}
					return Row(
						children:[
							Expanded(
								flex:3,
								child:Container(),
							),
							Expanded(
								flex:10,
								child:ListView(
						children:[
							Container(
								child:model.orientadora.widgetTutor(),
							),
							Container(
								child:model.orientadora.widgetTutor(),
							),
							Container(
								child:model.orientadora.widgetTutor(),
							),
							Container(
								child:model.orientadora.widgetTutor(),
							)
						]
								)
							),
							Expanded(
								flex:3,
								child:Container()
							)
						]
					);
				}
			)
		);
	}

}
