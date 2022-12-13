import 'package:calculadora_simples/res/strings.dart';
import 'package:calculadora_simples/res/temas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../botao_numero.dart';
import '../display.dart';

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
  String display = '';
  String numeroInicial = '';

  void inserirNumero(String char) {
    numeroInicial += char;
    setState(() {
      display = numeroInicial;
    });
  }

  void limparNumeros() {
    numeroInicial = '';
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
          child: const Text('L'),
          onPressed: limparNumeros,
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
                BotaoNumero(numero: '1', teclaApertada: inserirNumero,),
                BotaoNumero(numero: '2', teclaApertada: inserirNumero,),
                BotaoNumero(numero: '3', teclaApertada: inserirNumero,),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BotaoNumero(numero: '4', teclaApertada: inserirNumero,),
                BotaoNumero(numero: '5', teclaApertada: inserirNumero,),
                BotaoNumero(numero: '6', teclaApertada: inserirNumero,),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BotaoNumero(numero: '7', teclaApertada: inserirNumero,),
                BotaoNumero(numero: '8', teclaApertada: inserirNumero,),
                BotaoNumero(numero: '9', teclaApertada: inserirNumero,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


