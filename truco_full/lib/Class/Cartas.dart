class Cartas {
  late int valor; // 1 a 13 
  late int naipe; // 1 a 4 representando Ouros, Espadas, Copas e Paus
  List<int> valores = [3, 2, 1, 13, 11, 12, 7, 6, 5, 4];
  List<int> naipes = [1, 2, 3, 4];
   List<Cartas> todasCartas = [];

  Cartas.vazio();

  Cartas(this.naipe, this.valor);


  int encontrarProximoValor(List<int> list, int cartaVirada) {
    int index = list.indexOf(cartaVirada);
    if(index == 0){
      return list[list.length - 1]; // Retorna o último elemento da lista se o índice for 0
    }
    else {
      return list[index - 1]; // Retorna o elemento anterior na lista
    }
}

  List<Cartas> ajustarForcaCartas(Cartas cartaVirada) {
    // Encontrar o próximo valor após a carta virada
    int cartaValor = encontrarProximoValor(valores, cartaVirada.valor);
    // Encontrar o índice da carta virada nas listas de valores e naipes
    int valorIndex = valores.indexOf(cartaValor);

    if (valorIndex != -1) {
      // Remover a carta virada das listas
      valores.removeAt(valorIndex);

      // Inserir a próxima carta na posição da carta virada
      int nextValorIndex = 0;
      // Inserir a próxima carta na posição da carta virada
      valores.insert(nextValorIndex, cartaValor);
    }
  // Adicionar todas as cartas deste naipe na lista
     List<Cartas> todasCartas = [];
    for(int naipe in naipes)
      for (int valor in valores) {
      todasCartas.add(Cartas(naipe, valor));
    }
    
    return todasCartas;
  }

  @override
  String toString() {
    return "Naipe: $naipe - Valor: $valor";
  }
}