// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SobreView extends StatefulWidget {
  const SobreView({super.key});

  @override
  State<SobreView> createState() => _SobreViewState();
}

class _SobreViewState extends State<SobreView> {
  @override
  Widget build(BuildContext context) {
    String sobre = 'Sobre\n\n\nAplicativo para avaliação da P1 de PDM.\n\nDesenvolvido no VSCode.\n\nO Aplicativo consite em 4 telas, uma de Login, Cadastro, Listas de Compras e uma para edição das listas.\n\nJoão Vitor Bravo Arruda\n\nRA: 2840482221006';

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: const Color.fromARGB(255, 45, 217, 57),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
          child: Column(
            children: [
              Text(
                sobre,
                style: TextStyle(fontSize: 20),
              ),
              Expanded(child: Container()),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Voltar'),
              )
            ],
        ),
      ),
    );
  }
}
