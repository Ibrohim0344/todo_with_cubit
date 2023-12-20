import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/count_cubit/count_cubit.dart';

class CountPage extends StatelessWidget {
  const CountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (providerContext) => CounterCubit(),
      child: Builder(builder: (builderContext) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          builderContext.read<CounterCubit>().increment(),
                      child: const Text("+"),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          builderContext.read<CounterCubit>().decrement(),
                      child: Text(
                        "-",
                        style: Theme.of(builderContext)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: Colors.purpleAccent,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
