import 'package:scoped_model/scoped_model.dart';
import 'package:gspufrn/models/job.dart';
import 'package:gspufrn/models/group.dart';


class Resposta extends Model{
	Group disponiveis;
	List<Group> groups;

	Resposta({List<Job> jobs}){
		groups = List<Group>();
		disponiveis = Group();
		jobs.forEach(
			(job){
				this.disponiveis.addJob(job);
			}
		);
	}
}