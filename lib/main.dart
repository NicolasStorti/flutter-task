import 'package:flutter/material.dart';
import 'package:task_manager/screens/form_screen.dart';
import 'package:task_manager/screens/tela_inicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter - Gerenciador de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: TaskInherited(child: const InitialScreen(),),
      initialRoute: "/home",
      routes: {
        "/home":(context)=> InitialScreen(),
        "/newTask":(context)=> FormScreen(taskContext: context),
      },
    );
  }
}
