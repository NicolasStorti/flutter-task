import 'package:flutter/material.dart';
import 'package:task_manager/components/tasks.dart';
import 'package:task_manager/data/task_dao.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    return value == null || value.isEmpty;
  }

  bool difficultyValidator(String? value) {
    if (value == null || value.isEmpty) return true;
    final intVal = int.tryParse(value);
    return intVal == null || intVal > 5 || intVal < 1;
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.task.nome;
    difficultyController.text = widget.task.dificuldade.toString();
    imageController.text = widget.task.foto;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar Tarefa'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (valueValidator(value)) {
                    return 'Insira o nome da Tarefa';
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nome da Tarefa'),
              ),
              TextFormField(
                validator: (value) {
                  if (difficultyValidator(value)) {
                    return 'Insira uma Dificuldade entre 1 e 5';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: difficultyController,
                decoration: InputDecoration(labelText: 'Dificuldade'),
              ),
              TextFormField(
                validator: (value) {
                  if (valueValidator(value)) {
                    return 'Insira uma URL de Imagem!';
                  }
                  return null;
                },
                keyboardType: TextInputType.url,
                onChanged: (text) {
                  setState(() {});
                },
                controller: imageController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
              Container(
                height: 100,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.blue),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageController.text,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/nophoto.png');
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Task updatedTask = Task(
                      nameController.text,
                      imageController.text,
                      int.parse(difficultyController.text),
                    );
                    TaskDao().update(updatedTask).then((rowsAffected) {
                      if (rowsAffected > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tarefa atualizada com sucesso!'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Você não pode alterar o nome!'),
                          ),
                        );
                      }
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar Alterações'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
