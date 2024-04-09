// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}
//Chave identificadora do Form
var formKey = GlobalKey<FormState>();

//Controladores dos Campos de Texto
var txtValor1 = TextEditingController();
var txtValor2 = TextEditingController();
var txtValor3 = TextEditingController();

class _CadastroViewState extends State<CadastroView> {
  @override
  Widget build(BuildContext context) {
    //
    //Recuperar argumento passado como parametro
    //
    final nome = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: const Color.fromARGB(255, 16, 62, 19),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //
              //Campo de texto
              //
              TextFormField(
                controller: txtValor1,

                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),

                //
                //Validação 1
                //
                validator: (value) {
                  if (value == null) {
                    return 'Informe o e-mail';
                  } else if (value.isEmpty) {
                    return 'Informe o e-mail';
                  } else if (!validateEmail(value)) {
                    return 'Informe um e-mail válido!';
                  }
                  //Retornar null significa sucersso válido
                  return null;
                },
              ),
              SizedBox(height: 30),

              //
              //Campo de texto 2
              //
              TextFormField(
                controller: txtValor2,

                style: TextStyle(fontSize: 20),

                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                //
                //Validação 2
                //
                validator: (value2) {
                  if (value2 == null) {
                    return 'Informe senha';
                  } else if (value2.isEmpty) {
                    return 'Informe senha';
                  } else if (double.tryParse(value2) == null) {
                    return 'Informe um valor numérico';
                  }
                  //Retornar null significa sucersso válido
                  return null;
                },
              ),
              SizedBox(height: 30),

              //
              //Campo de texto 3
              //
              TextFormField(
                controller: txtValor3,

                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  border: OutlineInputBorder(),
                ),

                //
                //Validação 3
                //
                validator: (value) {
                  if (value != txtValor2.text) {
                    return 'Senhas não conferem';
                  } 
                  //Retornar null significa sucersso válido
                  return null;
                },
              ),
              SizedBox(height: 30),

              Row(
                children: [
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade200,
                      foregroundColor: const Color.fromARGB(255, 16, 62, 19),
                      minimumSize: Size(100, 50),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 0, width: 50),

                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade200,
                      foregroundColor: const Color.fromARGB(255, 16, 62, 19),
                      minimumSize: Size(100, 50),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                       Navigator.pushNamed(context, 'lista');
                      }
                    },
                    child: Text('Cadastrar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
bool validateEmail(String email) {
  // Regular expression pattern for a valid email address
  const pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  return RegExp(pattern).hasMatch(email);
}