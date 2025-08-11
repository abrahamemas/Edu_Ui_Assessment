import 'package:edu_ui_assessment/data/repository.dart';
import 'package:edu_ui_assessment/domain/usecases.dart';
import 'package:edu_ui_assessment/state/app_state.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    final loadSubjects = LoadSubjectsFromAssets('assets/data/subjects_quiz_data.json');
    final repository = SubjectsRepositoryImpl(loadSubjects);
    final subjects = await repository.getSubjects();
    
    AppState.I.setSubjects(subjects);
  } catch (e) {
    rethrow;
  }
}


