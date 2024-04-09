import 'package:lista_de_compra/model/itens.dart';

class Listas {
  //atributos
  final String nome;
  List<Itens> itens = [];

  //construtor
  Listas(this.nome, this.itens);

  //geração de dados
  static List<Listas> preencher() {
    //atribuindo 'lista' a lista contato
    List<Listas> lista = [];

    List<Itens> produtos = [];
    produtos.add(Itens('Produto 1'));
    produtos.add(Itens('Produto 2'));
    produtos.add(Itens('Produto 3'));

    //atribuindo a lista contato
    lista.add(Listas('Mercado', produtos));
    lista.add(Listas('Varejo', produtos));

    return lista;
  }
}
