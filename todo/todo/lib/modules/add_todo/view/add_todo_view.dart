import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/logic/todo_cubit.dart';
import 'package:todo/models/todo/todo_model.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({super.key});

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final formKey = GlobalKey<FormState>();
  final titleCtl = TextEditingController();
  final descCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTodoView'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(controller: titleCtl),
            TextFormField(controller: descCtl),
            ElevatedButton.icon(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final todo = Todo(title: titleCtl.text, description: descCtl.text, isCompleted: false);
                  context.read<TodoCubit>().addTodo(todo);
                }
              },
              label: const Text('Add Todo'),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
