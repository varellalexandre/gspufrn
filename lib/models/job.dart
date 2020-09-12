import 'package:scoped_model/scoped_model.dart';

class Job extends Model{
	num tempo;
	num x;
	num y;
	String nome;

	void updateNome(String nome){
		this.nome = nome;
	}

	void updateTempo(num tempo){
		this.tempo = tempo;
	}

	Job({
		this.tempo,
		this.x,
		this.y,
		this.nome
	});
}