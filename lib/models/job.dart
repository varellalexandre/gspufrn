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
		Map aux_map = Map();
		for(String key in this.atividades.keys){
			if(!aux_map.keys.contains(key)){
				aux_map[key] = Map();
				aux_map[key]['next'] = List();
				aux_map[key]['id'] = this.atividades[key].nome;
			}
		}
		for(String key in this.dependencies.keys){
			for(String dependent in this.dependencies[key]){
				aux_map[dependent]['next'].add(
					this.atividades[key].nome
				);
			}
		}
		List depCont = List();
		aux_map.forEach((key,value)=>depCont.add(value));
		return depCont;
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

Linha exemplo_sandra(){
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
Linha exemplo_arcus(){
	List<Job> atividades = [
		Job(
			nome:'Atividade a',
			tempo:3
		),
		Job(
			nome:'Atividade b',
			tempo:6
		),
		Job(
			nome:'Atividade c',
			tempo:7
		),
		Job(
			nome:'Atividade d',
			tempo:5
		),
		Job(
			nome:'Atividade e',
			tempo:2
		),
		Job(
			nome:'Atividade f',
			tempo:4
		),
		Job(
			nome:'Atividade g',
			tempo:5
		),
		Job(
			nome:'Atividade h',
			tempo:5
		),
	];

	List dependencies = [
		['Atividade a','Atividade b'],
		['Atividade a','Atividade c'],
		['Atividade a','Atividade d'],
		['Atividade a','Atividade e'],
		['Atividade b','Atividade f'],
		['Atividade c','Atividade f'],
		['Atividade c','Atividade g'],
		['Atividade d','Atividade g'],
		['Atividade f','Atividade h'],
		['Atividade g','Atividade h'],
	];

	Linha linha = Linha(
		atividades,
		horas_disp:1000,
		qtd_pecas:100,
	);

	for(List dependence in dependencies){
		linha.addDependence(dependence[0],dependence[1]);
	}
	return linha;
}

double exp_random(int scale){
	Random rnd = Random();
	double x = scale*rnd.nextDouble();
	return (1/scale)*exp(-x/scale);
}

Linha random_line(){
	Random rnd = Random();
	double horas_disp = rnd.nextInt(720)*rnd.nextDouble();
	int qtd_pecas = rnd.nextInt(10000);
	double takt = horas_disp/qtd_pecas;
	int qtd_atvt = 5+rnd.nextInt(10);
	List<Job> atividades = List();
 	Map dependencies = Map();
	for(int count = 0; count <= qtd_atvt; count++){
		double rnd_time = takt*(1-exp_random(1));
		dependencies['Atividade '+(count+1).toString()] = List();
		atividades.add(
			Job(
				nome:'Atividade '+(count+1).toString(),
				tempo:rnd_time,
			)
		);
		int qtd_anteriores = 0;
		if(count > 0){
			int range = ((count)*exp_random(1)).round();
			qtd_anteriores = rnd.nextInt(range+1)+1;
			for(int ant = 0; ant<=qtd_anteriores; ant++){
				int depends = rnd.nextInt(count);
				while(!
					(
						dependencies['Atividade '+(count+1).toString()].contains(depends)
					)
				){
					dependencies['Atividade '+(count+1).toString()].add(depends);
				}
			}
		}
	}
	Linha generated_line = Linha(
		atividades,
		horas_disp:horas_disp,
		qtd_pecas:qtd_pecas,
	);
	for(int count = dependencies.keys.length-1; count>=0; count--){
		String actual = dependencies.keys.elementAt(count);
		for(int dep in dependencies[actual]){
			bool has_another = false;
			for(int contained in dependencies[actual]){
				String dep_name = 'Atividade '+(contained+1).toString();
				if(dependencies[dep_name].contains(dep)){
					has_another = true;
				}
			}
			if(!has_another){
				String dep_name = 'Atividade '+(dep+1).toString();
				generated_line.addDependence(dep_name,actual);
			}
		}
	}
	return generated_line;
}

Linha get_example(){
	List funcs = [
		random_line,
		exemplo_arcus,
		exemplo_sandra
	];
	Random rnd = Random();
	int pos = rnd.nextInt(funcs.length);
	return funcs[pos]();
}
