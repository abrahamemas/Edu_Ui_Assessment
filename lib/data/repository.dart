import '../domain/models.dart';
import '../domain/usecases.dart';

abstract class SubjectsRepository {
  Future<List<SubjectModel>> getSubjects();
}

class SubjectsRepositoryImpl implements SubjectsRepository {
  final LoadSubjectsUseCase loader;
  SubjectsRepositoryImpl(this.loader);

  @override
  Future<List<SubjectModel>> getSubjects() => loader.execute();
}




