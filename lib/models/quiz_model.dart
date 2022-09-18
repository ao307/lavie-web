import 'dart:convert';
/// questionText : "Q1. Who created Flutter?"
/// selected_answer : 0
/// answers : [{"text":"Facebook","score":-2},{"text":"Adobe","score":-2},{"text":"Google","score":10},{"text":"Microsoft","score":-2},null]

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));
String quizModelToJson(QuizModel data) => json.encode(data.toJson());
class QuizModel {
  QuizModel({
      this.questionText, 
      this.selectedAnswer, 
      this.answers,});

  QuizModel.fromJson(dynamic json) {
    questionText = json['questionText'];
    selectedAnswer = json['selected_answer'];
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers?.add(Answers.fromJson(v));
      });
    }
  }
  String? questionText;
  int? selectedAnswer;
  List<Answers>? answers;
QuizModel copyWith({  String? questionText,
  int? selectedAnswer,
  List<Answers>? answers,
}) => QuizModel(  questionText: questionText ?? this.questionText,
  selectedAnswer: selectedAnswer ?? this.selectedAnswer,
  answers: answers ?? this.answers,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionText'] = questionText;
    map['selected_answer'] = selectedAnswer;
    if (answers != null) {
      map['answers'] = answers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// text : "Facebook"
/// score : -2

Answers answersFromJson(String str) => Answers.fromJson(json.decode(str));
String answersToJson(Answers data) => json.encode(data.toJson());
class Answers {
  Answers({
      this.text, 
      this.score,});

  Answers.fromJson(dynamic json) {
    text = json['text'];
    score = json['score'];
  }
  String? text;
  int? score;
Answers copyWith({  String? text,
  int? score,
}) => Answers(  text: text ?? this.text,
  score: score ?? this.score,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['score'] = score;
    return map;
  }

}