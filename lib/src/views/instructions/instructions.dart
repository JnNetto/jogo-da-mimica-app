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
    List<String> categories = ["Personagens"];
    List<String> words = ["Superman", "Batman", "Mulher maravilha"];
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
                                "1.3 - Caso não esteja interessado nas categorias padrão, você pode criar suas próprias categorias! Clique no botão 'Personalizado' para criar ou selecionar categorias personalizadas",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Center(
                              child: Button(
                                  elevation: 5,
                                  buttonColor: ColorsApp.color1,
                                  onPressed: () {
                                    BackgroundMusicPlayer.loadMusic2();
                                    BackgroundMusicPlayer.playBackgroundMusic(
                                        2);
                                  },
                                  label: "Personalizado"),
                            ),
                            const SizedBox(height: 10),
                            Text(
                                "1.4 - Ao clica-lo, você verá suas opções personalizadas já criadas ou, caso você nunca tenha criado nenhuma, você pode criar clicando no botaão 'Adicionar listas'",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Center(
                              child: Button(
                                  elevation: 5,
                                  buttonColor: ColorsApp.color1,
                                  onPressed: () {
                                    BackgroundMusicPlayer.loadMusic2();
                                    BackgroundMusicPlayer.playBackgroundMusic(
                                        2);
                                  },
                                  label: "Adicionar listas"),
                            ),
                            const SizedBox(height: 10),
                            Text(
                                "1.5 - Quando digitado o nome da nova lista, você pode editá-la no botão de edicção no canto direito superior do botão da determinada categoria",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 10),
                            Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: categories.map((category) {
                                      return Stack(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Button(
                                                  elevation: 10,
                                                  buttonColor: ColorsApp.color1,
                                                  onPressed: () {
                                                    BackgroundMusicPlayer
                                                        .loadMusic2();
                                                    BackgroundMusicPlayer
                                                        .playBackgroundMusic(2);
                                                  },
                                                  label: category)),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  BackgroundMusicPlayer
                                                      .loadMusic2();
                                                  BackgroundMusicPlayer
                                                      .playBackgroundMusic(2);
                                                },
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color:
                                                            ColorsApp.color2),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ))),
                                              ))
                                        ],
                                      );
                                    }).toList()),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                                "1.6 - Ao clicar em editar, você verá todos os itens que já existem na lista, podendo apaga-los ou adicionar mais (caso tenha acabado de criar, ela vai vir vazia)",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 20),
                            Container(
                              color: ColorsApp.background,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 40, top: 40, left: 40),
                                          child: TextField(
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              labelText: 'Adicionar palavra',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              BackgroundMusicPlayer
                                                  .loadMusic2();
                                              BackgroundMusicPlayer
                                                  .playBackgroundMusic(2);
                                            },
                                            child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: ColorsApp.color2),
                                                child: const Center(
                                                    child: Icon(
                                                  Icons.add,
                                                  size: 30,
                                                  color: Colors.white,
                                                ))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Lista de palavras
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, bottom: 15, top: 15),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorsApp.color2,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(
                                            children: words.map((word) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListTile(
                                                  title: Text(
                                                    word,
                                                    style: GoogleFonts.girassol(
                                                      fontSize: 20,
                                                      textStyle: TextStyle(
                                                          color: ColorsApp
                                                              .letters),
                                                    ),
                                                  ),
                                                  trailing: IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      BackgroundMusicPlayer
                                                          .loadMusic2();
                                                      BackgroundMusicPlayer
                                                          .playBackgroundMusic(
                                                              2);
                                                    },
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                                "1.7 - Também é possível apagar a categoria ou voltar a tela de categorias salvando automaticamente as suas mudanças",
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CustomIconButton(
                                        elevation: 5,
                                        buttonColor: ColorsApp.color1,
                                        onPressed: () async {
                                          BackgroundMusicPlayer.loadMusic2();
                                          BackgroundMusicPlayer
                                              .playBackgroundMusic(2);
                                        },
                                        icon: Icons.arrow_back,
                                        padding: 0),
                                    Text("Botão de salvar e voltar",
                                        style: GoogleFonts.girassol(
                                            fontSize: 15,
                                            textStyle: TextStyle(
                                                color: ColorsApp.letters)))
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  children: [
                                    CustomIconButton(
                                        elevation: 5,
                                        buttonColor: ColorsApp.color1,
                                        onPressed: () async {
                                          BackgroundMusicPlayer.loadMusic2();
                                          BackgroundMusicPlayer
                                              .playBackgroundMusic(2);
                                        },
                                        icon: Icons.delete,
                                        padding: 0),
                                    Text("Botão de apagar",
                                        style: GoogleFonts.girassol(
                                            fontSize: 15,
                                            textStyle: TextStyle(
                                                color: ColorsApp.letters)))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                                "1.8 - Após configurar a partida de acordo com sua preferência, clique no botão 'Iniciar jogo' para começar",
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
