import 'package:flutter/material.dart';

class Visor extends StatelessWidget {
  final String texto;

  const Visor({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(16),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 56),
        maxLines: 1,
      ),
    );
  }
}
