import 'package:flutter_test/flutter_test.dart';
import 'package:simulador_frete/frete/strategy/frete_economico.dart';

void main() {
  late FreteEconomico strategy;

  setUp(() {
    strategy = FreteEconomico();
  });

  test('deve calcular frete considerando peso e distância', () {
    final resultado = strategy.calcular(
      peso: 2.0,
      distanciaKm: 100.0,
    );

    expect(resultado.valor, closeTo(22.0, 0.01));
  });

  test('deve calcular frete para peso mínimo', () {
    final resultado = strategy.calcular(
      peso: 1.0,
      distanciaKm: 100.0,
    );

    expect(resultado.valor, closeTo(20.0, 0.01));
  });

  test('deve aumentar o valor do frete quando o peso aumentar', () {
    final freteLeve = strategy.calcular(
      peso: 1.0,
      distanciaKm: 100.0,
    );

    final fretePesado = strategy.calcular(
      peso: 5.0,
      distanciaKm: 100.0,
    );

    expect(fretePesado.valor, greaterThan(freteLeve.valor));
  });

  test('deve aumentar o valor do frete quando a distância aumentar', () {
    final freteCurto = strategy.calcular(
      peso: 2.0,
      distanciaKm: 50.0,
    );

    final freteLongo = strategy.calcular(
      peso: 2.0,
      distanciaKm: 500.0,
    );

    expect(freteLongo.valor, greaterThan(freteCurto.valor));
  });

  test ('distancia negativa')
}
