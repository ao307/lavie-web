import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/auth_screens/auth_widgets/auth_button.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/components/widgets.dart';

import '../../../models/quiz_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/cubit/quiz_cubit/quiz_cubit.dart';
import '../../../shared/cubit/quiz_cubit/quiz_states.dart';
import '../../../shared/themes/colors.dart';

class QuizItem extends StatelessWidget {
  const QuizItem({
    Key? key,
    this.quizModel,
    this.onTap,
    this.totalQuestions,
    this.questionNumber,
    required this.quizIndex,
  }) : super(key: key);
  final QuizModel? quizModel;
  final GestureTapCallback? onTap;
  final int? questionNumber;
  final int? totalQuestions;
  final int? quizIndex;

  @override
  Widget build(BuildContext context) {
    final quizCubit = QuizCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // question title
        Row(
          children: [
            Text(
              'question'.tr().toTitleCase(),
              style: const TextStyle(
                fontSize: textSizeLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: paddingMedium,
            ),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: textSizeLarge,
                  color: MyColors.cPrimary,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${questionNumber ?? 0}',
                  ),
                  TextSpan(
                    text: '/${totalQuestions ?? 0}',
                    style: const TextStyle(
                      fontSize: textSizeMedium,
                      color: MyColors.cTextSubtitleLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: paddingSmall),
        // question ?
        Text(
          (quizModel!.questionText ?? "no question")
              .toCapitalized(),
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: textSizeMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
        // answer
        Column(
          children: List.generate(
            quizModel!.answers!.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: paddingMedium,
              ),
              child: InkWell(
                onTap: () {
                  quizCubit.selectAnswer(index, quizIndex!);
                  quizCubit.addScoreAfterNext(
                    quizModel!.answers![index].score!,
                    quizIndex!,
                  );
                  //printFullText(index.toString());
                },
                borderRadius: BorderRadius.circular(borderRadiusMedium),
                child: Container(
                  padding: const EdgeInsetsDirectional.all(
                    paddingMedium,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadiusMedium),
                    border: Border.all(
                      width: 1.3,
                      color: MyColors.cPrimary,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${quizModel!.answers![index].text}',
                          style: const TextStyle(
                            fontSize: textSizeMedium,
                            fontWeight: FontWeight.bold,
                            height: 1.38,
                          ),
                        ),
                      ),
                      if (quizModel!.selectedAnswer != index)
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2.0,
                              color: MyColors.cPrimary,
                            ),
                          ),
                        )
                      else // Group: Group 1234
                        Container(
                          alignment: Alignment.center,
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2.0,
                              color: MyColors.cPrimary,
                            ),
                          ),
                          child: Container(
                            width: 22.0,
                            height: 22.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.cPrimary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
