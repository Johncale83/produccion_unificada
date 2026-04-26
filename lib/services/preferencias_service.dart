import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasService {
  static SharedPreferences? _prefs;

  static const String _keyFormatoRollos = 'formato_rollos';
  static const String _keyUltimaFormula = 'ultima_formula';
  static const String _keyPesoDeseado = 'peso_deseado';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int get formatoRollos => _prefs?.getInt(_keyFormatoRollos) ?? 25;
  static set formatoRollos(int value) => _prefs?.setInt(_keyFormatoRollos, value);

  static String? get ultimaFormula => _prefs?.getString(_keyUltimaFormula);
  static set ultimaFormula(String? value) {
    if (value != null) {
      _prefs?.setString(_keyUltimaFormula, value);
    } else {
      _prefs?.remove(_keyUltimaFormula);
    }
  }

  static double get pesoDeseado => _prefs?.getDouble(_keyPesoDeseado) ?? 2400.0;
  static set pesoDeseado(double value) => _prefs?.setDouble(_keyPesoDeseado, value);
}
