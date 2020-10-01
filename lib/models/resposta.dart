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

	bool isvalid(num takt){
		bool valid = true;
		groups.forEach((group){
			
			if(group.jobs.length == 0){
				valid =valid &&  false;
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
		comparacao = comparacao & (comp.loss(takt) >= this.loss(takt));
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