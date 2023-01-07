import 'package:flutter/material.dart';

typedef NumeroCallback = void Function(String);

class BotaoNumero extends StatelessWidget {
  const BotaoNumero({
    Key? key,
    required this.numero,
    required this.teclaApertada,
  }) : super(key: key);

  final String numero;
  final NumeroCallback teclaApertada;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
          onPressed: () => teclaApertada(numero),
          child: Text(
            numero,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
      ),
    );
  }
}