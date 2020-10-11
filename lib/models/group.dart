import 'package:scoped_model/scoped_model.dart';
import 'package:gspufrn/models/job.dart';


class Group extends Model{
	List<Job> jobs;

	Group(){
		this.jobs = List<Job>();
	}
	void addJob(Job job){
		this.jobs.add(job);
		notifyListeners();
	}
	void removeJob(Job job){
		this.jobs.remove(job);
		notifyListeners();
	}

	List<String> group_elements(){
		List<String> elements = List.generate(this.jobs.length,(index){
			return jobs[index].id_atv;
		});
		return elements;
	}

	num totalTime(){
		num total = 0;
		jobs.forEach((job){
			total = total + job.tempo;
		});
		return num.parse(total.toStringAsFixed(2));
	}
}