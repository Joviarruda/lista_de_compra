// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutablport 'package:flutter/material.dart';, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:lista_de_compra/model/listas.dart';
import 'package:lista_de_compra/model/itens.dart';

class EditarView extends StatefulWidget {
  const EditarView({Key? key}) : super(key: key);

  @override
  State<EditarView> createState() => _EditarViewState();
}

class _EditarViewState extends State<EditarView> {
  late Listas lista;
  Map<String, List<Map<String, dynamic>>> listaComp = {};
  List<Map<String, dynamic>>? resultado;

  @override
  void initState() {
    super.initState();
    lista = Listas.preencher().first;
  }

  @override
  Widget build(BuildContext context) {
    final listaNome = ModalRoute.of(context)!.settings.arguments as String? ?? 'editar';

    return Scaffold(
      appBar: AppBar(
        title: Text(listaNome),
        backgroundColor: const Color.fromARGB(255, 45, 217, 57),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String searchQuery = '';
                    return AlertDialog(
                      title: Text('Buscar Item'),
                      content: TextField(
                        onChanged: (value) {
                          searchQuery = value;
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Buscar'),
                          onPressed: () {
                            resultado = buscarItems(searchQuery);
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Resultados da Busca'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: resultado?.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(resultado?[index]['nome'] ??''),
                                          subtitle: Text(resultado?[index]['descricao'] ??''),
                                          trailing: Text('Quantidade: ${resultado?[index]['quantidade'] ?? ''}'),
                                        );
                                      },
                                    ),
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
                          }
                        ),
                      ],
                    );
                  },
                );
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
                subtitle: Text(lista.itens[index].num),
                value: listaComp[listaNome]![index]['comprado'] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    listaComp[listaNome]![index]['comprado'] = value;
                  });
                },
                secondary: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        TextEditingController nomeController = TextEditingController(text: listaComp[listaNome]![index]['nome']);
                        TextEditingController descricaoController = TextEditingController(text: listaComp[listaNome]![index]['descricao']);
                        TextEditingController quantidadeController = TextEditingController(text: listaComp[listaNome]![index]['quantidade'].toString());
                        return AlertDialog(
                          title: Text('Editar Item'),
                          content: Column(
                            children: [
                              TextField(
                                controller: nomeController,
                                decoration: InputDecoration(hintText: 'Nome'),
                              ),
                              TextField(
                                controller: descricaoController,
                                decoration:InputDecoration(hintText: 'Descrição'),
                              ),
                              TextField(
                                controller: quantidadeController,
                                decoration:InputDecoration(hintText: 'Quantidade'),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Salvar'),
                              onPressed: () {
                                setState(() {
                                  Map<String, dynamic> item =listaComp[listaNome]![index];
                                  alterarNome(item, nomeController.text);
                                  alterarDescricao(item, descricaoController.text);
                                  alterarQuantidade(item, int.parse(quantidadeController.text));
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                )
              )
            );
          }
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

  void alterarNome(Map<String, dynamic> item, String novoNome) {
    item['nome'] = novoNome;
  }

  void alterarDescricao(Map<String, dynamic> item, String novaDescricao) {
    item['descricao'] = novaDescricao;
  }

  void alterarQuantidade(Map<String, dynamic> item, int novaQuantidade) {
    item['quantidade'] = novaQuantidade.toString();
  }

  List<Map<String, dynamic>> buscarItems(String query) {
    List<Map<String, dynamic>> results = [];

    for (var listaNome in listaComp.keys) {
      var items = listaComp[listaNome];
      if (items != null) {
        for (var item in items) {
          if (item['nome'].toLowerCase().contains(query.toLowerCase()) ||
              item['descricao'].toLowerCase().contains(query.toLowerCase())) {
            results.add(item);
          }
        }
      }
    }

    return results;
  }
}
