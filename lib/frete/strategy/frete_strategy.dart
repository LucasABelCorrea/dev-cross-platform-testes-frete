import '../../model/resultado_frete.dart';

abstract class FreteStrategy {
  ResultadoFrete calcular({
    required double peso,
    required double distanciaKm,
  });
}
