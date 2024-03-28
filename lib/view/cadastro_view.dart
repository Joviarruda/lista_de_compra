// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  @override
  Widget build(BuildContext context) {
    //
    //Recuperar argumento passado como parametro
    //
    final nome = ModalRoute.of(context)!.settings.arguments;


    return Scaffold(
      appBar: AppBar(
        title: Text('Tela 2 ${nome ??''}'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                //
                // Navegação
                //
                Navigator.pop(context);
              },
              child: Text('voltar'),
            ),
            OutlinedButton(
              onPressed: () {
                //
                // Navegação
                //
                Navigator.pushNamed(context, 't3');
              },
              child: Text('abrir'),
            ),
          ],
        ),
      ),
    );
  }
}