// lib/formula.dart

// ----------------------------------------------------------------------
// Clase auxiliar para manejar cada aditivo individualmente
// ----------------------------------------------------------------------
class Aditivo {
  final String nombre;
  final double cantidadKg;
  final String? origen;

  Aditivo({required this.nombre, required this.cantidadKg, this.origen});
}

// ----------------------------------------------------------------------
// CLASE PRINCIPAL: Formula
// ----------------------------------------------------------------------

class Formula {
  final String referencia;
  final double pesoBaseKg = 2400.0;
  final double arenaAmarillaKg;
  final double arenaBlancaKg;
  final double arenaSiliceKg;
  final double cementoKg;

  final List<Aditivo> aditivos;

  Formula({
    required this.referencia,
    this.arenaAmarillaKg = 0.0,
    this.arenaBlancaKg = 0.0,
    this.arenaSiliceKg = 0.0,
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
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 4.56,
        origen: 'Minoritario 5',
      ),
    ],
  ),
  Formula(
    referencia: '903271501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 4.56,
        origen: 'Minoritario 5',
      ),
    ],
  ),
  Formula(
    referencia: '901311501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 4.56,
        origen: 'Minoritario 5',
      ),
    ],
  ),
  Formula(
    referencia: '902051501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 4.56,
        origen: 'Minoritario 5',
      ),
    ],
  ),
  Formula(
    referencia: '902071501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 4.56,
        origen: 'Minoritario 5',
      ),
    ],
  ),
  Formula(
    referencia: '901481501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 4.56,
        origen: 'Minoritario 5',
      ),
    ],
  ),
  Formula(
    referencia: '903201501', // Verificada 2025-12-13//
    arenaAmarillaKg: 2059.44,
    cementoKg: 336.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 4.56,
        origen: 'Minoritario 5',
      ),
    ],
  ),
  Formula(
    referencia: '901331501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 6.0,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '901351501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 6.0,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '901501501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 6.0,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '902031501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 6.0,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '903221501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 6.0,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '903281501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1918.8,
    cementoKg: 456.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 6.0,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '901021501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1877.28,
    cementoKg: 504.0,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 6.72,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0, origen: 'PDF'),
    ],
  ),
  Formula(
    referencia: '901061501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1877.28,
    cementoKg: 504.0,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 6.72,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0, origen: 'PDF'),
    ],
  ),
  Formula(
    referencia: '901231501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1877.28,
    cementoKg: 504.0,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 6.72,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0, origen: 'PDF'),
    ],
  ),
  Formula(
    referencia: '901011501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1734.48,
    cementoKg: 600.0,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 7.2,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 21.6, origen: 'PDF'),
      Aditivo(nombre: 'Opagel', cantidadKg: 0.72, origen: 'Minoritario 1'),
      Aditivo(nombre: 'DLP 212', cantidadKg: 36.0, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '901071501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1734.48,
    cementoKg: 600.0,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 7.2,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 21.6, origen: 'PDF'),
      Aditivo(nombre: 'Opagel', cantidadKg: 0.72, origen: 'Minoritario 1'),
      Aditivo(nombre: 'DLP 212', cantidadKg: 36.0, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '901191501', // Verificada 2025-12-13//
    arenaBlancaKg: 1515.36,
    cementoKg: 624.0,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 6.0,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0, origen: 'PDF'),
      Aditivo(nombre: 'Opagel', cantidadKg: 1.2, origen: 'Minoritario 1'),
      Aditivo(
        nombre: 'ELOTEX',
        cantidadKg: 96.0,
        origen: 'Minoritario 4',
      ),
      Aditivo(
        nombre: 'FORTACRET',
        cantidadKg: 144.0,
        origen: 'Tolva de Fibra',
      ),
      Aditivo(
        nombre: 'MELFLUX',
        cantidadKg: 1.44,
        origen: 'Minoritario 2',
      ),
    ],
  ),
  Formula(
    referencia: '901091501', // Verificada 2025-12-13//
    arenaAmarillaKg: 981.6,
    arenaSiliceKg: 559.2,
    cementoKg: 720.0,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 7.2,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 2000', cantidadKg: 120.0, origen: 'Minoritario 4'),
      Aditivo(
        nombre: 'Formiato Calcio',
        cantidadKg: 12.0,
        origen: 'Minoritario 2',
      ),
    ],
  ),
  Formula(
    referencia: '901101501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1072.8,
    arenaSiliceKg: 559.2,
    cementoKg: 720,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 7.2,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 16.8, origen: 'Minoritario 4'),
      Aditivo(
        nombre: 'Formiato Calcio',
        cantidadKg: 12,
        origen: 'Minoritario 2',
      ),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12, origen: 'PDF'),
    ],
  ),
  Formula(
    referencia: '901111501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1072.8,
    arenaSiliceKg: 559.2,
    cementoKg: 720,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 7.2,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 16.8, origen: 'Minoritario 4'),
      Aditivo(
        nombre: 'Formiato Calcio',
        cantidadKg: 12,
        origen: 'Minoritario 2',
      ),
    ],
  ),
  Formula(
    referencia: '901131501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1084.8,
    arenaSiliceKg: 559.2,
    cementoKg: 720,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 7.2,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 16.8, origen: 'Minoritario 4'),
      Aditivo(
        nombre: 'Formiato Calcio',
        cantidadKg: 12,
        origen: 'Minoritario 2',
      ),
    ],
  ),
  Formula(
    referencia: '901151501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1884.48,
    cementoKg: 480,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 6.72,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 28.8, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '901171501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1943.04,
    cementoKg: 432,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 5.76,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 19.2, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '903251501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1720.8,
    cementoKg: 624,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 7.2,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 48.0, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '901161501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1889.28,
    cementoKg: 504.0,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 6.72,
        origen: 'Minoritario 5',
      ),
    ],
  ),
  Formula(
    referencia: '901391501', // NUEVA FORM. Verificada Imagen
    arenaAmarillaKg: 1877.28,
    cementoKg: 504.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 6.72,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 12.0, origen: 'Minoritario 4'),
    ],
  ),
  Formula(
    referencia: '901431501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1889.28,
    cementoKg: 504.0,
    aditivos: [
      Aditivo(
        nombre: 'Walocel',
        cantidadKg: 6.72,
        origen: 'Minoritario 5',
      ),
    ],
  ),
  Formula(
    referencia: '901521501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1754.4,
    cementoKg: 600.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 9.6,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 24.0, origen: 'Minoritario 4'),
      Aditivo(nombre: 'Aglomerante', cantidadKg: 12.0, origen: 'PDF'),
    ],
  ),
  Formula(
    referencia: '901411501', // Verificada 2025-12-13//
    arenaAmarillaKg: 1756.8,
    cementoKg: 600.0,
    aditivos: [
      Aditivo(
        nombre: 'WEKCELO',
        cantidadKg: 7.2,
        origen: 'Minoritario 5',
      ),
      Aditivo(nombre: 'DLP 212', cantidadKg: 36, origen: 'Minoritario 4'),
    ],
  ),
];
