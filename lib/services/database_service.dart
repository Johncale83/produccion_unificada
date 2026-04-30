import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/isar_formula.dart';
import '../models/isar_catalogo_aditivo.dart';
import '../formula.dart';
import '../formulas_blancos.dart';

class DatabaseService {
  static late Isar _isar;
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [IsarFormulaSchema, IsarCatalogoAditivoSchema],
      directory: dir.path,
    );
    _isInitialized = true;
    await seedInitialData();
  }

  static Future<int> seedInitialData({bool force = false}) async {
    // Check if any formulas exist
    final count = await _isar.isarFormulas.count();
    
    // Check if white formulas exist specifically
    final countBlancas = await _isar.isarFormulas.filter().esBlancaEqualTo(true).count();
    
    // Check if Additive Catalog is empty
    final countCatalog = await _isar.isarCatalogoAditivos.count();

    if (countCatalog == 0) {
      final defaultCatalogs = [
        {'nombre': 'Opagel CMT', 'origen': 'Minoritario 1', 'peso': 25.0},
        {'nombre': 'MELFLUX 5581', 'origen': 'Minoritario 2', 'peso': 25.0},
        {'nombre': 'Formiato Calcio', 'origen': 'Minoritario 2', 'peso': 25.0},
        {'nombre': 'DLP 212', 'origen': 'Minoritario 4', 'peso': 20.0},
        {'nombre': 'DLP 2000', 'origen': 'Minoritario 4', 'peso': 20.0},
        {'nombre': 'ELOTEX FX 1000', 'origen': 'Minoritario 6', 'peso': 25.0},
        {'nombre': 'WEKCELO MP 150', 'origen': 'Minoritario 5', 'peso': 25.0},
        {'nombre': 'Walocel WL VP-M-58150', 'origen': 'Minoritario 5', 'peso': 25.0},
        {'nombre': 'Aglomerante', 'origen': 'PDF', 'peso': 25.0},
        {'nombre': 'FORTACRET 1D', 'origen': 'Tolva de Fibra', 'peso': 25.0},
      ];
      await _isar.writeTxn(() async {
        for (var item in defaultCatalogs) {
          await _isar.isarCatalogoAditivos.put(
            IsarCatalogoAditivo()
              ..nombre = item['nombre'] as String
              ..origen = item['origen'] as String
              ..pesoBulto = item['peso'] as double
          );
        }
      });
    }

    // Limpieza de aditivos antiguos (Arena)
    await _isar.writeTxn(() async {
      await _isar.isarCatalogoAditivos.filter()
          .nombreContains('Arena')
          .deleteFirst();
    });

    if (!force && count > 0 && countBlancas > 0) {
      // Si ya hay datos, aseguramos que no haya nulos en esBlanca para evitar que desaparezcan de la UI
      final nulos = await _isar.isarFormulas.filter().esBlancaIsNull().findAll();
      if (nulos.isNotEmpty) {
        await _isar.writeTxn(() async {
          for (var f in nulos) {
            f.esBlanca = false;
            await _isar.isarFormulas.put(f);
          }
        });
      }
      return countBlancas;
    }

    final List<IsarFormula> formulasToInsert = [];

    // Helper function to map Aditivo to IsarAditivo
    List<IsarAditivo> mapAditivos(List<Aditivo> source) {
      return source
          .map(
            (a) =>
                IsarAditivo()
                  ..nombre = a.nombre
                  ..cantidadKg = a.cantidadKg
                  ..origen = a.origen,
          )
          .toList();
    }

    // Seed Grises if forced or if DB is empty
    if (force || count == 0) {
      for (var formula in formulasGrises) {
        formulasToInsert.add(
          IsarFormula()
            ..referencia = formula.referencia
            ..esBlanca = false
            ..pesoBaseKg = formula.pesoBaseKg
            ..materialesPrincipales = [
              if (formula.arenaAmarillaKg > 0)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 1'
                  ..categoria = 'Arena Amarilla'
                  ..cantidadKg = formula.arenaAmarillaKg > 1000 ? 1000.0 : formula.arenaAmarillaKg,
              if (formula.arenaAmarillaKg > 1000)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 2'
                  ..categoria = 'Arena Amarilla'
                  ..cantidadKg = formula.arenaAmarillaKg - 1000.0,
              if (formula.arenaBlancaKg > 0)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 4'
                  ..categoria = 'Arena Blanca'
                  ..cantidadKg = formula.arenaBlancaKg,
              if (formula.arenaSiliceKg > 0)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 5'
                  ..categoria = 'Arena Silice 10-40'
                  ..cantidadKg = formula.arenaSiliceKg,
              if (formula.cementoKg > 0)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 3'
                  ..categoria = 'Cemento Gris'
                  ..cantidadKg = formula.cementoKg,
            ]
            ..aditivos = mapAditivos(formula.aditivos),
        );
      }
    }

    // Seed Blancas if forced or if they are missing
    if (force || countBlancas == 0) {
      for (var formula in formulasBlancos) {
        formulasToInsert.add(
          IsarFormula()
            ..referencia = formula.referencia
            ..esBlanca = true
            ..pesoBaseKg = formula.pesoBaseKg
            ..materialesPrincipales = [
              if (formula.arenaAmarillaKg > 0)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 1'
                  ..categoria = 'Arena Amarilla'
                  ..cantidadKg = formula.arenaAmarillaKg,
              if (formula.arenaBlancaKg > 0)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 4'
                  ..categoria = 'Arena Blanca'
                  ..cantidadKg = formula.arenaBlancaKg,
              if (formula.arenaSiliceKg > 0)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 5'
                  ..categoria = 'Arena Silice 10-40'
                  ..cantidadKg = formula.arenaSiliceKg,
              if (formula.cementoKg > 0)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 7'
                  ..categoria = 'Cemento Blanco'
                  ..cantidadKg = formula.cementoKg > 350 ? 350.0 : formula.cementoKg,
              if (formula.cementoKg > 350)
                IsarMaterialPrincipal()
                  ..nombre = 'Silo 8'
                  ..categoria = 'Cemento Blanco'
                  ..cantidadKg = formula.cementoKg - 350.0,
            ]
            ..aditivos = mapAditivos(formula.aditivos),
        );
      }
    }

    if (formulasToInsert.isNotEmpty) {
      await _isar.writeTxn(() async {
        if (force) {
          // Si es forzado, borramos todo lo anterior para asegurar limpieza total
          await _isar.isarFormulas.clear();
        }
        await _isar.isarFormulas.putAllByReferencia(formulasToInsert);
      });
    }

    final finalCountBlancas = await _isar.isarFormulas.filter().esBlancaEqualTo(true).count();
    return finalCountBlancas;
  }

  static Future<List<IsarFormula>> getFormulas(bool esBlanca) async {
    return await _isar.isarFormulas
        .filter()
        .esBlancaEqualTo(esBlanca)
        .findAll();
  }

  static Future<List<IsarFormula>> getAllFormulas() async {
    return await _isar.isarFormulas.where().findAll();
  }

  static Future<void> agregarFormula(IsarFormula formula) async {
    await _isar.writeTxn(() async {
      await _isar.isarFormulas.put(formula);
    });
  }

  static Future<void> deleteFormula(int id) async {
    await _isar.writeTxn(() async {
      await _isar.isarFormulas.delete(id);
    });
  }

  static Future<String> exportarDatosJson() async {
    final formulas = await getAllFormulas();
    List<Map<String, dynamic>> jsonData = formulas.map((f) {
      return {
        'referencia': f.referencia,
        'esBlanca': f.esBlanca,
        'pesoBaseKg': f.pesoBaseKg,
        'arenaSilo1Kg': f.arenaSilo1Kg,
        'arenaSilo2Kg': f.arenaSilo2Kg,
        'arenaBlancaSilo4Kg': f.arenaBlancaSilo4Kg,
        'cementoKg': f.cementoKg,
        'cementoSilo7Kg': f.cementoSilo7Kg,
        'cementoSilo8Kg': f.cementoSilo8Kg,
        'aditivos': f.aditivos?.map((a) => {
          'nombre': a.nombre,
          'cantidadKg': a.cantidadKg,
          'origen': a.origen,
        }).toList(),
      };
    }).toList();

    return jsonEncode(jsonData);
  }

  static Future<int> importarDatosJson(String jsonString) async {
    try {
      final List<dynamic> decodedList = jsonDecode(jsonString);
      int formulasRecuperadas = 0;

      await _isar.writeTxn(() async {
        for (var item in decodedList) {
          if (item is Map<String, dynamic>) {
            final String referencia = item['referencia'] ?? '';
            // Verificamos que no exista otra fórmula con la misma referencia
            final existente = await _isar.isarFormulas.filter().referenciaEqualTo(referencia).findFirst();

            if (existente == null && referencia.isNotEmpty) {
              final List<dynamic>? aditivosList = item['aditivos'];
              List<IsarAditivo> isarAditivos = [];

              if (aditivosList != null) {
                isarAditivos = aditivosList.map((a) {
                  return IsarAditivo()
                    ..nombre = a['nombre']
                    ..cantidadKg = (a['cantidadKg'] as num?)?.toDouble()
                    ..origen = a['origen'];
                }).toList();
              }

              var legacyArena = (item['arenaAmarillaKg'] as num?)?.toDouble();
              var newSilo1 = (item['arenaSilo1Kg'] as num?)?.toDouble() ?? 0.0;
              var newSilo2 = (item['arenaSilo2Kg'] as num?)?.toDouble() ?? 0.0;
              
              if (legacyArena != null && legacyArena > 0) {
                 newSilo1 = legacyArena > 1000 ? 1000.0 : legacyArena;
                 newSilo2 = legacyArena > 1000 ? legacyArena - 1000.0 : 0.0;
              }

              final nuevaFormula = IsarFormula()
                ..referencia = referencia
                ..esBlanca = item['esBlanca'] as bool?
                ..pesoBaseKg = (item['pesoBaseKg'] as num?)?.toDouble()
                ..arenaSilo1Kg = newSilo1
                ..arenaSilo2Kg = newSilo2
                ..arenaBlancaSilo4Kg = (item['arenaBlancaSilo4Kg'] as num? ?? item['arenaBlancaKg'] as num?)?.toDouble()
                ..cementoKg = (item['cementoKg'] as num?)?.toDouble()
                ..cementoSilo7Kg = (item['cementoSilo7Kg'] as num?)?.toDouble()
                ..cementoSilo8Kg = (item['cementoSilo8Kg'] as num?)?.toDouble()
                ..aditivos = isarAditivos;
              
              // Migración de legado para blancas: si cementoKg tiene valor pero los nuevos silos no, mover a Silo 7
              if (nuevaFormula.esBlanca == true && 
                  (nuevaFormula.cementoKg ?? 0) > 0 && 
                  (nuevaFormula.cementoSilo7Kg ?? 0) == 0 && 
                  (nuevaFormula.cementoSilo8Kg ?? 0) == 0) {
                nuevaFormula.cementoSilo7Kg = nuevaFormula.cementoKg;
                nuevaFormula.cementoKg = 0.0;
              }

              await _isar.isarFormulas.put(nuevaFormula);
              formulasRecuperadas++;
            }
          }
        }
      });
      
      return formulasRecuperadas;
    } catch (e) {
      throw Exception('El archivo JSON no es válido o está corrupto: $e');
    }
  }

  // --- MÉTODOS PARA CATÁLOGO DE ADITIVOS ---

  static Future<List<IsarCatalogoAditivo>> getAditivosCatalogo() async {
    return await _isar.isarCatalogoAditivos.where().findAll();
  }

  static Future<void> addAditivoCatalogo(String nombre, {String? origen, double? pesoBulto}) async {
    final normalized = nombre.trim();
    if (normalized.isEmpty) return;
    
    await _isar.writeTxn(() async {
      final existing = await _isar.isarCatalogoAditivos
          .filter()
          .nombreEqualTo(normalized, caseSensitive: false)
          .findFirst();

      if (existing != null) {
        // Si existe, actualizamos sus datos
        existing.origen = origen?.trim();
        existing.pesoBulto = pesoBulto ?? 25.0;
        await _isar.isarCatalogoAditivos.put(existing);
      } else {
        // Si no existe, creamos uno nuevo
        await _isar.isarCatalogoAditivos.put(
          IsarCatalogoAditivo()
            ..nombre = normalized
            ..origen = origen?.trim()
            ..pesoBulto = pesoBulto ?? 25.0,
        );
      }
    });
  }
 
  static Future<void> updateAditivoCatalogo(Id id, String nombre, String? origen, double? pesoBulto) async {
    await _isar.writeTxn(() async {
      // Creamos un objeto nuevo con el mismo ID para forzar el reemplazo total
      final aditivoActualizado = IsarCatalogoAditivo()
        ..id = id
        ..nombre = nombre.trim()
        ..origen = origen?.trim()
        ..pesoBulto = pesoBulto;
        
      await _isar.isarCatalogoAditivos.put(aditivoActualizado);
    });
  }

  static Future<void> deleteAditivoCatalogo(Id id) async {
    await _isar.writeTxn(() async {
      await _isar.isarCatalogoAditivos.delete(id);
    });
  }
}
