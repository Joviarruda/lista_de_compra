// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compra/view/login_view.dart';

import 'view/cadastro_view.dart';
import 'view/editar_lista_view.dart';
import 'view/lista_compra_view.dart';
import 'view/sobre_view.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      initialRoute: 'login',
      
      //ROTAS DE NAVEGAÇÃO
      routes: {
        'login': (context) => LoginView(),
        'cadastro': (context) => CadastroView(),
        'lista': (context) => ListaView(lista: [],),
        'editar': (context) => EditarView(),
        'sobre': (context) => SobreView(),
      },
    );
  }
}
