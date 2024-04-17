// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutablport 'package:flutter/material.dart';, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:lista_de_compra/model/listas.dart';
import 'package:lista_de_compra/model/itens.dart';

class EditarView extends StatefulWidget {
  @override
  State<EditarView> createState() => _EditarViewState();
}

class _EditarViewState extends State<EditarView> {
  late Listas lista;
  late Itens item;
  
  @override
  void initState() {
    super.initState();
    lista = Listas.preencher().first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
        backgroundColor: const Color.fromARGB(255, 45, 217, 57),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final searchText = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    final controller = TextEditingController();
                    return AlertDialog(
                      title: Text('Buscar Item'),
                      content: TextField(
                        controller: controller,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Nome do item',
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Buscar'),
                          onPressed: () {
                            Navigator.of(context).pop(controller.text);
                          },
                        ),
                      ],
                    );
                  },
                );

                if (searchText != null) {
                  // Busca pelo item com base no texto inserido
                  final resultado = lista.itens.firstWhere(
                    (item) => item.nomeI.toLowerCase() == searchText.toLowerCase(),
                    orElse: () => Itens(nomeI: '', num: ''),
                  );

                  if (resultado != '') {
                    // Se o item for encontrado, exiba suas informações em um diálogo
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Resultado da Busca'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Lista: ${lista.nomeL}'),
                              Text('Nome do Item: ${resultado.nomeI}'),
                              Text('Quantidade: ${resultado.num}'),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Fechar'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Se o item não for encontrado, exiba uma mensagem de erro
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Item não encontrado'),
                          content: Text('O item "$searchText" não foi encontrado.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 100),
        child: ListView.builder(
          itemCount: lista.itens.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: CheckboxListTile(
                title: Text(lista.itens[index].nomeI),
                subtitle: Text('Quantidade ${lista.itens[index].num}'),
                value: lista.itens[index].comprado ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    lista.itens[index].comprado = value;
                  });
                },
                secondary: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("O que deseja fazer?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  lista.itens.removeAt(index);
                                  Navigator.of(context).pop();
                                });
                              },
                              child: Text("Deletar"),
                            ),
                            TextButton(
                              onPressed: () async {
                                showDialog<String>(
                                  context: context,
                                  builder: (context) {
                                    final controller = TextEditingController();
                                    return AlertDialog(
                                      title: Text('Renomear Item'),
                                      content: TextField(
                                        controller: controller,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          labelText: 'Novo nome',
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            setState(() {
                                              lista.itens[index].nomeI  = controller.text; // Atualiza o nome da lista
                                            });
                                            Navigator.of(context).pop(controller.text);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text("Renomear"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancelar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 50),
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: const Size(100, 50),
            ),
            onPressed: () async {
              final nomeNovoItem = await showDialog<String>(
                context: context,
                builder: (context) {
                  final controller = TextEditingController();
                  return AlertDialog(
                    content: TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Novo produto',
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop(controller.text);
                        },
                      ),
                    ],
                  );
                },
              );

              if (nomeNovoItem != null) {
                final quantidadeNovoItem = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    final controller = TextEditingController();
                    return AlertDialog(
                      content: TextField(
                        controller: controller,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Quantidade',
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop(controller.text);
                          },
                        ),
                      ],
                    );
                  },
                );

                if (quantidadeNovoItem != null) {
                  setState(() {
                    lista.itens.add(Itens(nomeI: nomeNovoItem, num: quantidadeNovoItem));
                  });
                }
              }
            },
            child: const Text('Criar Produto'),
          ),
          SizedBox(width: 50),
        ],
      ),
    );
  }
}

