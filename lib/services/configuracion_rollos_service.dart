// Archivo: lib/services/configuracion_rollos_service.dart
// Servicio para leer y guardar la configuración de la calculadora de rollos.
// Usa SharedPreferencesAsync (API moderna, sin deprecaciones).

import 'package:shared_preferences/shared_preferences.dart';
import '../calculadora_logica.dart';

class ConfiguracionRollosService {
  static const _kDiametroNucleo = 'rollo_diametro_nucleo';
  static const _kCalibre = 'rollo_calibre_micras';
  static const _kRecorrido = 'rollo_recorrido_bultos';

  static const _kLong20 = 'rollo_long_20';
  static const _kLong25 = 'rollo_long_25';
  static const _kLong30 = 'rollo_long_30';
  static const _kLong40 = 'rollo_long_40';

  static const _kEstiba20 = 'rollo_estiba_20';
  static const _kEstiba25 = 'rollo_estiba_25';
  static const _kEstiba30 = 'rollo_estiba_30';
  static const _kEstiba40 = 'rollo_estiba_40';

  static Future<ConfiguracionRollos> cargar() async {
    final prefs = SharedPreferencesAsync();
    return ConfiguracionRollos(
      diametroNucleoCm:
          await prefs.getDouble(_kDiametroNucleo) ?? diametroNucleoCm,
      calibrePlasticoMicras:
          await prefs.getDouble(_kCalibre) ?? calibrePlasticoMicras,
      recorridoBultos: await prefs.getInt(_kRecorrido) ?? 20,
      longitudesPorFormato: {
        20: await prefs.getDouble(_kLong20) ?? longitudesPorFormato[20]!,
        25: await prefs.getDouble(_kLong25) ?? longitudesPorFormato[25]!,
        30: await prefs.getDouble(_kLong30) ?? longitudesPorFormato[30]!,
        40: await prefs.getDouble(_kLong40) ?? longitudesPorFormato[40]!,
      },
      bolsasPorEstibaPorFormato: {
        20: await prefs.getInt(_kEstiba20) ?? bolsasPorEstibaPorFormato[20]!,
        25: await prefs.getInt(_kEstiba25) ?? bolsasPorEstibaPorFormato[25]!,
        30: await prefs.getInt(_kEstiba30) ?? bolsasPorEstibaPorFormato[30]!,
        40: await prefs.getInt(_kEstiba40) ?? bolsasPorEstibaPorFormato[40]!,
      },
    );
  }

  static Future<void> guardar(ConfiguracionRollos config) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setDouble(_kDiametroNucleo, config.diametroNucleoCm);
    await prefs.setDouble(_kCalibre, config.calibrePlasticoMicras);
    await prefs.setInt(_kRecorrido, config.recorridoBultos);
    await prefs.setDouble(_kLong20, config.longitudesPorFormato[20]!);
    await prefs.setDouble(_kLong25, config.longitudesPorFormato[25]!);
    await prefs.setDouble(_kLong30, config.longitudesPorFormato[30]!);
    await prefs.setDouble(_kLong40, config.longitudesPorFormato[40]!);
    await prefs.setInt(_kEstiba20, config.bolsasPorEstibaPorFormato[20]!);
    await prefs.setInt(_kEstiba25, config.bolsasPorEstibaPorFormato[25]!);
    await prefs.setInt(_kEstiba30, config.bolsasPorEstibaPorFormato[30]!);
    await prefs.setInt(_kEstiba40, config.bolsasPorEstibaPorFormato[40]!);
  }

  static Future<void> restaurarDefectos() async {
    final prefs = SharedPreferencesAsync();
    for (final key in [
      _kDiametroNucleo, _kCalibre, _kRecorrido,
      _kLong20, _kLong25, _kLong30, _kLong40,
      _kEstiba20, _kEstiba25, _kEstiba30, _kEstiba40,
    ]) {
      await prefs.remove(key);
    }
  }
}

/// Modelo que agrupa todos los parámetros configurables del cálculo de rollos.
class ConfiguracionRollos {
  final double diametroNucleoCm;
  final double calibrePlasticoMicras;
  final int recorridoBultos;
  final Map<int, double> longitudesPorFormato;
  final Map<int, int> bolsasPorEstibaPorFormato;

  const ConfiguracionRollos({
    required this.diametroNucleoCm,
    required this.calibrePlasticoMicras,
    required this.recorridoBultos,
    required this.longitudesPorFormato,
    required this.bolsasPorEstibaPorFormato,
  });
}
