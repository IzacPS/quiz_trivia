import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/main/main_bloc.dart';
import 'package:quiz_app/cubit/countdown/countdown_cubit.dart';

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: const [
                    Text(
                      'BE READY!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'THE GAME STARTS IN:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder<CountdownCubit, CountdownState>(
                builder: (_, state) {
                  if (state is CountdownInitial) {
                    context.read<CountdownCubit>().startCountdown();
                  } else if (state is CountdownFinish) {
                    context.read<MainBloc>().add(StartSoloGameplayEvent());
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.pop(context);
                    });
                  } else if (state.duration == 0) {
                    context.read<CountdownCubit>().finishCounter();
                  }
                  return Text(
                      style:
                          const TextStyle(color: Colors.purple, fontSize: 92),
                      state.duration.toString());
                },
                buildWhen: (previousState, state) {
                  return previousState is! CountdownFinish;
                },
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
