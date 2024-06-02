import 'package:flutter/material.dart';
import 'package:truco_full/Class/Jogador.dart';
import 'PlayerHand.dart';
import './Class/Game.dart';
import './CardModel.dart';
import 'Class/Cartas.dart';
import 'Class/CartaNaMesa.dart';
import 'TrucoCard.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  final Game game = Game(); // Instância da classe Game para gerenciar a lógica do jogo
  int jogadoresQueJogaram = 0; // Variável de controle para acompanhar quantos jogadores jogaram suas cartas

  @override
  void initState() {
    super.initState();
    game.iniciarJogo(); // Inicializa o jogo ao criar a tela
  }

  // Função para jogar uma carta ao tocar em uma carta na mão do jogador
  void _jogarCarta(int index, Jogador jogador) {
    setState(() {
      if (jogadoresQueJogaram < 4 && jogador == game.jogadorAtual) { // Verifica se ainda não foram jogadas as cartas de todos os jogadores e se é a vez do jogador
        game.escolherCartaDaJogada(index, jogador); // Chama o método escolherCartaDaJogada da classe Game passando o índice clicado
        jogadoresQueJogaram++; // Incrementa o contador de jogadores que jogaram suas cartas

        // Define o próximo jogador
        game.jogadorAtual = game.proximoJogador();

        // Verifica se todos os jogadores já jogaram
        if (jogadoresQueJogaram == 4) {
          // Adiciona as cartas à lista de cartas na mesa
          game.CartasNaMesa();
          // Chama o método para definir o ganhador da rodada
          game.definirGanhadorRodada(
            game.retornarListaDeForca(),
            game.baralho.cartasNaMesa,
            game.trucoAceito,
          );
          jogadoresQueJogaram = 0; // Reinicia o contador de jogadores que jogaram
        }
      }
    });
  }

  // Converte a lista de cartas do jogador para uma lista de modelos de cartas exibíveis
  List<CardModel> converterCartasParaString(List<Cartas> cartas) {
    return cartas.map((carta) {
      return CardModel(
        faceValue: '${carta.valor} de ${carta.naipe}',
        value: carta.valor,
        naipe: carta.naipe,
        faceUrl: ""
      );
    }).toList();
  }

  // Converte a lista de cartas na mesa para uma lista de modelos de cartas exibíveis
  List<CardModel> converterCartasNaMesaParaString(List<CartaNaMesa> cartasNaMesa) {
    return cartasNaMesa.map((cartaNaMesa) {
      return CardModel(
        faceValue: '${cartaNaMesa.carta?.valor} de ${cartaNaMesa.carta?.naipe}',
        value: cartaNaMesa.carta?.valor ?? 0,
        naipe: cartaNaMesa.carta?.naipe ?? 0,
        faceUrl: ""
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Exibe a carta de manilha na tela
            Text(
              'Manilha: ${game.manilha}', // Supondo que você tenha uma representação de string adequada para a carta de manilha
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            // Mão do jogador 1
            PlayerHand(
              hand: converterCartasParaString(
                  game.baralho.listaJogador[0].maoJogador),
              showHand: true,
              onTapCard: (index) {
                _jogarCarta(index, game.baralho.listaJogador[0]);
              },
              isCurrentPlayer: game.baralho.listaJogador[0] == game.jogadorAtual, // Adiciona o indicador
            ),
            // Mão do jogador 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlayerHand(
                  hand: converterCartasParaString(
                      game.baralho.listaJogador[1].maoJogador),
                  vertical: true,
                  showHand: true,
                  onTapCard: (index) {
                    _jogarCarta(index, game.baralho.listaJogador[1]);
                  },
                  isCurrentPlayer: game.baralho.listaJogador[1] == game.jogadorAtual, // Adiciona o indicador
                ),
                const Spacer(flex: 5),
                // Mão do jogador 3
                PlayerHand(
                  hand: converterCartasParaString(
                      game.baralho.listaJogador[2].maoJogador),
                  vertical: true,
                  showHand: true,
                  onTapCard: (index) {
                    _jogarCarta(index, game.baralho.listaJogador[2]);
                  },
                  isCurrentPlayer: game.baralho.listaJogador[2] == game.jogadorAtual, // Adiciona o indicador
                ),
              ],
            ),
            // Mão do jogador 4
            PlayerHand(
              hand: converterCartasParaString(
                  game.baralho.listaJogador[3].maoJogador),
              showHand: true,
              onTapCard: (index) {
                _jogarCarta(index, game.baralho.listaJogador[3]);
              },
              isCurrentPlayer: game.baralho.listaJogador[3] == game.jogadorAtual, // Adiciona o indicador
            ),
            // Exibe as cartas na mesa
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: converterCartasNaMesaParaString(game.baralho.cartasNaMesa).map((cardModel) {
                return TrucoCard(
                  cardModel: cardModel,
                  showFace: true, // Para mostrar a face da carta
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
