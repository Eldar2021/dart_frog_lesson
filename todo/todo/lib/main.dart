import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/app.dart';
import 'package:todo/core/core.dart';

void main() {
  runApp(RepositoryProvider(
    create: (context) => ApiService(),
    child: const MyApp(),
  ));
}
