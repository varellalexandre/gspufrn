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
}