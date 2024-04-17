import 'package:lista_de_compra/model/itens.dart';

class Listas {
   String nomeL;
  List<Itens> itens = [];

  Listas({required this.nomeL, this.itens = const []});

  get produtos => null; 

  static List<Listas> preencher() {
    List<Listas> lista = [];

    List<Itens> produtos = [];
    produtos.add(Itens(nomeI: 'Produto 1', num:'1'));
    produtos.add(Itens(nomeI: 'Produto 2',num:'2'));
    produtos.add(Itens(nomeI: 'Produto 3',num:'4'));

    lista.add(Listas(nomeL: 'Mercado', itens: produtos, )); 
    return lista;
  }
}
