import 'package:isar/isar.dart';

part 'isar_formula.g.dart';

@collection
class IsarFormula {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? referencia;

  bool? esBlanca;
  double? pesoBaseKg;
  double? arenaSilo1Kg;
  double? arenaSilo2Kg;
  
  /// Arena blanca - campo principal
  double? arenaBlancaSilo4Kg;
  double? arenaSilo5Kg;
  double? cementoKg; // Silo 3 (Gris)
  
  /// Silos de Cemento Blanco
  double? cementoSilo7Kg;
  double? cementoSilo8Kg;

  List<IsarMaterialPrincipal>? materialesPrincipales;
  List<IsarAditivo>? aditivos;

  Map<String, dynamic> calcularProporciones(double pesoDeseado) {
    double base = pesoBaseKg ?? 2400.0;
    double factorEscala = base > 0 ? pesoDeseado / base : 0;

    // --- 1. Lógica para Materias Primas Principales (Consolidada y Dinámica) ---
    List<Map<String, dynamic>> principalesDetalle = [];
    
    if (materialesPrincipales != null && materialesPrincipales!.isNotEmpty) {
      for (var mat in materialesPrincipales!) {
        double cant = (mat.cantidadKg ?? 0.0) * factorEscala;
        if (cant <= 0) continue;
        
        // El origen ahora es simplemente el nombre (Clasificación) y el Silo entre paréntesis
        String nombreDisplay = mat.categoria ?? 'Materia Prima';
        String origen = '$nombreDisplay (${mat.nombre ?? 'Silo ?'})';

        principalesDetalle.add({'origen': origen, 'cantidad': cant});
      }
    } else {
      // MIGRACIÓN: Fallback para fórmulas antiguas con campos de silo individuales
      if ((arenaSilo1Kg ?? 0) > 0) principalesDetalle.add({'origen': 'Arena Amarilla (Silo 1)', 'cantidad': (arenaSilo1Kg ?? 0) * factorEscala});
      if ((arenaSilo2Kg ?? 0) > 0) principalesDetalle.add({'origen': 'Arena Amarilla (Silo 2)', 'cantidad': (arenaSilo2Kg ?? 0) * factorEscala});
      if ((arenaBlancaSilo4Kg ?? 0) > 0) principalesDetalle.add({'origen': 'Arena Blanca (Silo 4)', 'cantidad': (arenaBlancaSilo4Kg ?? 0) * factorEscala});
      if ((arenaSilo5Kg ?? 0) > 0) principalesDetalle.add({'origen': 'Arena Silice 10-40 (Silo 5)', 'cantidad': (arenaSilo5Kg ?? 0) * factorEscala});
      
      if (!(esBlanca ?? false)) {
        if ((cementoKg ?? 0) > 0) principalesDetalle.add({'origen': 'Cemento Gris (Silo 3)', 'cantidad': (cementoKg ?? 0) * factorEscala});
      } else {
        if ((cementoSilo7Kg ?? 0) > 0) principalesDetalle.add({'origen': 'Cemento Blanco (Silo 7)', 'cantidad': (cementoSilo7Kg ?? 0) * factorEscala});
        if ((cementoSilo8Kg ?? 0) > 0) principalesDetalle.add({'origen': 'Cemento Blanco (Silo 8)', 'cantidad': (cementoSilo8Kg ?? 0) * factorEscala});
      }
    }

    // --- 2. Lógica para los Aditivos ---
    List<Map<String, dynamic>> aditivosDetalle = [];
    double totalAditivosKg = 0;

    if (aditivos != null) {
      for (var aditivo in aditivos!) {
        double nuevaCantidad = (aditivo.cantidadKg ?? 0.0) * factorEscala;
        totalAditivosKg += nuevaCantidad;

        aditivosDetalle.add({
          'nombre': aditivo.nombre ?? 'N/A',
          'origen': aditivo.origen ?? 'Sin Tolva Asignada',
          'cantidad': nuevaCantidad,
        });
      }
    }

    // Calcular el peso total real sumando todos los componentes
    double totalPrincipalesKg = principalesDetalle.fold(0.0, (sum, item) => sum + (item['cantidad'] as double));
    double nuevoPesoTotal = totalPrincipalesKg + totalAditivosKg;

    return {
      'carga_principales_detalle': principalesDetalle,
      'carga_aditivos': aditivosDetalle,
      'peso_total': nuevoPesoTotal,
      'aditivos_total_plano': totalAditivosKg,
    };
  }
}

@embedded
class IsarMaterialPrincipal {
  String? nombre; // El Silo (ej: Silo 1)
  String? categoria; // La clasificación / Nombre libre (ej: Arena 1020)
  double? cantidadKg;
}

@embedded
class IsarAditivo {
  String? nombre;
  double? cantidadKg;
  String? origen;
}


