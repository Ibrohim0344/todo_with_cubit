import 'package:bloc/bloc.dart';

import '../../main.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void fetchTodos() async {
    emit(HomeLoading(todos: state.todos));
    try {
      final todos = await sql.todos();
      emit(HomeFetchSuccess(todos: todos));
    } catch (e) {
      emit(HomeFailure(todos: state.todos, message: "HOME ERROR $e"));
    }
  }
}
