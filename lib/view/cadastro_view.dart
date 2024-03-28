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
        title: Text('Cadastro'),
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
                  } else if (double.tryParse(value) == null) {
                    return 'Informe um valor numérico';
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
                validator: (value) {
                  if (value == null) {
                    return 'Informe senha';
                  } else if (value.isEmpty) {
                    return 'Informe senha';
                  } else if (double.tryParse(value) == null) {
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
                  if (value == null) {
                    return 'Informe a senha';
                  } else if (value.isEmpty) {
                    return 'Informe senha';
                  } else if (double.tryParse(value) == null) {
                    return 'Informe um valor numérico';
                  }
                  //Retornar null significa sucersso válido
                  return null;
                },
              ),
              
              //
              //Campo de Butão
              //
              //ElevatedButton, OutlinedButton, TextButton
              OutlinedButton(
                onPressed: () {
                  //
                  // Navegação
                  //
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
              ),

              SizedBox(height: 0, width: 30),
              OutlinedButton(
                onPressed: () {
                  //
                  // Navegação
                  //
                  Navigator.pushNamed(context, 't3');
                },
                child: Text('Cadastrar'),
              ),

              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blue.shade900,
                  minimumSize: Size(200, 50),
                  shadowColor: Colors.red,
                ),
                onPressed: () {
                  //
                  //Chamar os validadores dos campos de texto
                  //
                  if (formKey.currentState!.validate()) {
                     Navigator.pushNamed(context, 'cadastro');
                  }
                },
                child: Text('OK')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
