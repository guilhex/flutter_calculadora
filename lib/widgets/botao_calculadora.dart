import 'package:flutter/material.dart';

class BotaoCalculadora extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final bool ehOperacao;

  const BotaoCalculadora({
    super.key,
    required this.texto,
    required this.onPressed,
    this.ehOperacao = false,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SizedBox(
          height: 70,
          child: FilledButton(
            onPressed: onPressed,
            style: ehOperacao
                ? null
                : FilledButton.styleFrom(
                    backgroundColor: cores.surfaceContainerHighest,
                    foregroundColor: cores.onSurface,
                  ),
            child: Text(texto, style: const TextStyle(fontSize: 26)),
          ),
        ),
      ),
    );
  }
}
