import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'cubit/count_cubit/count_cubit.dart';
import 'cubit/detail_cubit/detail_cubit.dart';
import 'cubit/home_cubit/home_cubit.dart';
import 'cubit/observer.dart';
import 'pages/count_page.dart';
import 'pages/detail_page.dart';
import 'pages/home_page.dart';
import 'services/sql_service.dart';

/// service locator
final sql = SQLService();
final counterCubit = CounterCubit();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  /// SQL setting
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, "TodoApp.db");
  await sql.open(path);

  runApp(const MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<DetailCubit>(create: (context) => DetailCubit()),
      ],
      child: MaterialApp(
        title: 'Todo app',
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        initialRoute: "/",
        routes: {
          "/": (context) => const HomePage(),
          "/detail": (context) => DetailPage(),
          "/count": (context) => const CountPage(),
        },
      ),
    );
  }
}
