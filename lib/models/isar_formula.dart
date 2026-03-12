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
  double? arenaBlancaKg;
  double? cementoKg;

  List<IsarAditivo>? aditivos;

  Map<String, dynamic> calcularProporciones(double pesoDeseado) {
    double base = pesoBaseKg ?? 2400.0;
    double factorEscala = base > 0 ? pesoDeseado / base : 0;

    // Calcular totales primero
    double arenaSilo1Total = (arenaSilo1Kg ?? 0.0) * factorEscala;
    double arenaSilo2Total = (arenaSilo2Kg ?? 0.0) * factorEscala;
    double arenaAmarillaTotal = arenaSilo1Total + arenaSilo2Total;
    
    double arenaBlancaTotal = (arenaBlancaKg ?? 0.0) * factorEscala;
    double cementoTotal = (cementoKg ?? 0.0) * factorEscala;

    // --- 1. Lógica de Silos para Arena Amarilla ---
    List<Map<String, dynamic>> arenaAmarillaDetalle = [];
    if (arenaSilo1Total > 0) {
      arenaAmarillaDetalle.add({'origen': 'Silo 1', 'cantidad': arenaSilo1Total});
    }
    if (arenaSilo2Total > 0) {
      arenaAmarillaDetalle.add({'origen': 'Silo 2', 'cantidad': arenaSilo2Total});
    }

    // --- 2. Lógica de Silos para Arena Blanca ---
    List<Map<String, dynamic>> arenaBlancaDetalle = [];
    if (arenaBlancaTotal > 0) {
      arenaBlancaDetalle.add({'origen': 'Silo 4', 'cantidad': arenaBlancaTotal});
    }

    // --- 3. Lógica de Silos para Cemento ---
    List<Map<String, dynamic>> cementoDetalle = [];
    if (cementoTotal > 0) {
      if (esBlanca == true) {
        // Cemento Blanco: Distribución (Por default todo al 7, a falta de regla específica)
        cementoDetalle.add({'origen': 'Silo 7', 'cantidad': cementoTotal});
        // Si hay regla para el Silo 8, se añadiría aquí.
      } else {
        // Cemento Gris
        cementoDetalle.add({'origen': 'Silo 3', 'cantidad': cementoTotal});
      }
    }

    // --- 4. Lógica para los Aditivos ---
    List<Map<String, dynamic>> nuevosAditivos = [];
    double totalAditivosKg = 0;

    if (aditivos != null) {
      for (var aditivo in aditivos!) {
        double nuevaCantidad = (aditivo.cantidadKg ?? 0.0) * factorEscala;
        totalAditivosKg += nuevaCantidad;

        nuevosAditivos.add({
          'nombre': aditivo.nombre ?? 'N/A',
          'origen': aditivo.origen ?? 'Sin Tolva Asignada',
          'cantidad': nuevaCantidad,
        });
      }
    }

    double nuevoPesoTotal =
        arenaAmarillaTotal + arenaBlancaTotal + cementoTotal + totalAditivosKg;

    // 5. Devolver los resultados con la nueva estructura
    return {
      'arena_amarilla_detalle': arenaAmarillaDetalle,
      'arena_blanca_detalle': arenaBlancaDetalle,
      'cemento_detalle': cementoDetalle,
      'aditivos_lista': nuevosAditivos,
      'peso_total': nuevoPesoTotal,
      
      // Mantenemos los totales planos de legado para la orden de producción por ahora
      'arena_amarilla_total_plano': arenaAmarillaTotal,
      'arena_blanca_total_plano': arenaBlancaTotal,
      'cemento_total_plano': cementoTotal,
      'aditivos_total_plano': totalAditivosKg,
    };
  }
}

@embedded
class IsarAditivo {
  String? nombre;
  double? cantidadKg;
  String? origen;
}

@collection
class IsarCatalogoAditivo {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? nombre;
}
