import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/isar_formula.dart';
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

  static Future<void> seedInitialData() async {
    // Check if any formulas exist
    final count = await _isar.isarFormulas.count();
    
    // Check if white formulas exist specifically
    final countBlancas = await _isar.isarFormulas.filter().esBlancaEqualTo(true).count();
    
    // Check if Additive Catalog is empty
    final countCatalog = await _isar.isarCatalogoAditivos.count();

    if (countCatalog == 0) {
      final defaultCatalogs = [
        'Opagel', 'Melflux', 'DLP 212', 'Elotex', 'Wekcelo MP 150',
        'Walocel 58150', 'Aglomerante PDF', 'Fortacret', 'Formiato Calcio', 'Arena 1040'
      ];
      await _isar.writeTxn(() async {
        for (var name in defaultCatalogs) {
          await _isar.isarCatalogoAditivos.put(
            IsarCatalogoAditivo()..nombre = name
          );
        }
      });
    }

    if (count > 0 && countBlancas > 0) return;

    final List<IsarFormula> formulasToInsert = [];

    // Helper function to map Aditivo to IsarAditivo
    List<IsarAditivo> mapAditivos(List<Aditivo> source) {
      return source
          .map(
            (a) =>
                IsarAditivo()
                  ..nombre = a.nombre
                  ..cantidadKg = a.cantidadKg,
          )
          .toList();
    }

    // Seed Grises only if DB is empty
    if (count == 0) {
      for (var formula in formulasGrises) {
        formulasToInsert.add(
          IsarFormula()
            ..referencia = formula.referencia
            ..esBlanca = false
            ..pesoBaseKg = formula.pesoBaseKg
            ..arenaSilo1Kg = formula.arenaAmarillaKg > 1000 ? 1000.0 : formula.arenaAmarillaKg
            ..arenaSilo2Kg = formula.arenaAmarillaKg > 1000 ? formula.arenaAmarillaKg - 1000.0 : 0.0
            ..arenaBlancaKg = formula.arenaBlancaKg
            ..cementoKg = formula.cementoKg
            ..aditivos = mapAditivos(formula.aditivos),
        );
      }
    }

    // Seed Blancas if they are missing
    if (countBlancas == 0) {
      for (var formula in formulasBlancos) {
        formulasToInsert.add(
          IsarFormula()
            ..referencia = formula.referencia
            ..esBlanca = true
            ..pesoBaseKg = formula.pesoBaseKg
            ..arenaSilo1Kg = formula.arenaAmarillaKg
            ..arenaSilo2Kg = 0.0
            ..arenaBlancaKg = formula.arenaBlancaKg
            ..cementoKg = formula.cementoKg
            ..aditivos = mapAditivos(formula.aditivos),
        );
      }
    }

    if (formulasToInsert.isNotEmpty) {
      await _isar.writeTxn(() async {
        await _isar.isarFormulas.putAll(formulasToInsert);
      });
    }
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
        'arenaBlancaKg': f.arenaBlancaKg,
        'cementoKg': f.cementoKg,
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
                ..arenaBlancaKg = (item['arenaBlancaKg'] as num?)?.toDouble()
                ..cementoKg = (item['cementoKg'] as num?)?.toDouble()
                ..aditivos = isarAditivos;

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

  static Future<void> addAditivoCatalogo(String nombre) async {
    if (nombre.trim().isEmpty) return;
    
    final normalized = nombre.trim();
    final existing = await _isar.isarCatalogoAditivos
        .filter()
        .nombreEqualTo(normalized)
        .findFirst();

    if (existing == null) {
      await _isar.writeTxn(() async {
        await _isar.isarCatalogoAditivos.put(
          IsarCatalogoAditivo()..nombre = normalized,
        );
      });
    }
  }

  static Future<void> deleteAditivoCatalogo(int id) async {
    await _isar.writeTxn(() async {
      await _isar.isarCatalogoAditivos.delete(id);
    });
  }
}
