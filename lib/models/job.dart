import 'package:scoped_model/scoped_model.dart';
import 'package:crypto/crypto.dart';
import 'package:gspufrn/models/group.dart';
import 'package:gspufrn/models/resposta.dart';
import 'dart:core';
import 'dart:math';
import 'dart:convert';

class Job extends Model{
	String id_atv;
	num tempo;
	String nome;
	Function delete;

	void updateNome(String nome){
		this.nome = nome;
		notifyListeners();
	}

	void updateTempo(num tempo){
		this.tempo = tempo;
		notifyListeners();
	}

	Job({
		this.tempo,
		this.nome
	}){
		DateTime now = DateTime.now();
		var bytes = utf8.encode("${now}-${nome}");
		this.id_atv = "${md5.convert(bytes)}"; 
	}
}

class Dependencies extends Model{
	List dependencies = List();

	updateDepedencies(List dep){
		this.dependencies = dep;
		notifyListeners();
	}


}



class Linha extends Model{
	num takt_time;
	num eficiencia;
	num horas_disp;
	num qtd_pecas;
	Map atividades;
	Map dependencies;

	Linha(List atividades,{this.horas_disp,this.qtd_pecas}){
		this.atividades = Map();
		for(Job atividade in atividades){
			atividade.delete = deleteJob;
			this.atividades[atividade.id_atv] = atividade;
		}
	}
	List<String> depends_on(String id_atv){
		List<String> elements = List<String>();
		if(dependencies.keys.contains(id_atv)){
			for(String element in dependencies[id_atv]){
				elements.add(atividades[element].nome);
			}
		}
		return elements;
	}

	void deleteJob(String job){
		if(this.atividades.keys.contains(job)){
			this.atividades.remove(job);
			if(this.dependencies.keys.contains(job)){
				this.dependencies.remove(job);
			}
			for(String atv in this.dependencies.keys){
				if(this.dependencies[atv].contains(job)){
					this.dependencies[atv].remove(job);
				}
			}
		}
		notifyListeners();
	}

	void updateHoras(num horas){
		this.horas_disp = horas;
	}

	void updateQtdPecas(num pecas){
		this.qtd_pecas = pecas;
	}

	void addJob(Job job){
		job.delete = deleteJob;
		this.atividades[job.id_atv] = job;
		notifyListeners();
	}

	bool addDependence(String origin,String dependent){
		String origin_key;
		String dependent_key;
		if(origin == dependent){
			return false;
		}
		for(String atividade in this.atividades.keys){
			if(this.atividades[atividade].nome == dependent){
				dependent_key = this.atividades[atividade].id_atv;				
			}
			if(this.atividades[atividade].nome == origin){
				origin_key = this.atividades[atividade].id_atv;	
			}
		}
		if(origin == null || dependent == null){
			return false;
		}
		if(this.dependencies == null){
			this.dependencies = Map();
			this.dependencies[dependent_key] = List();
		}else if(!this.dependencies.keys.contains(dependent_key)){
			this.dependencies[dependent_key] = List();
		}
		this.dependencies[dependent_key].add(origin_key);
		return true;
	}


	List orderDependencies(){
		List depList = List();
		List b = List();
		Map<String,List> a = Map();
		List<Job> disponiveis = List();
		this.atividades.keys.forEach((id){
			if(this.dependencies.keys.contains(id)){
				a[id] = List.from(this.dependencies[id]);
			}else{
				b.add(id);
			}
		});

		while(a.keys.length > 0){
			for(String b_id in b){
				for(String a_id in a.keys){
					if(a[a_id].contains(b_id)){
						a[a_id].remove(b_id);
					}
				}
			}
			depList.add(List.from(b));
			b = List();
			for(String a_id in a.keys){
				if(a[a_id].length == 0){
					b.add(a_id);
				}
			}
			for(String b_id in b){
				a.remove(b_id);
			}
		}

		return depList;
	}

	Resposta calculateComsoal(){
		if(this.qtd_pecas == 0 || this.qtd_pecas == null){
			return null;
		}
		this.takt_time = this.horas_disp/this.qtd_pecas;
		num _numero_postos = 0;
		this.atividades.keys.forEach((id){
			_numero_postos = _numero_postos + this.atividades[id].tempo;
		});
		_numero_postos = _numero_postos / this.takt_time;
		int numero_postos = _numero_postos.ceil();
		Resposta retorno = null;
		for(int count = 0;count < 1000;count++){
			List<Job> disponiveis = List();
			Map<String,List> a = Map();
			List<String> b = List();

			this.atividades.keys.forEach((id){
				disponiveis.add(this.atividades[id]);
				if(this.dependencies.keys.contains(id)){
					a[id] = List.from(this.dependencies[id]);
				}else{
					b.add(id);
				}
			});
			
			Resposta resolucao = Resposta(jobs:disponiveis);
			resolucao.groups.add(Group());
			
			while(a.keys.length > 0){
				while(b.length > 0){
					Random new_rand = Random();
					int random_job = new_rand.nextInt(b.length);
					Job actual = this.atividades[b[random_job]];
					Group estagio = resolucao.groups[resolucao.groups.length-1];
					if(actual.tempo > this.takt_time){
						Group new_group = Group();
						new_group.addJob(actual);
						resolucao.groups.add(new_group);
					}else if((estagio.totalTime()+actual.tempo) > this.takt_time){
						Group new_group = Group();
						new_group.addJob(actual);
						resolucao.groups.add(new_group);					
					}else{
						estagio.addJob(actual);
					}
					a.keys.forEach((key){
						if(a[key].contains(b[random_job])){
							a[key].remove(b[random_job]);
						}
					});
					a.remove(b[random_job]);
					b.removeAt(random_job);
				}
				a.keys.forEach((key){
					if(a[key].length == 0){
						b.add(key);
					}
				});
			}
			if(retorno == null){
				retorno = resolucao;
			}else if(
				(retorno.eff(this.takt_time) <= resolucao.eff(this.takt_time)) 
			){
				retorno = resolucao;
			}

		}
		return retorno;


	}

}

Linha get_example(){
	List<Job> atividades = [
		Job(
			nome:'Atividade 1',
			tempo:0.05
		),
		Job(
			nome:'Atividade 2',
			tempo:0.03
		),
		Job(
			nome:'Atividade 3',
			tempo:0.04
		),
		Job(
			nome:'Atividade 4',
			tempo:0.05
		),
		Job(
			nome:'Atividade 5',
			tempo:0.01
		),
		Job(
			nome:'Atividade 6',
			tempo:0.04
		),
		Job(
			nome:'Atividade 7',
			tempo:0.05
		),
		Job(
			nome:'Atividade 8',
			tempo:0.04
		),
		Job(
			nome:'Atividade 9',
			tempo:0.06
		),
	];

	List dependencies = [
		['Atividade 1','Atividade 2'],
		['Atividade 1','Atividade 3'],
		['Atividade 2','Atividade 4'],
		['Atividade 3','Atividade 4'],
		['Atividade 4','Atividade 5'],
		['Atividade 4','Atividade 7'],
		['Atividade 4','Atividade 6'],
		['Atividade 6','Atividade 8'],
		['Atividade 7','Atividade 9'],
		['Atividade 5','Atividade 9'],
		['Atividade 8','Atividade 9'],
	];

	Linha linha = Linha(
		atividades,
		horas_disp:40,
		qtd_pecas:285,
	);

	for(List dependence in dependencies){
		linha.addDependence(dependence[0],dependence[1]);
	}
	return linha;
}