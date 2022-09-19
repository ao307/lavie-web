import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/quiz_screen/quiz_widgets/home_background.dart';
import 'package:lavie_web/modules/quiz_screen/quiz_widgets/quiz_item.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/cubit/quiz_cubit/quiz_cubit.dart';

import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/components/widgets.dart';
import '../../shared/cubit/quiz_cubit/quiz_states.dart';
import '../auth_screens/auth_widgets/auth_button.dart';
import '../home_screen/home_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizCubit = QuizCubit.get(context);
    return FutureBuilder(
      future: quizCubit.fetchQuestions(),
      builder: (context, snapshot) {
        return BlocConsumer<QuizCubit, QuizStates>(
          listener: (context, state) {},
          builder: (BuildContext context, Object? state) {
            final quizList = quizCubit.quizList;
            return BaseWidget(
              child: HomeBackground(
                child: PageView(
                  controller: quizCubit.controllerPage,
                  children: List.generate(
                    quizList.length,
                    (index) => Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenW(context) * .2,
                          ),
                          child: Column(
                            children: [
                              QuizItem(
                                questionNumber: index + 1,
                                totalQuestions: quizList.length,
                                quizModel: quizList[index],
                                quizIndex: index,
                              ),
                              // next && back
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  top: paddingMedium,
                                  start: screenW(context) * .22,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ReuseOutLinedButton(
                                        onPressed: () {
                                          quizCubit.backQuiz(index - 1);
                                        },
                                        txt: 'back',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: paddingMedium,
                                    ),
                                    Expanded(
                                      child: AuthButton(
                                        text: index == (quizList.length - 1)
                                            ? 'finish'
                                            : "next",
                                        onPressed: () {
                                          quizCubit.nextQuiz(index + 1);
                                          if (index == (quizList.length - 1)) {
                                            quizCubit.calcScore();
                                            navigateAndFinish(
                                              context: context,
                                              widget: const HomeScreen(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
