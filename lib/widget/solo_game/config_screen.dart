import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/main/main_bloc.dart';
import 'package:quiz_app/cubit/category/category_cubit.dart';
import 'package:quiz_app/cubit/difficulty/difficulty_cubit.dart';
import 'package:quiz_app/cubit/number_of_questions/number_of_questions_cubit.dart';
import 'package:quiz_app/cubit/request_questions/request_questions_cubit.dart';
import 'package:quiz_app/globals/solo_play_config_info.dart';

// ignore: must_be_immutable
class ConfigScreen extends StatelessWidget {
  late String category;
  late String difficulty;
  late int limit;

  ConfigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'DIFFICULTY',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    BlocBuilder<DifficultyCubit, DifficultyState>(
                        builder: (_, state) {
                      difficulty = difficultyMap[state.name] ?? '';
                      return SizedBox(
                        width: 200,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.purple,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 3,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                          value: state.name,
                          items: mapToDropdownMenuItemList(difficultyMap),
                          onChanged: (obj) {
                            context
                                .read<DifficultyCubit>()
                                .changeDifficulty(obj);
                          },
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'CATEGORY',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (_, state) {
                        category = categoryMap[state.name] ?? '';
                        return SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.purple,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 3,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            value: state.name,
                            items: mapToDropdownMenuItemList(categoryMap),
                            onChanged: (obj) {
                              context.read<CategoryCubit>().changeCategory(obj);
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'NUMBER OF QUESTIONS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    BlocBuilder<NumberOfQuestionsCubit, NumberOfQuestionsState>(
                      builder: (_, state) {
                        limit = state.number;
                        return SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.purple,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 3,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            value: state.number,
                            items: numberOfQuestionsList
                                .map(
                                  (e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text(e.toString()),
                                  ),
                                )
                                .toList(),
                            onChanged: (obj) {
                              limit = obj ?? 0;
                              context
                                  .read<NumberOfQuestionsCubit>()
                                  .changeNumberOfQuestions(obj ?? 0);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      icon: const Icon(Icons.start),
                      heroTag: null,
                      onPressed: () {
                        context
                            .read<RequestQuestionsCubit>()
                            .getQuestions(category, difficulty, limit);
                      },
                      label: const Text('Start'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FloatingActionButton.extended(
                      icon: const Icon(Icons.close),
                      heroTag: null,
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<MainBloc>().add(FinishSoloGameplayEvent());
                      },
                      label: const Text('Back to Menu'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> mapToDropdownMenuItemList(
      Map<String, String> map) {
    List<DropdownMenuItem<String>> list = [];
    map.forEach((key, value) {
      list.add(DropdownMenuItem<String>(
        value: key,
        child: Text(key),
      ));
    });
    return list;
  }
}
