import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/detail_cubit/detail_cubit.dart';
import '../models/todo_model.dart';

class DetailPage extends StatelessWidget {
  final Todo? todo;

  DetailPage({this.todo, super.key});

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  void initState() {
    titleCtrl.text = todo?.title ?? "";
    descCtrl.text = todo?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailCubit>();
    initState();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: [
          IconButton(
            onPressed: () {
              todo == null
                  ? cubit.create(titleCtrl.text, descCtrl.text)
                  : cubit.edit(todo!, titleCtrl.text, descCtrl.text);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(hintText: "Description"),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          BlocConsumer<DetailCubit, DetailState>(
            builder: (context, state) {
              /// builder
              if (state is DetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const SizedBox.shrink();
            },
            listener: (context, state) {
              /// listener
              if (state is DetailFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }

              if ((state is DetailCreateSuccess ||
                      state is DetailUpdateSuccess) &&
                  context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
