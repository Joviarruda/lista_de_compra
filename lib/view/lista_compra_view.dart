// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lista_de_compra/model/listas.dart';


class ListaView extends StatefulWidget {
  const ListaView({super.key});

  @override
  State<ListaView> createState() => _ListaViewState();
}

class _ListaViewState extends State<ListaView> {
  //Declaração da lista dinâmica de Contatos
  List<Listas> dados = [];

  @override
  void initState() {
    dados = Listas.preencher();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        //
        // ListView
        //
        child: Column(
          children: [
            ListView.builder(
              //quantidade de itens
              itemCount: dados.length,
              //aparencia de cada item
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(dados[index].nome),
                    subtitle: Text(dados[index].itens[0] as String),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(dados[index].nome))
                      );
                    },
                    hoverColor: Colors.red.shade100,

                    onLongPress: (){
                      setState((){
                        dados.removeAt(index);
                      });
                    },
                  ),
                );
              }
            ),
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
                      Navigator.pushNamed(context, 'edita');
                    },
                    child: Text('Editar lista'),
                  ),
                ],
              ),
          ]
        )
      ),
    );
  }
}
