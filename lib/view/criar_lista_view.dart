// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:lista_de_compra/model/listas.dart';
import 'package:lista_de_compra/model/itens.dart';
import 'package:lista_de_compra/view/lista_compra_view.dart';

class CriarView extends StatefulWidget {
  const CriarView({super.key});

  @override
  State<CriarView> createState() => _CriarViewState();
}

//Chave identificadora do Form
var formKey = GlobalKey<FormState>();

//Controladores dos Campos de Texto
var txtValor1 = TextEditingController();
var txtValor2 = TextEditingController();

class _CriarViewState extends State<CriarView> {
  // Declaração da lista dinâmica de Listas
  List<Listas> lista = [];
  List<Itens> produtos = [];
  
  //Extrai o texto dos controladores de texto
  String nomeLista = '';
  String nomeProduto = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Lista'),
        backgroundColor: Color.fromARGB(255, 41, 154, 49),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //Campo de texto 1
              TextFormField(
                controller: txtValor1,

                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Nome da Lista',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),

              //Campo de texto 2
              TextFormField(
                controller: txtValor2,

                style: TextStyle(fontSize: 20),

                decoration: InputDecoration(
                  labelText: 'Produtos',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),

              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blue.shade900,
                  minimumSize: Size(200, 50),
                ),
                onPressed: () {
                  if (nomeLista != ''){
                    //Extrai o texto dos controladores de texto
                    String nomeLista = txtValor1.text;
                    String nomeProduto = txtValor2.text;
                    
                    
                    //Cria um novo item de produto e adiciona à lista de produtos
                    produtos.add(Itens(nomeProduto));
                    
                    //Cria uma nova lista de compras e adiciona à lista
                    lista.add(Listas(nomeLista, produtos));
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Insira um Nome!'),
                        duration: Duration(seconds: 4),
                      ),
                    );
                  }
                },
                child: Text('Adicionar Item'),
              ),

              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blue.shade900,
                  minimumSize: Size(200, 50),
                ),
                onPressed: () {
                  
                  //Chamar os validadores dos campos de texto
                  Navigator.pop(context);
                },
                child: Text('Voltar')
              ),

              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blue.shade900,
                  minimumSize: Size(200, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListaView(lista: lista)),
                  );
                },
                child: Text('Criar Lista'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}