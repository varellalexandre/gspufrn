import 'package:scoped_model/scoped_model.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/models/group.dart';


class Resposta extends Model{
	Group disponiveis;
	Group all_jobs;
	List<Group> groups;

	num eff(num takt){
		num tempo_total = 0;
		groups.forEach((group){
			tempo_total = tempo_total + group.totalTime();
		});
		return (tempo_total/(takt*groups.length));
	}

	bool isTimeValid(num takt){
		bool valid = true;
		groups.forEach((group){
			if(group.jobs.length == 0){
				valid = valid &&  false;
			}
			else if(group.jobs.length == 1 && group.totalTime() > takt){
				valid = valid && true;
			}else if(group.totalTime()<=takt){
				valid = valid && true;
			}else{
				valid = valid && false;
			}
		});
		return valid;
	}

	int get_group_pos(String id_atv){
		int count = 0;
		int group_id = null;
		groups.forEach((group){
			if(group.group_elements().contains(id_atv)){
				group_id = count;
				return;
			}
			count = count + 1;
		});
		return group_id;
	}

	bool isDependenciesValid(Linha sequencia){
		int count = 0;
		bool validacao = true;
		groups.forEach((group){
			for(Job atv in group.jobs){
				if(sequencia.dependencies.keys.contains(atv.id_atv)){
					for(String id_atv in sequencia.dependencies[atv.id_atv]){
						int el_pos = this.get_group_pos(id_atv);
						if(el_pos == null){
							validacao = false;
							return;
						}else if(el_pos > count){
							validacao = false;
							return;
						}
					}
				}
			}
			count = count + 1;
		});

		return validacao;
	}

	num loss(num takt){
		num perdas = 0;
		groups.forEach((group){
			perdas = perdas + (takt-group.totalTime()).abs();
		});
		return perdas/(takt*groups.length);
	}

	bool compare(Resposta comp, num takt){
		bool comparacao = true;
		comparacao = comparacao & (comp.eff(takt) >= this.eff(takt));
		comparacao = comparacao & (comp.loss(takt) <= this.loss(takt));
		return comparacao;
	}

	Resposta({List<Job> jobs}){
		this.groups = List<Group>();
		this.disponiveis = Group();
		this.all_jobs = Group();
		jobs.forEach(
			(job){
				this.disponiveis.addJob(job);
				this.all_jobs.addJob(job);
			}
		);
	}
}