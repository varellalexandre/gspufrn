import 'package:scoped_model/scoped_model.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/models/group.dart';


class Resposta extends Model{
	Group disponiveis;
	Group all_jobs;
	List<Group> groups;

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