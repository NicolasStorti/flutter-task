import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nova Tarefa'),
        ),
        body: Center(
          child: Container(
            height: 650,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3)
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String? value){
                      if(value != null && value.isEmpty){
                        return 'Insira o nome da Tarefa';
                      }
                      return null;
                    },
                    controller: nameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nome',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value){
                      if(value !.isEmpty || int.parse(value) > 5 || int.parse(value) < 1){
                        return 'Insira uma Dificultade entre 1 e 5';
                      }
                      return null;
                    },
                    controller: difficultyController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Dificuldade',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Insira uma URL da Imagem!';
                      }
                      return null;
                    },
                    onChanged: (text){
                      setState((){

                      });
                    },
                    controller: imageController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:'Imagem',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2,color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(imageController.text,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/nophoto.png');
                      },
                      fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    print(nameController.text);
                    print(int.parse(difficultyController.text));
                    print(imageController.text);
                  }
                }, child: Text('Adicionar'),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}