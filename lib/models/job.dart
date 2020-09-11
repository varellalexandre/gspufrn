import 'package:scoped_model/scoped_model.dart';

class Job extends Model{
	num tempo;
	num x;
	num y;
	String nome;
	Job({
		this.tempo,
		this.x,
		this.y,
		this.nome
	});
}