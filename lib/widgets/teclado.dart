import 'package:flutter/material.dart';
import 'botao_calculadora.dart';

class Teclado extends StatelessWidget {
  final ValueChanged<String> onTecla;
  final VoidCallback onLimpar;

  const Teclado({super.key, required this.onTecla, required this.onLimpar});

  static const _linhas = [
    ['7', '8', '9', '÷'],
    ['4', '5', '6', '×'],
    ['1', '2', '3', '-'],
    ['0', '.', '=', '+'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final linha in _linhas)
          Row(
            children: [
              for (final texto in linha)
                BotaoCalculadora(
                  texto: texto,
                  ehOperacao: '+-×÷='.contains(texto),
                  onPressed: () => onTecla(texto),
                ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: OutlinedButton(
              onPressed: onLimpar,
              child: const Text('C', style: TextStyle(fontSize: 24)),
            ),
          ),
        ),
      ],
    );
  }
}
