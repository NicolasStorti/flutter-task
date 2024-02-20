import 'package:flutter/material.dart';
import 'package:task_manager/components/tasks.dart';
import 'package:task_manager/data/task_dao.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        title: const Text('Tarefas'),
        leading: IconButton( // Altere o ícone de adicionar tarefa para um botão de navegação
          onPressed: () {
            onButtonAddTaskClicked(context); // Chamada do método para navegar para a tela de adicionar tarefa
          },
          icon: Icon(Icons.add_task),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Task>? items = snapshot.data as List<Task>?;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Task tarefa = items[index];
                        return tarefa;
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 128,),
                        Text(
                          'Não há nenhuma Tarefa',
                          style: TextStyle(fontSize: 32),
                        )
                      ],
                    ),
                  );
                }
                return Text('Erro ao carregar Tarefas');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onButtonAddTaskClicked(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void onButtonAddTaskClicked(BuildContext context) {
  Navigator.of(context).pushReplacementNamed("/newTask");
}
