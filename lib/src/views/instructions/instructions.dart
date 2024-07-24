import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/music.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/icon_button.dart';

class Instructions extends StatefulWidget {
  final BoxConstraints constraints;

  const Instructions(this.constraints, {super.key});

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: ColorsApp.background,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Container(
                  width: widget.constraints.maxWidth * .7,
                  color: ColorsApp.color2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Instruções",
                            style: GoogleFonts.girassol(
                                fontSize: 50,
                                textStyle:
                                    TextStyle(color: ColorsApp.letters))),
                        Text("Bem vindo ao jogo de Mímica!",
                            style: GoogleFonts.girassol(
                                fontSize: 30,
                                textStyle:
                                    TextStyle(color: ColorsApp.letters))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Como configurar o jogo:",
                                style: GoogleFonts.girassol(
                                    fontSize: 25,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Text(
                                "1 - Ao selecionar a opção jogar, é possível escolher as categorias e o tempo de partida",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Text(
                                "1.1 - Você pode selecionar uma ou mais categorias para uma única partida, quando selecionada ela muda de cor e perde elevação",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Button(
                                        elevation: 10,
                                        buttonColor: ColorsApp.color1,
                                        onPressed: () {
                                          BackgroundMusicPlayer.loadMusic2();
                                          BackgroundMusicPlayer
                                              .playBackgroundMusic(2);
                                        },
                                        label: "Geral"),
                                    const SizedBox(height: 5),
                                    Text("Não selecionado",
                                        style: GoogleFonts.girassol(
                                            fontSize: 20,
                                            textStyle: TextStyle(
                                                color: ColorsApp.letters)))
                                  ],
                                ),
                                const SizedBox(width: 40),
                                Column(
                                  children: [
                                    Button(
                                        elevation: 0,
                                        buttonColor: ColorsApp.color3,
                                        onPressed: () {
                                          BackgroundMusicPlayer.loadMusic2();
                                          BackgroundMusicPlayer
                                              .playBackgroundMusic(2);
                                        },
                                        label: "Geral"),
                                    const SizedBox(height: 5),
                                    Text("Selecionado",
                                        style: GoogleFonts.girassol(
                                            fontSize: 20,
                                            textStyle: TextStyle(
                                                color: ColorsApp.letters)))
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                                "1.2 - Você também pode selecionar um tempo específico de duração de partida em segundos, caso não o faça, o tempo padrão é 60 segundos",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            inputTime(),
                            const SizedBox(height: 10),
                            Text(
                                "1.3 - Após configurar a partida de acordo com sua preferência, clique no botão 'Iniciar jogo' para começar",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Text("Como jogar:",
                                style: GoogleFonts.girassol(
                                    fontSize: 25,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Text(
                                "2 - Ao clicar em 'Iniciar jogo', um timer inicial de 3 segundos é contado e após isso o jog de fato começa",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Text(
                                "2.1 - O tempo passa de acordo com o que foi colocado anteiroemnte e as palavras relacionadas aos temas selecionados aparecerão no meio da tela",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorsApp.color1,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text('60',
                                        style: GoogleFonts.girassol(
                                            fontSize: 24,
                                            textStyle: TextStyle(
                                                color: ColorsApp.letters))),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Container(
                                  height: 200,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorsApp.color1,
                                  ),
                                  child: Center(
                                    child: Text("Chorar",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.girassol(
                                            fontSize: 24,
                                            textStyle: TextStyle(
                                                color: ColorsApp.letters))),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                                "2.2 - Ao lado haverá dois botões, se a palavra for acertada, o jogador deve clicar no botão de cima, caso a palvra esteja difícil e o jogador queira trocar, no de baixo",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CustomIconButton(
                                      elevation: 5,
                                      buttonColor: ColorsApp.color1,
                                      onPressed: () {
                                        BackgroundMusicPlayer.loadMusic2();
                                        BackgroundMusicPlayer
                                            .playBackgroundMusic(2);
                                      },
                                      icon: Icons.check,
                                      padding: 8,
                                    ),
                                    const SizedBox(height: 5),
                                    Text("Botão de acerto",
                                        style: GoogleFonts.girassol(
                                            fontSize: 20,
                                            textStyle: TextStyle(
                                                color: ColorsApp.letters)))
                                  ],
                                ),
                                const SizedBox(width: 40),
                                Column(
                                  children: [
                                    CustomIconButton(
                                      elevation: 5,
                                      buttonColor: ColorsApp.color1,
                                      onPressed: () {
                                        BackgroundMusicPlayer.loadMusic2();
                                        BackgroundMusicPlayer
                                            .playBackgroundMusic(2);
                                      },
                                      icon: Icons.autorenew_outlined,
                                      padding: 8,
                                    ),
                                    const SizedBox(height: 5),
                                    Text("Botão de troca",
                                        style: GoogleFonts.girassol(
                                            fontSize: 20,
                                            textStyle: TextStyle(
                                                color: ColorsApp.letters)))
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                                "2.3 - Também é possível pausar no meio do jogo para sair. Quando o jogo é pausado, o timer não passa",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Text(
                                "2.4 - Ao acabar o tempo, os resultados aparecem, mostrando a quantidade de palavras acertadas e quais foram as palavras que passaram. As palavras em negrito foram as acertadas e as normais foram as trocadas",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            AlertDialog(
                              backgroundColor: ColorsApp.color2,
                              title: Center(
                                child: Text('Fim do Tempo!',
                                    style: GoogleFonts.girassol(
                                        fontSize: 24,
                                        textStyle: TextStyle(
                                            color: ColorsApp.letters))),
                              ),
                              content: SingleChildScrollView(
                                  child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.girassol(
                                    fontSize: 24,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters),
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Palavras Acertadas: ',
                                    ),
                                    TextSpan(
                                      text: '2\n',
                                      style: GoogleFonts.girassol(
                                        fontSize: 20,
                                        textStyle:
                                            TextStyle(color: ColorsApp.letters),
                                      ),
                                    ),
                                    const TextSpan(
                                      text: 'Palavras Passadas: ',
                                    ),
                                    TextSpan(
                                      text: "Alice no país das maravilhas ",
                                      style: GoogleFonts.girassol(
                                        fontSize: 20,
                                        textStyle: TextStyle(
                                            color: ColorsApp.letters,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "- Exterminador do futuro -",
                                      style: GoogleFonts.girassol(
                                        fontSize: 20,
                                        textStyle:
                                            TextStyle(color: ColorsApp.letters),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Pulp Fiction",
                                      style: GoogleFonts.girassol(
                                        fontSize: 20,
                                        textStyle: TextStyle(
                                            color: ColorsApp.letters,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              actions: [
                                Button(
                                    elevation: 10,
                                    buttonColor: ColorsApp.color3,
                                    onPressed: () {
                                      BackgroundMusicPlayer.playBackgroundMusic(
                                          1);
                                    },
                                    label: "Voltar")
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("Aproveite o jogo!!",
                            style: GoogleFonts.girassol(
                                fontSize: 30,
                                textStyle:
                                    TextStyle(color: ColorsApp.letters))),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          backButton()
        ],
      ),
    ));
  }

  Widget backButton() {
    return Positioned(
        top: 10,
        left: 10,
        child: CustomIconButton(
            elevation: 5,
            buttonColor: ColorsApp.color1,
            onPressed: () {
              BackgroundMusicPlayer.loadMusic2();
              BackgroundMusicPlayer.playBackgroundMusic(2);
              Navigator.pop(context);
            },
            icon: Icons.arrow_back,
            padding: 0));
  }

  Widget inputTime() {
    return Center(
      child: SizedBox(
        width: 228,
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              labelText: 'Tempo da Rodada (segundos)',
              labelStyle: TextStyle(color: Colors.white)),
          keyboardType: TextInputType.number,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
