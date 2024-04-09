// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lista_de_compra/view/cadastro_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

//Chave identificadora do Form
var formKey = GlobalKey<FormState>();

//Controladores dos Campos de Texto
var txtValor1 = TextEditingController();
var txtValor2 = TextEditingController();

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
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
              //Campo de texto 1
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
                    return 'Digite o email';
                  } else if (value.isEmpty) {
                    return 'Digite o email';
                  } else if (!validateEmail(value)) {
                    return 'Digite um email válido';
                  }
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
                  //Retornar null significa sucesso válido
                  return null;
                },
              ),
              SizedBox(height: 30),

              //
              //Campo de Butão
              //
              //ElevatedButton, OutlinedButton, TextButton
              Row(
                children: [
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade200,
                      foregroundColor: const Color.fromARGB(255, 16, 62, 19),
                      minimumSize: Size(100, 50),
                    ),
                      onPressed: () {
                        //
                        //Chamar os validadores dos campos de texto
                        //

                        if (txtValor1.text.isNotEmpty && validateEmail(txtValor1.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Sua nova senha foi enviada!'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('E-mail invalido!'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: Text('Esquci a Senha')),
                  SizedBox(height: 0, width: 15),

                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade200,
                      foregroundColor: const Color.fromARGB(255, 16, 62, 19),
                      minimumSize: Size(100, 50),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'cadastro');
                    },
                    child: Text('Cadastrar-se')
                  ),
                ],
              ),
              SizedBox(height: 30),
              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade200,
                  foregroundColor: const Color.fromARGB(255, 16, 62, 19),
                  minimumSize: Size(100, 50),
                ),
                onPressed: () {
                  //
                  //Chamar os validadores dos campos de texto
                  //
                  if (formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, 'lista');
                  }
                },
                child: Text('Logar')
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