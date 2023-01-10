import 'package:calculadora_simples/res/strings.dart';
import 'package:calculadora_simples/res/temas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../elementos_da_tela/botao_numero.dart';
import '../elementos_da_tela/botao_operador.dart';
import '../elementos_da_tela/display.dart';

void main() => runApp(Application());

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  ThemeMode themeModeSelecionado = ThemeMode.light;

  void alternarTema() {
    setState(() {
      themeModeSelecionado = themeModeSelecionado == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.nome_do_app,
      themeMode: themeModeSelecionado,
      theme: Temas.modo_light,
      darkTheme: Temas.modo_dark,
      home: CalcSimples(themeModeApertado: alternarTema,),
    );
  }
}

class CalcSimples extends StatefulWidget {
  const CalcSimples({
    super.key,
    required this.themeModeApertado,
  });

  final VoidCallback themeModeApertado;

  @override
  State<CalcSimples> createState() => _CalcSimplesState();
}

class _CalcSimplesState extends State<CalcSimples> {
  static const operadores = ['+', '-', 'x'];

  String display = '';
  String primeiroNumero = '';
  String segundoNumero = '';
  String operador = '';
  double progresso = 0.0;
  bool desabilitarBotaoOperador = false;

  void inserir(String char) {
    if (char == '0') {
      if (operador.isEmpty && primeiroNumero.isEmpty) return;
      if (operador.isNotEmpty && segundoNumero.isEmpty) return;
    }

    if (operadores.contains(char)) {
      if (primeiroNumero.isEmpty) {
        primeiroNumero = '0';
      }
      operador = char;
    }
    else {
      if (operador.isEmpty) {
        primeiroNumero += char;
      }
      else {
        segundoNumero += char;
      }

      setState(() {
        if (operador.isEmpty) {
          display = primeiroNumero;
          progresso = 0.33;
        }
        else {
          if (segundoNumero.isEmpty) {
            display = '$primeiroNumero $operador';
            progresso = 0.66;
          }
          else {
            display = '$primeiroNumero $operador $segundoNumero';
            progresso = 1;
            desabilitarBotaoOperador = true;
          }
        }
      });
    }
  }

  void calcular() {
    final int numero1 = int.parse(primeiroNumero);
    final int numero2 = int.parse(segundoNumero);
    int resultado = 0;

    switch (operador) {
      case '+':
        resultado = numero1 + numero2;
        break;

      case '-':
        resultado = numero1 - numero2;
        break;

      case 'x':
        resultado = numero1 * numero2;
        break;
    }
    primeiroNumero = resultado.toString();
    segundoNumero = '';
    operador = '';

    setState((){
      display = resultado.toString();
      progresso = 0.33;
      desabilitarBotaoOperador = false;
    });
  }

  void limparDisplay() {
    operador = '';
    primeiroNumero = '';
    segundoNumero = '';
    setState(() {
      display = '0';
      progresso = 0.0;
      desabilitarBotaoOperador = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: FloatingActionButton(
          elevation: 10.0,
          child: const Text('C'),
          onPressed: limparDisplay,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

      appBar: AppBar(
        title: const Text(Strings.nome_do_app),
        actions: [
          IconButton(
              onPressed: widget.themeModeApertado,
              icon: Icon(
                tema.brightness == Brightness.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Display(display: display),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 20.0),
            child: Center(
              child: LinearProgressIndicator(
                backgroundColor: tema.scaffoldBackgroundColor,
                value: progresso,
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BotaoNumero(numero: '1', teclaApertada: inserir,),
                BotaoNumero(numero: '2', teclaApertada: inserir,),
                BotaoNumero(numero: '3', teclaApertada: inserir,),
                BotaoOperador(
                    operador: operadores[0],
                    teclaApertada: inserir,
                    desabilitado: desabilitarBotaoOperador,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BotaoNumero(numero: '4', teclaApertada: inserir,),
                BotaoNumero(numero: '5', teclaApertada: inserir,),
                BotaoNumero(numero: '6', teclaApertada: inserir,),
                BotaoOperador(
                    operador: operadores[1],
                    teclaApertada: inserir,
                    desabilitado: desabilitarBotaoOperador,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BotaoNumero(numero: '7', teclaApertada: inserir,),
                BotaoNumero(numero: '8', teclaApertada: inserir,),
                BotaoNumero(numero: '9', teclaApertada: inserir,),
                BotaoOperador(
                    operador: operadores[2],
                    teclaApertada: inserir,
                    desabilitado: desabilitarBotaoOperador,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    flex: 3,
                    child: TextButton(
                      child: Text('0'),
                      onPressed: () => inserir('0'),
                    )
                ),
                Expanded(
                    child: OutlinedButton(
                        child: Text('='),
                        onPressed: calcular,
                    ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



