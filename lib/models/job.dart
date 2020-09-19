import 'package:scoped_model/scoped_model.dart';

class Job extends Model{
	int id_atv;
	num tempo;
	num x;
	num y;
	String nome;
	List<int> predecessores;

	void updateNome(String nome){
		this.nome = nome;
	}

	void updateTempo(num tempo){
		this.tempo = tempo;
	}

	void addPredecessor(int predecessor){
		this.predecessores.add(predecessor);
	}

	Job({
		this.tempo,
		this.x,
		this.y,
		this.predecessores,
		this.nome
	});
}

class Linha extends Model{
	num takt_time;
	num eficiencia;
	num horas_disp;
	num qtd_pecas;
	List<Job> atividades;

	Linha({this.atividades});

	void addJob(Job job){
		this.atividades.add(job);
	}

	void calculateComsoal(){
		//this.takt_time = this.horas_disp/this.qtd_pecas;
		List<Job> a_list = List<Job>.from(atividades);
		List<Job> b_list = List<Job>();
		for(var count in a_list){
			//print(count);
		}
	}

}

Linha get_example(){
	List<Job> atividades = [
		Job(
			x:0,
			y:0,
			nome:'atividade 1',
			predecessores:[],
			tempo:0.05
		),
		Job(
			x:0,
			y:0,
			nome:'atividade 2',
			predecessores:[0],
			tempo:0.03
		),
		Job(
			x:0,
			y:0,
			nome:'atividade 3',
			predecessores:[0],
			tempo:0.04
		),
		Job(
			x:0,
			y:0,
			nome:'atividade 4',
			predecessores:[1,2],
			tempo:0.05
		),
		Job(
			x:0,
			y:0,
			nome:'atividade 5',
			predecessores:[3],
			tempo:0.01
		),
		Job(
			x:0,
			y:0,
			nome:'atividade 6',
			predecessores:[3],
			tempo:0.04
		),
		Job(
			x:0,
			y:0,
			nome:'atividade 7',
			predecessores:[3],
			tempo:0.05
		),
		Job(
			x:0,
			y:0,
			nome:'atividade 8',
			predecessores:[5,1,1,2,3,4,5,6,76,3,7,6,5],
			tempo:0.04
		),
		Job(
			x:0,
			y:0,
			nome:'atividade 9',
			predecessores:[4,6,7],
			tempo:0.06
		),
	];
	Linha linha = Linha(atividades:atividades);
	return linha;
}