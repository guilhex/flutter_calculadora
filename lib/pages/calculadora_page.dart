import 'package:flutter/material.dart';
import '../widgets/teclado.dart';
import '../widgets/visor.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String _visor = '0';
  double? _primeiroNumero;
  String? _operacao;
  bool _limparVisor = false;

  void _aoTocarTecla(String texto) {
    if ('+-×÷'.contains(texto)) {
      _escolherOperacao(texto);
    } else if (texto == '=') {
      setState(_calcular);
    } else {
      _digitar(texto);
    }
  }

  void _digitar(String digito) {
    setState(() {
      if (digito == '.') {
        if (_limparVisor) {
          _visor = '0.';
        } else if (!_visor.contains('.')) {
          _visor += '.';
        }
      } else if (_limparVisor || _visor == '0') {
        _visor = digito;
      } else {
        _visor += digito;
      }
      _limparVisor = false;
    });
  }

  void _escolherOperacao(String operacao) {
    if (_visor == 'Erro') return;
    setState(() {
      // se já existe uma operação pendente, resolve antes de seguir
      if (_operacao != null && !_limparVisor) {
        _calcular();
        if (_visor == 'Erro') return;
      }
      _primeiroNumero = double.parse(_visor);
      _operacao = operacao;
      _limparVisor = true;
    });
  }

  void _calcular() {
    if (_operacao == null || _primeiroNumero == null) return;

    final segundo = double.parse(_visor);
    double resultado = 0;

    switch (_operacao) {
      case '+':
        resultado = _primeiroNumero! + segundo;
        break;
      case '-':
        resultado = _primeiroNumero! - segundo;
        break;
      case '×':
        resultado = _primeiroNumero! * segundo;
        break;
      case '÷':
        if (segundo == 0) {
          _visor = 'Erro';
        } else {
          resultado = _primeiroNumero! / segundo;
        }
        break;
    }

    if (_visor != 'Erro') _visor = _formatar(resultado);
    _primeiroNumero = null;
    _operacao = null;
    _limparVisor = true;
  }

  String _formatar(double numero) {
    var texto = numero.toStringAsFixed(8);
    texto = texto.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    return texto;
  }

  void _limpar() {
    setState(() {
      _visor = '0';
      _primeiroNumero = null;
      _operacao = null;
      _limparVisor = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(child: Visor(texto: _visor)),
              Teclado(onTecla: _aoTocarTecla, onLimpar: _limpar),
            ],
          ),
        ),
      ),
    );
  }
}
