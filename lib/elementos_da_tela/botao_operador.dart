import 'package:flutter/material.dart';

typedef OperadorCallback = void Function(String);

class BotaoOperador extends StatelessWidget {
  const BotaoOperador({
    Key? key,
    required this.operador,
    required this.teclaApertada,
    required this. desabilitado,
  }) : super(key: key);

  final String operador;
  final OperadorCallback teclaApertada;
  final bool desabilitado;
  
  IconData? mapOperadorToIcon() {
    switch (operador) {
      case '+':
        return Icons.add;
      case '-':
        return Icons.remove;
      case 'x':
        return Icons.close;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: IconButton(
          onPressed: desabilitado ? null : () => teclaApertada(operador),
          icon: Icon(mapOperadorToIcon()),
          iconSize: 20.0,
        )
    );
  }
}
