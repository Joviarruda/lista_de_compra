// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutablport 'package:flutter/material.dart';
import 'package:lista_de_compra/model/listas.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compra/model/listas.dart';
import 'package:lista_de_compra/model/itens.dart';

int lstindex = 0;

class ListaView extends StatefulWidget {
  const ListaView({Key? key, required List<Listas> lista}) : super(key: key);

  @override
  State<ListaView> createState() => _ListaViewState();
}

class _ListaViewState extends State<ListaView> {
  // Declaração da lista dinâmica de Listas
  List<Listas> dados = [];
  List<Itens> itens = [];

  @override
  void initState() {
    // Preenche a lista de Listas com dados de exemplo
    dados = Listas.preencher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 100),
        child: ListView.builder(
          itemCount: dados.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400, // Cor da borda
                      width: 1.0, // Largura da borda
                    ),
                    borderRadius:
                        BorderRadius.circular(10.0), // Borda arredondada
                  ),
                  child: ListTile(
                    title: GestureDetector(
                      onLongPress: () async {
                        final value = await showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(50.0, 50.0, 0.0, 0.0),
                          items: <PopupMenuEntry>[
                            PopupMenuItem(
                              value: 'rename',
                              child: Text('Renomear'),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Deletar'),
                            ),
                          ],
                        );
                        if (value == 'delete') {
                          setState(() {
                            dados.removeAt(index);
                          });
                        } else if (value == 'rename') {
                          final newName = await showDialog<String>(
                            context: context,
                            builder: (context) => Builder(
                              builder: (innerContext) {
                                final controller = TextEditingController();
                                return AlertDialog(
                                  title: Text('Renomear lista'),
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
                                        Navigator.of(innerContext).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(innerContext)
                                            .pop(controller.text);
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                          if (newName != null) {
                            setState(() {
                              dados[index].nome =
                                  newName; // Atualiza o nome da lista
                            });
                          }
                        }
                      },
                      child: Text(dados[index].nome), // Exibe o nome da lista
                    ),
                    onTap: () {
                      lstindex = index;
                      Navigator.pushNamed(context, 'lista',
                          arguments: dados[index]);
                    },
                  ),
                ),
                SizedBox(height: 20), // Espaço entre as listas
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          // Botão "Criar Lista"
          const SizedBox(width: 50), // Espaçamento
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade200,
              foregroundColor: const Color.fromARGB(255, 16, 62, 19),
              minimumSize: const Size(100, 50),
            ),
            onPressed: () {
              setState(() {
                // Cria uma nova lista com um nome padrão
                final novoItem = Itens('Produto ${dados.length + 1}');
                // Cria uma nova lista com um nome padrão
                final novaLista = Listas('Lista ${dados.length + 1}',novoItem as List<Itens>);
                // Adiciona a nova lista à lista de dados
                dados.add(novaLista);
              });
            },
            child: const Text('Criar Lista'),
          ),
          const SizedBox(width: 50), // Espaçamento
          // Botão "Editar lista"
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade200,
              foregroundColor: const Color.fromARGB(255, 16, 62, 19),
              minimumSize: const Size(100, 50),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'edita');
            },
            child: const Text('Editar lista'),
          ),
        ],
      ),
    );
  }
}
