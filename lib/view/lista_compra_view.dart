// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:lista_de_compra/model/listas.dart';

class ListaView extends StatefulWidget {
  const ListaView({Key? key, required List<Listas> lista}) : super(key: key);

  @override
  State<ListaView> createState() => _ListaViewState();
}

class _ListaViewState extends State<ListaView> {
  // Declaração da lista dinâmica de Listas
  List<Listas> dados = [];

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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Exibe as listas de compras
            Expanded(
              child: ListView.builder(
                itemCount: dados.length,
                itemBuilder: (context, index) {
                  // Para cada Lista, cria um Card
                  return Card(
                    child: ListTile(
                      title: Text(dados[index].nome),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Exibe os itens da lista de compras
                          for (var item in dados[index].itens)(
                            Text(item.nome)
                          ),
                        ],
                      ),
                      onTap: () {
                        // Ação ao tocar na lista
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(dados[index].nome)),
                        );
                      },
                      onLongPress: () {
                        // Ação ao pressionar longamente na lista
                        setState(() {
                          dados.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                // Botão "Login"
                const SizedBox(width: 50), // Espaçamento
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade200,
                    foregroundColor: const Color.fromARGB(255, 16, 62, 19),
                    minimumSize: const Size(100, 50),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'criar');
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
          ],
        ),
      ),
      
    );
  }
}
