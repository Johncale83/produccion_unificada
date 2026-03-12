// lib/formula.dart

// ----------------------------------------------------------------------
// Clase auxiliar para manejar cada aditivo individualmente
// ----------------------------------------------------------------------
class Aditivo {
  final String nombre;
  final double cantidadKg;

  Aditivo({required this.nombre, required this.cantidadKg});
}

// ----------------------------------------------------------------------
// CLASE PRINCIPAL: Formula
// ----------------------------------------------------------------------

class Formula {
  final String referencia;
  final double pesoBaseKg = 2400.0;
  final double arenaAmarillaKg;
  final double arenaBlancaKg;
  final double cementoKg;

  final List<Aditivo> aditivos;

  Formula({
    required this.referencia,
    this.arenaAmarillaKg = 0.0,
    this.arenaBlancaKg = 0.0,
    required this.cementoKg,
    required this.aditivos,
  });

  Map<String, dynamic> calcularProporciones(double pesoDeseado) {
    double factorEscala = pesoDeseado / pesoBaseKg;

    // 1. Calcular Arena y Cemento
    double nuevaArenaAmarilla = arenaAmarillaKg * factorEscala;
    double nuevaArenaBlanca = arenaBlancaKg * factorEscala;
    double nuevoCemento = cementoKg * factorEscala;

    // 2. Calcular los Aditivos
    List<Map<String, dynamic>> nuevosAditivos = [];
    double totalAditivosKg = 0;

    for (var aditivo in aditivos) {
      double nuevaCantidad = aditivo.cantidadKg * factorEscala;
      totalAditivosKg += nuevaCantidad;

      nuevosAditivos.add({'nombre': aditivo.nombre, 'cantidad': nuevaCantidad});
    }

    double nuevoPesoTotal =
        nuevaArenaAmarilla + nuevaArenaBlanca + nuevoCemento + totalAditivosKg;

    // 3. Devolver los resultados
    return {
      'arena_amarilla': nuevaArenaAmarilla,
      'arena_blanca': nuevaArenaBlanca,
      'cemento': nuevoCemento,
      'aditivos_lista': nuevosAditivos,
      'peso_total': nuevoPesoTotal,
    };
  }
} // Fin de la clase Formula

// ----------------------------------------------------------------------
// Ejemplos de Fórmulas Base (Simulando una base de datos)
// ----------------------------------------------------------------------

