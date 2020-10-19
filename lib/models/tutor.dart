import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Tutor extends Model{
	String linkedin;
	String nome;
	String descricao;
	String email;
	String linkfoto;

	Tutor({
		this.linkedin,
		this.nome,
		this.descricao,
		this.email,
		this.linkfoto,
	});

	void updateTutor(Map tutor){
		this.linkedin = tutor['linkedin'];
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
							leading:pic,
							title:Text(this.nome)
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
			linkedin:tutoria['orientadora']['linkedin'],
			nome:tutoria['orientadora']['nome'],
			email:tutoria['orientadora']['email'],
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
					return ListView(
						children:[
							Container(
								padding:EdgeInsets.all(20),
								child:model.orientadora.widgetTutor(),
							),
							Container(
								padding:EdgeInsets.all(20),
								child:model.orientadora.widgetTutor(),
							),
							Container(
								padding:EdgeInsets.all(20),
								child:model.orientadora.widgetTutor(),
							),
							Container(
								padding:EdgeInsets.all(20),
								child:model.orientadora.widgetTutor(),
							)
						]
					);
				}
			)
		);
	}

}
