// Archivo: lib/services/configuracion_rollos_service.dart
// Servicio para leer y guardar la configuración de la calculadora de rollos.
// Usa SharedPreferencesAsync (API moderna, sin deprecaciones).

import 'package:shared_preferences/shared_preferences.dart';
import '../calculadora_logica.dart';

class ConfiguracionRollosService {
  static const _kDiametroNucleo = 'rollo_diametro_nucleo';
  static const _kCalibre = 'rollo_calibre_micras';

  // Longitudes
  static const _kLong10 = 'rollo_long_10';
  static const _kLong20 = 'rollo_long_20';
  static const _kLong25 = 'rollo_long_25';
  static const _kLong30 = 'rollo_long_30';
  static const _kLong40 = 'rollo_long_40';

  // Estibas
  static const _kEstiba10 = 'rollo_estiba_10';
  static const _kEstiba20 = 'rollo_estiba_20';
  static const _kEstiba25 = 'rollo_estiba_25';
  static const _kEstiba30 = 'rollo_estiba_30';
  static const _kEstiba40 = 'rollo_estiba_40';

  // Anchos
  static const _kAncho10 = 'rollo_ancho_10';
  static const _kAncho20 = 'rollo_ancho_20';
  static const _kAncho25 = 'rollo_ancho_25';
  static const _kAncho30 = 'rollo_ancho_30';
  static const _kAncho40 = 'rollo_ancho_40';

  static Future<ConfiguracionRollos> cargar() async {
    final prefs = SharedPreferencesAsync();
    return ConfiguracionRollos(
      diametroNucleoCm:
          await prefs.getDouble(_kDiametroNucleo) ?? diametroNucleoCm,
      calibrePlasticoMicras:
          await prefs.getDouble(_kCalibre) ?? calibrePlasticoMicras,
      longitudesPorFormato: {
        10: await prefs.getDouble(_kLong10) ?? longitudesPorFormato[10]!,
        20: await prefs.getDouble(_kLong20) ?? longitudesPorFormato[20]!,
        25: await prefs.getDouble(_kLong25) ?? longitudesPorFormato[25]!,
        30: await prefs.getDouble(_kLong30) ?? longitudesPorFormato[30]!,
        40: await prefs.getDouble(_kLong40) ?? longitudesPorFormato[40]!,
      },
      bolsasPorEstibaPorFormato: {
        10: await prefs.getInt(_kEstiba10) ?? bolsasPorEstibaPorFormato[10]!,
        20: await prefs.getInt(_kEstiba20) ?? bolsasPorEstibaPorFormato[20]!,
        25: await prefs.getInt(_kEstiba25) ?? bolsasPorEstibaPorFormato[25]!,
        30: await prefs.getInt(_kEstiba30) ?? bolsasPorEstibaPorFormato[30]!,
        40: await prefs.getInt(_kEstiba40) ?? bolsasPorEstibaPorFormato[40]!,
      },
      anchosPorFormato: {
        10: await prefs.getDouble(_kAncho10) ?? defaultAnchosPorFormato[10]!,
        20: await prefs.getDouble(_kAncho20) ?? defaultAnchosPorFormato[20]!,
        25: await prefs.getDouble(_kAncho25) ?? defaultAnchosPorFormato[25]!,
        30: await prefs.getDouble(_kAncho30) ?? defaultAnchosPorFormato[30]!,
        40: await prefs.getDouble(_kAncho40) ?? defaultAnchosPorFormato[40]!,
      },
    );
  }

  static Future<void> guardar(ConfiguracionRollos config) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setDouble(_kDiametroNucleo, config.diametroNucleoCm);
    await prefs.setDouble(_kCalibre, config.calibrePlasticoMicras);

    // Guardar mapas
    for (var f in [10, 20, 25, 30, 40]) {
      await prefs.setDouble('rollo_long_$f', config.longitudesPorFormato[f]!);
      await prefs.setInt('rollo_estiba_$f', config.bolsasPorEstibaPorFormato[f]!);
      await prefs.setDouble('rollo_ancho_$f', config.anchosPorFormato[f]!);
    }
  }

  static Future<void> restaurarDefectos() async {
    final prefs = SharedPreferencesAsync();
    final keys = [
      _kDiametroNucleo, _kCalibre,
      _kLong10, _kLong20, _kLong25, _kLong30, _kLong40,
      _kEstiba10, _kEstiba20, _kEstiba25, _kEstiba30, _kEstiba40,
      _kAncho10, _kAncho20, _kAncho25, _kAncho30, _kAncho40,
    ];
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}

/// Modelo que agrupa todos los parámetros configurables del cálculo de rollos.
class ConfiguracionRollos {
  final double diametroNucleoCm;
  final double calibrePlasticoMicras;
  final Map<int, double> longitudesPorFormato;
  final Map<int, int> bolsasPorEstibaPorFormato;
  final Map<int, double> anchosPorFormato;

  const ConfiguracionRollos({
    required this.diametroNucleoCm,
    required this.calibrePlasticoMicras,
    required this.longitudesPorFormato,
    required this.bolsasPorEstibaPorFormato,
    required this.anchosPorFormato,
  });
}