List<Formula> formulasGrises = [
  // --------------------------------------------------------------------
  // FORMULAS GRISES (Terminadas en 1501)
  // --------------------------------------------------------------------
  Formula(
    referencia: '901301501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 4.56)],
  ),
  Formula(
    referencia: '903271501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 4.56)],
  ),
  Formula(
    referencia: '901311501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 4.56)],
  ),
  Formula(
    referencia: '902051501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 4.56)],
  ),
  Formula(
    referencia: '902071501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 4.56)],
  ),
  Formula(
    referencia: '901481501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 4.56)],
  ),
  Formula(
    referencia: '903201501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 4.56)],
  ),
  Formula(
    referencia: '901331501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 6.0),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2),
    ],
  ),
  Formula(
    referencia: '901351501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 6.0),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2),
    ],
  ),
  Formula(
    referencia: '901501501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 6.0),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2),
    ],
  ),
  Formula(
    referencia: '902031501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 6.0),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2),
    ],
  ),
  Formula(
    referencia: '903221501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 6.0),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2),
    ],
  ),
  Formula(
    referencia: '903281501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 6.0),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2),
    ],
  ),
  Formula(
    referencia: '901021501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1877.28,
    cementoKg: 504.0,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 6.72),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0),
    ],
  ),
  Formula(
    referencia: '901061501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1877.28,
    cementoKg: 504.0,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 6.72),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0),
    ],
  ),
  Formula(
    referencia: '901231501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1877.28,
    cementoKg: 504.0,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 6.72),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0),
    ],
  ),
  Formula(
    referencia: '901011501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1734.48,
    cementoKg: 600.0,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 7.2),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 21.6),
      Aditivo(nombre: 'Opagel', cantidadKg: 0.72),
      Aditivo(nombre: 'DLP 212', cantidadKg: 36.0),
    ],
  ),
  Formula(
    referencia: '901071501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1734.48,
    cementoKg: 600.0,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 7.2),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 21.6),
      Aditivo(nombre: 'Opagel', cantidadKg: 0.72),
      Aditivo(nombre: 'DLP 212', cantidadKg: 36.0),
    ],
  ),
  Formula(
    referencia: '901191501', // Verificada 2025-12-13//
    arenaBlancaKg: 1515.36,
    cementoKg: 624.0,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 6.0),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0),
      Aditivo(nombre: 'Opagel', cantidadKg: 1.2),
      Aditivo(nombre: 'Elotex ', cantidadKg: 96.0),
      Aditivo(nombre: 'Fortacret ', cantidadKg: 144.0),
      Aditivo(nombre: 'Melflux ', cantidadKg: 1.44),
    ],
  ),
  Formula(
    referencia: '901091501', // Verificada 2025-12-13//
    arenaAmarillaKg: 981.6,
    cementoKg: 720.0,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 7.2),
      Aditivo(nombre: 'DLP 2000', cantidadKg: 120.0),
      Aditivo(nombre: 'Formiato Calcio', cantidadKg: 12.0),
      Aditivo(nombre: 'Arena 1040', cantidadKg: 559.2),
    ],
  ),
  Formula(
    referencia: '901101501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1072.8,
    cementoKg: 720,
    aditivos: [
      Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 7.2),
      Aditivo(nombre: 'DLP 212', cantidadKg: 16.8),
      Aditivo(nombre: 'Formiato Calcio', cantidadKg: 12),
      Aditivo(nombre: 'Arena 1040', cantidadKg: 559.2),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12),
    ],
  ),
  Formula(
    referencia: '901131501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1084.8,
    cementoKg: 720,
    aditivos: [
      Aditivo(nombre: 'Wekcelo MP 150', cantidadKg: 7.2),
      Aditivo(nombre: 'DLP 212', cantidadKg: 16.8),
      Aditivo(nombre: 'Formiato Calcio', cantidadKg: 12),
      Aditivo(nombre: 'Arena 1040', cantidadKg: 559.2),
    ],
  ),
  Formula(
    referencia: '901151501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1884.48,
    cementoKg: 480,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 6.72),
      Aditivo(nombre: 'DLP 212', cantidadKg: 28.8),
    ],
  ),
  Formula(
    referencia: '901171501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1943.04,
    cementoKg: 432,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 5.76),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2),
    ],
  ),
  Formula(
    referencia: '903251501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1720.8,
    cementoKg: 624,
    aditivos: [
      Aditivo(nombre: 'Walocel 58150', cantidadKg: 7.2),
      Aditivo(nombre: 'DLP 212', cantidadKg: 48.0),
    ],
  ),
  Formula(
    referencia: '901161501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1889.28,
    cementoKg: 504.0,
    aditivos: [Aditivo(nombre: 'Walocel 58150', cantidadKg: 6.72)],
  ),
  Formula(
    referencia: '901391501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1889.28,
    cementoKg: 504.0,
    aditivos: [Aditivo(nombre: 'Walocel 58150', cantidadKg: 6.72)],
  ),
  Formula(
    referencia: '901431501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1889.28,
    cementoKg: 504.0,
    aditivos: [Aditivo(nombre: 'Walocel 58150', cantidadKg: 6.72)],
  ),
  Formula(
    referencia: '901521501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1754.4,
    cementoKg: 600.0,
    aditivos: [
      Aditivo(nombre: 'Wekcelo 58150', cantidadKg: 9.6),
      Aditivo(nombre: 'DLP 212', cantidadKg: 24.0),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0),
    ],
  ),
  Formula(
    referencia: '901411501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1931.04,
    cementoKg: 432.0,
    aditivos: [
      Aditivo(nombre: 'Wekcelo 58150', cantidadKg: 5.76),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2),
      Aditivo(
        nombre: 'Aglomerante',
        cantidadKg: 12.0,
      ), // Comprobar si lleva agua aditivada o no //
    ],
  ),
];
