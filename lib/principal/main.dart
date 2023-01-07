import 'package:calculadora_simples/res/strings.dart';
import 'package:calculadora_simples/res/temas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../elementos_da_tela/botao_numero.dart';
import '../elementos_da_tela/botao_operador.dart';
import '../elementos_da_tela/display.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: Strings.nome_do_app,
      theme: Temas.modo_light,
      darkTheme: Temas.modo_dark,

      home: const CalcSimples(),
    );
  }
}

class CalcSimples extends StatefulWidget {
  const CalcSimples({super.key});

  @override
  State<CalcSimples> createState() => _CalcSimplesState();
}

class _CalcSimplesState extends State<CalcSimples> {
  static const operadores = ['+', '-', 'x'];

  String display = '';
  String primeiroNumero = '';
  String segundoNumero = '';
  String operador = '';

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
        }
        else {
          if (segundoNumero.isEmpty) {
            display = '$primeiroNumero $operador';
          }
          else {
            display = '$primeiroNumero $operador $segundoNumero';
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
    });
  }

  void limparDisplay() {
    operador = '';
    primeiroNumero = '';
    segundoNumero = '';
    setState(() {
      display = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      backgroundColor: tema.colorScheme.primary,

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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Display(display: display),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BotaoNumero(numero: '1', teclaApertada: inserir,),
                BotaoNumero(numero: '2', teclaApertada: inserir,),
                BotaoNumero(numero: '3', teclaApertada: inserir,),
                BotaoOperador(operador: operadores[0], teclaApertada: inserir),
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
                BotaoOperador(operador: operadores[1], teclaApertada: inserir),
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
                BotaoOperador(operador: operadores[2], teclaApertada: inserir),
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



