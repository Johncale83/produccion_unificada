// Archivo: lib/calculadora_proporciones_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calproind/models/isar_formula.dart';
import 'package:calproind/services/preferencias_service.dart';
import 'package:calproind/services/formula_state.dart';
import 'package:calproind/constants.dart';

class CalculadoraProporcionesScreen extends StatefulWidget {
  const CalculadoraProporcionesScreen({super.key});

  @override
  State<CalculadoraProporcionesScreen> createState() =>
      _CalculadoraProporcionesScreenState();
}

class _CalculadoraProporcionesScreenState
    extends State<CalculadoraProporcionesScreen> {
  Map<String, dynamic>? _resultadoCalculo;
  String _mensajeError = '';

  List<IsarFormula> _formulas = [];
  IsarFormula? _formulaSeleccionada;
  TextEditingController? _autoCompleteController;

  final TextEditingController _pesoDeseadoController = TextEditingController();
  final TextEditingController _kgOrdenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pesoDeseadoController.text = PreferenciasService.pesoDeseado.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cargarFormulas();
      _cargarUltimaFormula();
    });
  }

  void _cargarFormulas() {
    if (!mounted) return;
    final formulaState = Provider.of<FormulaState>(context, listen: false);
    setState(() {
      _formulas = formulaState.formulas;
      
      // Actualizar la fórmula seleccionada si ya existía una
      if (_formulaSeleccionada != null) {
        _formulaSeleccionada = _formulas.where((f) => f.id == _formulaSeleccionada!.id).firstOrNull 
            ?? _formulas.where((f) => f.referencia == _formulaSeleccionada!.referencia).firstOrNull;
      }
    });
  }

  Future<void> _cargarUltimaFormula() async {
    final refGuardada = PreferenciasService.ultimaFormula;
    if (refGuardada != null) {
      final formulas = Provider.of<FormulaState>(context, listen: false).formulas;
      final formula = formulas.where((f) => f.referencia == refGuardada).firstOrNull;
      if (formula != null && mounted) {
        setState(() {
          _formulaSeleccionada = formula;
          _autoCompleteController?.text = refGuardada;
        });
      }
    }
  }

  void _limpiarDatos() {
    setState(() {
      _autoCompleteController?.clear();
      _formulaSeleccionada = null;
      _pesoDeseadoController.clear();
      _kgOrdenController.clear();
      _resultadoCalculo = null;
      _mensajeError = '';
    });
  }

  Future<void> _calcularProporciones() async {
    FocusScope.of(context).unfocus();

    final pesoDeseado = double.tryParse(_pesoDeseadoController.text.trim()) ?? 2400.0;
    PreferenciasService.pesoDeseado = pesoDeseado;

    setState(() {
      _resultadoCalculo = null;
      _mensajeError = '';
    });

    // Obtener la versión más reciente de la fórmula de la base de datos
    if (_formulaSeleccionada != null) {
      final formulasRecientes = Provider.of<FormulaState>(context, listen: false).formulas;
      _formulaSeleccionada = formulasRecientes
          .where((f) => f.id == _formulaSeleccionada!.id)
          .firstOrNull ?? _formulaSeleccionada;
    }

    // Usar la fórmula seleccionada
    final formulaBase = _formulaSeleccionada;
    if (formulaBase == null) {
      setState(() {
        _mensajeError = 'Seleccione una fórmula de la lista antes de calcular.';
      });
      return;
    }

    final double pesoCarga =
        double.tryParse(_pesoDeseadoController.text.trim()) ?? 2400.0;
    final double? kgTotalesOrden = double.tryParse(
      _kgOrdenController.text.trim(),
    );

    // VALIDACIÓN CLAVE
    final maxPeso = formulaBase.pesoBaseKg ?? 2400.0;
    if (pesoCarga <= 0 || pesoCarga > maxPeso) {
      setState(() {
        _mensajeError =
            'Error: El peso de carga debe ser positivo y no exceder ${maxPeso.toStringAsFixed(0)} kg.';
      });
      return;
    }

    // 3. CÁLCULO DE LA CARGA INDIVIDUAL
    final Map<String, dynamic> resultadosPorCarga = formulaBase
        .calcularProporciones(pesoCarga);
    final double pesoRealPorCarga = resultadosPorCarga['peso_total'] as double;

    // 4. CÁLCULO DE LA ORDEN DE PRODUCCIÓN COMPLETA
    List<Map<String, dynamic>> opPrincipalesDetalle = [];
    List<Map<String, dynamic>> totalesAditivos = [];
    double totalKgOrden = kgTotalesOrden ?? 0.0;
    double numeroDeCargas = 0.0;

    bool mostrarOp = (kgTotalesOrden != null && kgTotalesOrden > 0);

    if (mostrarOp) {
      numeroDeCargas = kgTotalesOrden / pesoRealPorCarga;

      if (resultadosPorCarga['carga_principales_detalle'] != null) {
        for (var detalle in (resultadosPorCarga['carga_principales_detalle'] as List<Map<String, dynamic>>)) {
          opPrincipalesDetalle.add({
            'origen': detalle['origen'],
            'cantidad': (detalle['cantidad'] as double) * numeroDeCargas,
          });
        }
      }

      List<Map<String, dynamic>> aditivosPorCarga = resultadosPorCarga['carga_aditivos'];
      for (var aditivo in aditivosPorCarga) {
        totalesAditivos.add({
          'nombre': aditivo['nombre'],
          'origen': aditivo['origen'], // CORRECCIÓN: Agregar origen
          'cantidad': (aditivo['cantidad'] as double) * numeroDeCargas,
        });
      }
    }

    // --- ORDENAMIENTO DE ADITIVOS ---
    // Regla: Por número de Minoritario (1-6), luego otros silos, y al final Fortacret y PDF.
    void ordenarAditivos(List<Map<String, dynamic>> lista) {
      lista.sort((a, b) {
        final nombreA = (a['nombre'] as String).toUpperCase();
        final nombreB = (b['nombre'] as String).toUpperCase();
        final origenA = (a['origen'] as String).toUpperCase();
        final origenB = (b['origen'] as String).toUpperCase();
        
        // Identificar pesos de importancia
        bool esFortA = origenA.contains('FIBRA') || nombreA.contains('FORTACRET');
        bool esPDFA = origenA.contains('PDF') || nombreA.contains('AGLOMERANTE');
        bool esFortB = origenB.contains('FIBRA') || nombreB.contains('FORTACRET');
        bool esPDFB = origenB.contains('PDF') || nombreB.contains('AGLOMERANTE');

        // Asignar peso de grupo: Minoritarios (0), Otros/Silos (10), Fortacret (20), PDF (30)
        int grupoA = esPDFA ? 30 : (esFortA ? 20 : (origenA.contains('MINORITARIO') ? 0 : 10));
        int grupoB = esPDFB ? 30 : (esFortB ? 20 : (origenB.contains('MINORITARIO') ? 0 : 10));

        if (grupoA != grupoB) return grupoA.compareTo(grupoB);

        // Si ambos son Minoritarios, ordenar por el número (Minoritario 1 < Minoritario 2)
        if (grupoA == 0) {
          int numA = int.tryParse(origenA.replaceAll(RegExp(r'[^0-9]'), '')) ?? 99;
          int numB = int.tryParse(origenB.replaceAll(RegExp(r'[^0-9]'), '')) ?? 99;
          if (numA != numB) return numA.compareTo(numB);
        }

        return nombreA.compareTo(nombreB); // Alfabético si todo lo demás es igual
      });
    }

    List<Map<String, dynamic>> aditivosCargaOrdenados = List.from(resultadosPorCarga['carga_aditivos']);
    ordenarAditivos(aditivosCargaOrdenados);
    ordenarAditivos(totalesAditivos);

    // 5. ACTUALIZAR EL ESTADO
    setState(() {
      _resultadoCalculo = {
        // Resultados por Carga Individual
        'carga_principales_detalle': resultadosPorCarga['carga_principales_detalle'],
        'carga_aditivos': aditivosCargaOrdenados,
        'carga_peso_total': pesoRealPorCarga,

        // Resultados de la Orden de Producción (OP)
        'op_kg_totales': totalKgOrden,
        'op_num_cargas': numeroDeCargas,
        'op_principales_detalle': opPrincipalesDetalle,
        'op_aditivos': totalesAditivos,
        'mostrar_op': mostrarOp,
      };
    });
  }

  // Mapa de colores para los aditivos
  final Map<String, Color> _coloresAditivos = {
    'WEKCELO': Colors.orange[800]!,
    'Walocel': Colors.green[800]!,
    'DLP 212': Colors.blue[700]!,
    'DLP 2000': Colors.lightBlue[800]!,
    'Formiato Calcio': Colors.purple[700]!,
    'Arena Silice 10-40': Colors.brown[700]!,
    'Aglomerante': Colors.amber[900]!,
    'Opagel': Colors.red[700]!,
    'ELOTEX': Colors.indigo[700]!,
    'FORTACRET': Colors.deepOrange[700]!,
    'MELFLUX': Colors.teal[700]!,
  };

  String _formatearValor(double valor) {
    String texto = valor.toStringAsFixed(2);
    if (texto.endsWith('.00')) {
      return texto.substring(0, texto.length - 3);
    }
    if (texto.endsWith('0')) {
      return texto.substring(0, texto.length - 1);
    }
    return texto;
  }

  // Función para acortar nombres excepto para los que deben verse completos
  String _obtenerNombreCorto(String nombreCompleto) {
    final upper = nombreCompleto.toUpperCase();
    if (upper.contains('FORMIATO') || upper.contains('DLP')) {
      return nombreCompleto;
    }
    return nombreCompleto.split(' ').first;
  }

  // Widget de ayuda para formatear y mostrar cada fila de resultados.
  Widget _buildResultadoFila(
    String material,
    double cantidad, {
    bool isPrincipal = false,
    bool isAditivo = false,
    bool isCantidadCargas = false,
    String? tolva,
    bool mostrarBultos = false,
    double? pesoBulto,
    bool redondearAEntero = false,
    String? nombreOriginalParaColor,
  }) {
    TextStyle baseStyle = TextStyle(
      fontSize: isPrincipal ? 18 : 16,
      fontWeight: isPrincipal ? FontWeight.bold : FontWeight.w500,
      color: isPrincipal ? Colors.black87 : primaryIndustrial,
    );

    // Color específico si es aditivo
    Color colorAditivo = Colors.black87;
    if (isAditivo) {
      String textoABuscar = nombreOriginalParaColor ?? material;
      colorAditivo = _coloresAditivos.entries
          .firstWhere(
            (entry) => textoABuscar.contains(entry.key),
            orElse: () => const MapEntry('', Colors.black87),
          )
          .value;
    }

    // Cálculo de bultos
    String textoCantidad = '';
    if (isCantidadCargas) {
      textoCantidad = redondearAEntero 
          ? '${cantidad.round()} cargas' 
          : '${cantidad.toStringAsFixed(2)} cargas';
    } else {
      textoCantidad = redondearAEntero 
          ? '${cantidad.round()} kg' 
          : '${_formatearValor(cantidad)} kg';
    }

    // REGLA: Excluir Aglomerante/PDF de bultos y asegurar mínimo 1 bulto para los demás
    bool esAglomerante = material.toUpperCase().contains('AGLOMERANTE') || (tolva?.toUpperCase().contains('PDF') ?? false);

    if (mostrarBultos && pesoBulto != null && pesoBulto > 0 && !esAglomerante) {
      // REGLA: Mostrar cantidad exacta con máximo un decimal
      double numBultos = cantidad / pesoBulto;
      
      // Formatear a 1 decimal. Si es entero (ej: 3.0), quitar el .0 para que se vea más limpio.
      String textoBultos = numBultos.toStringAsFixed(1);
      if (textoBultos.endsWith('.0')) {
        textoBultos = textoBultos.substring(0, textoBultos.length - 2);
      }
      
      textoCantidad += ' ($textoBultos bultos)';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: baseStyle.copyWith(color: isAditivo ? colorAditivo : null),
                children: [
                  TextSpan(text: material),
                  if (tolva != null)
                    TextSpan(
                      text: ' ($tolva)',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
          ),
          Text(
            textoCantidad,
            style: baseStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: isAditivo ? colorAditivo : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formulaState = context.watch<FormulaState>();
    final formulas = formulaState.formulas;

    // Sincronización reactiva: buscamos la versión más reciente de la fórmula seleccionada
    // Esto evita el uso de postFrameCallback y mantiene la UI siempre al día.
    final IsarFormula? formulaParaBuild = _formulaSeleccionada == null
        ? null
        : formulas
            .where((f) => f.id == _formulaSeleccionada!.id)
            .firstOrNull ?? _formulaSeleccionada;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Proporciones de Materiales',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryIndustrial,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear_all, color: primaryIndustrial),
                  tooltip: 'Limpiar Calculadora',
                  onPressed: _limpiarDatos,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Campo de Referencia con Autocompletado (Predictivo)
            Autocomplete<IsarFormula>(
              displayStringForOption: (f) => f.referencia ?? '',
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<IsarFormula>.empty();
                }
                return formulas.where(
                  (f) => (f.referencia ?? '').contains(
                    textEditingValue.text,
                  ),
                );
              },
              onSelected: (IsarFormula selection) {
                PreferenciasService.ultimaFormula = selection.referencia;
                setState(() => _formulaSeleccionada = selection);
                FocusScope.of(context).unfocus();
              },
              fieldViewBuilder: (
                BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted,
              ) {
                _autoCompleteController = textEditingController;
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Referencia de la Fórmula',
                    hintText: 'Ej: 901...',
                    border: const OutlineInputBorder(),
                    suffixIcon: formulaParaBuild != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              textEditingController.clear();
                              setState(() => _formulaSeleccionada = null);
                            },
                          )
                        : const Icon(Icons.search),
                  ),
                  onSubmitted: (_) => _calcularProporciones(),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final formula = options.elementAt(index);
                          return ListTile(
                            title: Text(formula.referencia ?? ''),
                            subtitle: Text(
                              formula.esBlanca == true ? 'Blanca' : 'Gris',
                              style: TextStyle(
                                color: formula.esBlanca == true
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                            onTap: () => onSelected(formula),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Campo de Peso Deseado (Carga Individual)
            TextField(
              controller: _pesoDeseadoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _calcularProporciones(),
              decoration: const InputDecoration(
                labelText: 'Peso de Carga Deseado (kg) - MAX 2400 kg',
                hintText: 'Ej: 1000. Dejar vacío para 2400 kg',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
            ),
            const SizedBox(height: 16),

            // Campo de Kilogramos Totales de la Orden (OP)
            TextField(
              controller: _kgOrdenController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _calcularProporciones(),
              decoration: const InputDecoration(
                labelText: 'Kilogramos Totales de la Orden (OP)',
                hintText: 'Ej: 15000 (Kg totales a fabricar)',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
            ),
            const SizedBox(height: 24),

            // Botón de Cálculo
            ElevatedButton(
              onPressed: _calcularProporciones,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: primaryIndustrial[900],
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'CALCULAR PROPORCIONES',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 32),

            // Sección de Mensajes de Error
            if (_mensajeError.isNotEmpty)
              Text(
                _mensajeError,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

            // Sección de Resultados
            if (_resultadoCalculo != null) ...[
              const Text(
                'Resultados por Carga (Receta de Uso)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),

              _buildResultadoFila(
                'Peso Total de Carga',
                _resultadoCalculo!['carga_peso_total'] as double,
              ),
              const SizedBox(height: 10),

              // Componentes Principales Dinámicos (Sin títulos rígidos)
              if (_resultadoCalculo!['carga_principales_detalle'] != null)
                ...(_resultadoCalculo!['carga_principales_detalle'] as List<Map<String, dynamic>>).map((detalle) {
                  // Separar el nombre del silo (ej: "Arena Amarilla (Silo 1)" -> "Arena Amarilla" y "Silo 1")
                  String fullOrigen = detalle['origen'] as String;
                  String nombre = fullOrigen;
                  String? silo;
                  if (fullOrigen.contains('(')) {
                    final parts = fullOrigen.split('(');
                    nombre = parts[0].trim();
                    silo = parts[1].replaceAll(')', '').trim();
                  }
                  return _buildResultadoFila(
                    nombre,
                    detalle['cantidad'] as double,
                    isPrincipal: true,
                    tolva: silo,
                  );
                }),

              const SizedBox(height: 16),
              const Text(
                'Aditivos Requeridos por Carga:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              if (_resultadoCalculo!['carga_aditivos'] != null)
                ...(_resultadoCalculo!['carga_aditivos']
                        as List<Map<String, dynamic>>)
                    .map((aditivoMap) {
                  final nombre = aditivoMap['nombre'] as String? ?? 'Aditivo';
                  final origen = aditivoMap['origen'] as String? ?? 'Sin Tolva Asignada';
                  final nombreCorto = _obtenerNombreCorto(nombre);
                  return _buildResultadoFila(
                    '  • $nombreCorto',
                    aditivoMap['cantidad'] as double,
                    isAditivo: true,
                    tolva: origen,
                    nombreOriginalParaColor: nombre,
                  );
                }),

              // TOTALES DE LA ORDEN DE PRODUCCIÓN (OP)
              if (_resultadoCalculo!['mostrar_op'] == true) ...[
                const Divider(height: 30, thickness: 2, color: Colors.indigo),
                const Text(
                  'TOTALES DE LA ORDEN DE PRODUCCIÓN (OP)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryIndustrial,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                _buildResultadoFila(
                  'Número de Cargas Requeridas',
                  _resultadoCalculo!['op_num_cargas'] as double,
                  isPrincipal: true,
                  isCantidadCargas: true,
                  redondearAEntero: false,
                ),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2.5),
                        1: FlexColumnWidth(1.2),
                        2: FlexColumnWidth(1.2),
                      },
                      border: TableBorder.all(color: Colors.grey.shade300),
                      children: [
                        // Cabecera de la tabla
                        TableRow(
                          decoration: BoxDecoration(color: Colors.indigo.shade50),
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Material / Tolva', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Kilos', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo), textAlign: TextAlign.center),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Bultos', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo), textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                        
                        // 1. Materias Primas Principales
                        if (_resultadoCalculo!['op_principales_detalle'] != null)
                          ...(_resultadoCalculo!['op_principales_detalle'] as List<Map<String, dynamic>>).map((detalle) {
                            String fullOrigen = detalle['origen'] as String;
                            String nombre = fullOrigen;
                            String silo = '';
                            if (fullOrigen.contains('(')) {
                              final parts = fullOrigen.split('(');
                              nombre = parts[0].trim();
                              silo = parts[1].replaceAll(')', '').trim();
                            }
                            double cantidad = detalle['cantidad'] as double;
                            
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      if (silo.isNotEmpty) Text(silo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${cantidad.round()} kg', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('-', textAlign: TextAlign.center),
                                ),
                              ],
                            );
                          }),
                        
                        // 2. Aditivos
                        if (_resultadoCalculo!['op_aditivos'] != null)
                          ...(_resultadoCalculo!['op_aditivos'] as List<Map<String, dynamic>>).map((aditivoMap) {
                            final nombreOriginal = aditivoMap['nombre'] as String? ?? 'Aditivo';
                            final origen = aditivoMap['origen'] as String? ?? 'Sin Tolva Asignada';
                            final nombreCorto = _obtenerNombreCorto(nombreOriginal);
                            final cantidad = aditivoMap['cantidad'] as double;
                            
                            // Extraer el color asignado
                            Color colorAditivo = _coloresAditivos.entries
                                .firstWhere(
                                  (entry) => nombreOriginal.contains(entry.key),
                                  orElse: () => const MapEntry('', Colors.black87),
                                )
                                .value;
                                
                            // Lógica de Bultos
                            String textoBultos = '-';
                            final pesoBulto = formulaState.obtenerPesoBulto(nombreOriginal);
                            bool esAglomerante = nombreOriginal.toUpperCase().contains('AGLOMERANTE') || origen.toUpperCase().contains('PDF');
                            
                            if (pesoBulto > 0 && !esAglomerante) {
                              double numBultos = cantidad / pesoBulto;
                              textoBultos = numBultos.toStringAsFixed(1);
                              if (textoBultos.endsWith('.0')) {
                                textoBultos = textoBultos.substring(0, textoBultos.length - 2);
                              }
                            }
                            
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(nombreCorto, style: TextStyle(fontWeight: FontWeight.bold, color: colorAditivo)),
                                      Text(origen, style: TextStyle(fontSize: 12, color: colorAditivo)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${_formatearValor(cantidad)} kg', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: colorAditivo)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(textoBultos, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: colorAditivo)),
                                ),
                              ],
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 20),
              const Text(
                'Nota: Las cantidades se muestran en kilogramos (kg).',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const Text(
                'Desarrollado por Jhon Calentura',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
      ),
    );
  }
}
