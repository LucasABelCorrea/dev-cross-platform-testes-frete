import 'package:flutter_test/flutter_test.dart';
import 'package:simulador_frete/frete/calculadora_frete.dart';
import 'package:simulador_frete/model/tipo_frete.dart';

void main() {
  final CalculadoraFrete calculadoraFrete = CalculadoraFrete();

  test("Frete econômico deve calcular valor pelo peso e pela distância", () {
    // ARRANGE
    const peso = 2.0;
    const distanciaKm = 100.0;
    const valorCompra = 1.0;

    // ACTION
    final resultado = calculadoraFrete.calcular(tipo: TipoFrete.economico, peso: peso, distanciaKm: distanciaKm, valorCompra: valorCompra);

    // ASSERT
    expect(resultado.valor, closeTo(22.0, 0.01)); //Esse closeTo serve para trabalhar com valores decimais
  });

  test("Frete expresso deve calcular valor pelo peso e pela distância", () {
    const peso = 2.0;
    const distanciaKm = 100.0;
    const valorCompra = 1.0;

    final resultado = calculadoraFrete.calcular(tipo: TipoFrete.expresso, peso: peso, distanciaKm: distanciaKm, valorCompra: valorCompra);

    expect(resultado.valor, closeTo(48.0, 0.01));

  });

  test("Peso zero deve gerar erro", () {
    expect(
      () => calculadoraFrete.calcular(tipo: TipoFrete.economico, peso: 0.0, distanciaKm: 100.0, valorCompra: 1.0),
      throwsArgumentError,
    );
  });

  test("Peso negativo deve gerar erro", () {
    expect(
      () => calculadoraFrete.calcular(tipo: TipoFrete.economico, peso: -10.0, distanciaKm: 100.0, valorCompra: 1.0),
      throwsArgumentError
      );
  });

  test("Distância zero deve gerar erro", () {
    expect(
      () => calculadoraFrete.calcular(
        tipo: TipoFrete.economico,
        peso: 2.0,
        distanciaKm: 0.0,
        valorCompra: 1.0
      ),
      throwsArgumentError,
    );
  });

  test("Compra de 299 deve cobrar o valor do frete", () {
    const peso = 2.0;
    const distanciaKm = 100.0;
    const valorCompra = 299.0;

    final resultado = calculadoraFrete.calcular(
      tipo: TipoFrete.economico,
      peso: peso,
      distanciaKm: distanciaKm,
      valorCompra: valorCompra
    );

    expect(resultado.valor, closeTo(22.0, 0.01));
  });
  test("Compra de 350 deve possuir frete gratis no economico", () {
    const peso = 2.0;
    const distanciaKm = 100.0;
    const valorCompra = 350.0;

    final resultado = calculadoraFrete.calcular(
      tipo: TipoFrete.economico,
      peso: peso,
      distanciaKm: distanciaKm,
      valorCompra: valorCompra
    );

    expect(resultado.valor, closeTo(0.0, 0.01));
  });
}