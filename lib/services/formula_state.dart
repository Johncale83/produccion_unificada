import 'package:flutter/foundation.dart';
import 'package:produccion_unificada/models/isar_formula.dart';
import 'package:produccion_unificada/services/database_service.dart';

class FormulaState extends ChangeNotifier {
  List<IsarFormula> _formulas = [];
  List<IsarCatalogoAditivo> _aditivosCatalogo = [];
  bool _isLoading = false;

  List<IsarFormula> get formulas => _formulas;
  List<IsarCatalogoAditivo> get aditivosCatalogo => _aditivosCatalogo;
  bool get isLoading => _isLoading;

  Future<void> cargarFormulas() async {
    _isLoading = true;
    notifyListeners();
    
    _formulas = await DatabaseService.getAllFormulas();
    _aditivosCatalogo = await DatabaseService.getAditivosCatalogo();
    
    _isLoading = false;
    notifyListeners();
  }

  // Método para obtener el peso de bulto de un aditivo por su nombre
  double obtenerPesoBulto(String nombreAditivo) {
    // Normalizamos el nombre para la búsqueda
    final nombreLimpio = nombreAditivo.replaceAll('  • TOTAL ', '').replaceAll('  • ', '').trim();
    final aditivo = _aditivosCatalogo.where((a) => (a.nombre ?? '').trim() == nombreLimpio).firstOrNull;
    return aditivo?.pesoBulto ?? 25.0; // 25kg por defecto si no lo encuentra
  }

  Future<void> agregarFormula(IsarFormula formula) async {
    await DatabaseService.agregarFormula(formula);
    await cargarFormulas();
  }

  Future<void> eliminarFormula(int id) async {
    await DatabaseService.deleteFormula(id);
    await cargarFormulas();
  }

  Future<void> actualizarFormula(IsarFormula formula) async {
    await DatabaseService.agregarFormula(formula);
    await cargarFormulas();
  }
}

final formulaState = FormulaState();
