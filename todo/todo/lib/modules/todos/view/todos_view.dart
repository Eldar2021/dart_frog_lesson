import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/logic/todo_cubit.dart';
import 'package:todo/models/todo/todo_model.dart';
import 'package:todo/modules/modules.dart';

class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodosView'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return switch (state.status) {
            FetchStatus.initial || FetchStatus.loading => const LoadingWidget(),
            FetchStatus.success => TodosList(state.todos ?? []),
            FetchStatus.error => ErrorView(state.errorText ?? ''),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddTodoView(),
            ),
          );
        },
      ),
    );
  }
}

class TodosList extends StatelessWidget {
  const TodosList(this.todos, {super.key});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = todos[index];
        return Card(
          child: SwitchListTile(
            onChanged: (bool value) {
              // todo.isCompleted = value;
            },
            value: todo.isCompleted,
            title: Text(todo.title),
            subtitle: Text(todo.description),
          ),
        );
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CupertinoActivityIndicator());
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView(this.errorText, {super.key});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorText));
  }
}
