import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/shared/cubit/quiz_cubit/quiz_states.dart';

import '../../../models/quiz_model.dart';
import '../../../modules/quiz_screen/qusestions-answer.dart';

class QuizCubit extends Cubit<QuizStates> {
  QuizCubit() : super(HomeInitialState());

  // ignore: type_annotate_public_apis
  static QuizCubit get(context) => BlocProvider.of(context);

  final List<QuizModel> quizList = [];
  final List<int> quizScore = [];
  final PageController controllerPage = PageController();
  int totalScore = 0;

  // calculate total score
  void calcScore() {
    for (final element in quizScore) {
      totalScore = totalScore + element;
    }
    emit(CalcScoreState());
  }

  // fetch questions from json
  Future<void> fetchQuestions() async {
    quizList.clear();
    quizScore.clear();
    for (final ele in questionsJson) {
      quizList.add(QuizModel.fromJson(ele));
      quizScore.add(0);
    }
    emit(FetchQuestionState());
  }

  // add score to quizScore
  void addScoreAfterNext(int scoreInQ, int quizIndex) {
    quizScore[quizIndex] = scoreInQ;
    emit(AddScoreState());
  }

  // next question
  void nextQuiz(int quizIndex) {
    controllerPage.animateToPage(
      quizIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // back question
  void backQuiz(int quizIndex) {
    controllerPage.animateToPage(
      quizIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // to change selected answer
  void selectAnswer(int index, int answersIndex) {
    quizList[answersIndex].selectedAnswer = index;

    emit(SelectAnswerState());
  }
}
