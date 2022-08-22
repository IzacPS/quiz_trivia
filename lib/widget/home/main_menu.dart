import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/ad/ad_helper.dart';
import 'package:quiz_app/bloc/countdown_question_timer/countdown_question_timer_bloc.dart';
import 'package:quiz_app/bloc/main/main_bloc.dart';
import 'package:quiz_app/bloc/question/question_bloc.dart';
import 'package:quiz_app/cubit/category/category_cubit.dart';
import 'package:quiz_app/cubit/countdown/countdown_cubit.dart';
import 'package:quiz_app/cubit/difficulty/difficulty_cubit.dart';
import 'package:quiz_app/cubit/gameplay_timeline/gameplay_timeline_cubit.dart';
import 'package:quiz_app/cubit/number_of_questions/number_of_questions_cubit.dart';
import 'package:quiz_app/cubit/request_questions/request_questions_cubit.dart';
import 'package:quiz_app/widget/about/about_screen.dart';
import 'package:quiz_app/widget/solo_game/solo_game_page.dart';
import 'package:toast/toast.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 1,
              ),
              SizedBox(
                width: 256,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FloatingActionButton.extended(
                      heroTag: null,
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        context.read<RequestQuestionsCubit>().start();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MultiBlocProvider(providers: [
                                    BlocProvider<RequestQuestionsCubit>.value(
                                      value:
                                          context.read<RequestQuestionsCubit>(),
                                    ),
                                    BlocProvider<CountdownCubit>.value(
                                      value: context.read<CountdownCubit>(),
                                    ),
                                    BlocProvider<MainBloc>.value(
                                      value: context.read<MainBloc>(),
                                    ),
                                    BlocProvider<GameplayTimelineCubit>.value(
                                      value:
                                          context.read<GameplayTimelineCubit>(),
                                    ),
                                    BlocProvider<DifficultyCubit>.value(
                                      value: context.read<DifficultyCubit>(),
                                    ),
                                    BlocProvider<CategoryCubit>.value(
                                      value: context.read<CategoryCubit>(),
                                    ),
                                    BlocProvider<NumberOfQuestionsCubit>.value(
                                      value: context
                                          .read<NumberOfQuestionsCubit>(),
                                    ),
                                    BlocProvider<
                                        CountdownQuestionTimerBloc>.value(
                                      value: context
                                          .read<CountdownQuestionTimerBloc>(),
                                    ),
                                    BlocProvider<QuestionBloc>(
                                      create: (_) => QuestionBloc(),
                                    ),
                                  ], child: SoloGamePage())),
                        );
                      },
                      label: const Text('Play Solo'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.extended(
                      heroTag: null,
                      icon: const Icon(Icons.people),
                      onPressed: () {
                        Toast.show('Not Yet Implemented!',
                            duration: Toast.lengthShort, gravity: Toast.bottom);
                      },
                      label: const Text('Play With Others'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.extended(
                      heroTag: null,
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Toast.show('Not Yet Implemented!',
                            duration: Toast.lengthShort, gravity: Toast.bottom);
                      },
                      label: const Text('Configuration'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.extended(
                      heroTag: null,
                      icon: const Icon(Icons.info),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AboutScreen()),
                        );
                      },
                      label: const Text('About'),
                    ),
                  ],
                ),
              ),
              if (AdHelper.mainMenuBannerAd != null &&
                  AdHelper.mainMenuBannerAd!.isReady)
                SizedBox(
                  width: AdSize.banner.width.toDouble(),
                  height: AdSize.banner.height.toDouble(),
                  child: AdWidget(ad: AdHelper.mainMenuBannerAd!.bannerAd!),
                )
              else
                const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
