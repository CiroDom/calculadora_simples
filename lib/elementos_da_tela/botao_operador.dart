import 'package:flutter/material.dart';

typedef OperadorCallback = void Function(String);

class BotaoOperador extends StatelessWidget {
  const BotaoOperador({
    Key? key,
    required this.operador,
    required this.teclaApertada,
  }) : super(key: key);

  final String operador;
  final OperadorCallback teclaApertada;
  
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
          onPressed: () => teclaApertada(operador),
            icon: Icon(mapOperadorToIcon())
        )
    );
  }
}
