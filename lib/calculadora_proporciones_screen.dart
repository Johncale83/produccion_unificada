// Archivo: lib/calculadora_proporciones_screen.dart

import 'package:flutter/material.dart';
import 'package:produccion_unificada/models/isar_formula.dart';
import 'package:produccion_unificada/services/database_service.dart';
import 'constants.dart';

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
    _cargarFormulas();
  }

  Future<void> _cargarFormulas() async {
    final formulas = await DatabaseService.getAllFormulas();
    if (mounted) {
      setState(() {
        _formulas = formulas;
      });
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
    // Cierra el teclado
    FocusScope.of(context).unfocus();

    setState(() {
      _resultadoCalculo = null;
      _mensajeError = '';
    });

    // Usar la fórmula seleccionada directamente (sin re-consultar DB)
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
    double totalArenaComun = 0.0;
    double totalArenaBlanca = 0.0;
    double totalCemento = 0.0;
    List<Map<String, dynamic>> totalesAditivos = [];
    double totalKgOrden = kgTotalesOrden ?? 0.0;
    double numeroDeCargas = 0.0;

    bool mostrarOp = (kgTotalesOrden != null && kgTotalesOrden > 0);

    if (mostrarOp) {
      numeroDeCargas = kgTotalesOrden / pesoRealPorCarga;

      totalArenaComun =
          (resultadosPorCarga['arena_amarilla_total_plano'] as double) * numeroDeCargas;
      totalArenaBlanca =
          (resultadosPorCarga['arena_blanca_total_plano'] as double) * numeroDeCargas;
      totalCemento = (resultadosPorCarga['cemento_total_plano'] as double) * numeroDeCargas;

      List<Map<String, dynamic>> aditivosPorCarga =
          resultadosPorCarga['aditivos_lista'];
      for (var aditivo in aditivosPorCarga) {
        totalesAditivos.add({
          'nombre': aditivo['nombre'],
          'cantidad': (aditivo['cantidad'] as double) * numeroDeCargas,
        });
      }
    }

    // 5. ACTUALIZAR EL ESTADO
    setState(() {
      _resultadoCalculo = {
        // Resultados por Carga Individual
        'carga_arena_amarilla_detalle': resultadosPorCarga['arena_amarilla_detalle'],
        'carga_arena_blanca_detalle': resultadosPorCarga['arena_blanca_detalle'],
        'carga_cemento_detalle': resultadosPorCarga['cemento_detalle'],
        'carga_aditivos': resultadosPorCarga['aditivos_lista'],
        'carga_peso_total': pesoRealPorCarga,

        // Resultados de la Orden de Producción (OP)
        'op_kg_totales': totalKgOrden,
        'op_num_cargas': numeroDeCargas,
        'op_arena_amarilla': totalArenaComun,
        'op_arena_blanca': totalArenaBlanca,
        'op_cemento': totalCemento,
        'op_aditivos':
            totalesAditivos.isNotEmpty
                ? totalesAditivos
                : resultadosPorCarga['aditivos_lista'],
        'mostrar_op': mostrarOp,
      };
    });
  }

  // Mapa de colores para los aditivos
  final Map<String, Color> _coloresAditivos = {
    'Wekcelo MP 150': Colors.orange,
    'Warocel 58150': Colors.deepOrange,
    'Walocel 58150': Colors.deepOrange,
    'Wekcelo 58150': Colors.brown,
    'DLP 212': Colors.teal,
    'DLP 2000': Colors.cyan,
    'Formiato Calcio': Colors.purple,
    'Arena 1040': Colors.amber[900]!,
    'Aglomerante': Colors.lime[800]!,
    'Opagel': Colors.pink,
    'Elotex ': Colors.indigo,
    'Elotex': Colors.indigo,
    'Fortacret ': Colors.red,
    'Fortacret': Colors.red,
    'Melflux ': Colors.green[800]!,
    'Melflux': Colors.green[800]!,
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

  // Widget de ayuda para formatear y mostrar cada fila de resultados.
  Widget _buildResultadoFila(
    String material,
    double cantidad, {
    bool isPrincipal = false,
    bool isAditivo = false,
    bool isCantidadCargas = false,
  }) {
    // Definimos el color primario
    // const MaterialColor primaryIndustrial = MaterialColor(0xFF1A237E, <int, Color>{900: Color(0xFF1A237E)});

    TextStyle style = TextStyle(
      fontSize: isPrincipal ? 18 : 16,
      fontWeight:
          isPrincipal
              ? FontWeight.bold
              : isAditivo
              ? FontWeight.normal
              : FontWeight.w500,
      color:
          isPrincipal
              ? Colors.black87
              : isAditivo
              ? (_coloresAditivos.entries
                  .firstWhere(
                    (entry) => material.contains(entry.key),
                    orElse: () => const MapEntry('', Colors.black87),
                  )
                  .value)
              : primaryIndustrial,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(material, style: style)),
          Text(
            isCantidadCargas
                ? '${cantidad.toStringAsFixed(4)} cargas'
                : '${_formatearValor(cantidad)} kg',
            style: style.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Proporciones de Materiales',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryIndustrial,
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
                return _formulas.where(
                  (f) => (f.referencia ?? '').contains(
                    textEditingValue.text,
                  ),
                );
              },
              onSelected: (IsarFormula selection) {
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
                    suffixIcon: _formulaSeleccionada != null
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

              // Componentes Principales Detallados por Silo
              if (_resultadoCalculo!['carga_arena_amarilla_detalle'] != null)
                ...(_resultadoCalculo!['carga_arena_amarilla_detalle'] as List<Map<String, dynamic>>).map((detalle) {
                  return _buildResultadoFila(
                    'Arena Amarilla (${detalle['origen']})',
                    detalle['cantidad'] as double,
                    isPrincipal: true,
                  );
                }),

              if (_resultadoCalculo!['carga_arena_blanca_detalle'] != null)
                ...(_resultadoCalculo!['carga_arena_blanca_detalle'] as List<Map<String, dynamic>>).map((detalle) {
                  return _buildResultadoFila(
                    'Arena Blanca (${detalle['origen']})',
                    detalle['cantidad'] as double,
                    isPrincipal: true,
                  );
                }),

              if (_resultadoCalculo!['carga_cemento_detalle'] != null)
                ...(_resultadoCalculo!['carga_cemento_detalle'] as List<Map<String, dynamic>>).map((detalle) {
                  return _buildResultadoFila(
                    'Cemento (${detalle['origen']})',
                    detalle['cantidad'] as double,
                    isPrincipal: true,
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
                      final textoOrigen = origen == 'Sin Tolva Asignada' ? '(Sin Tolva Asignada)' : '($origen)';
                      return _buildResultadoFila(
                        '  • $nombre $textoOrigen',
                        aditivoMap['cantidad'] as double,
                        isAditivo: true,
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
                ),
                const Divider(),

                if ((_resultadoCalculo!['op_arena_amarilla'] as double) > 0)
                  _buildResultadoFila(
                    'TOTAL Arena Amarilla (OP)',
                    _resultadoCalculo!['op_arena_amarilla'] as double,
                    isPrincipal: true,
                  ),
                if ((_resultadoCalculo!['op_arena_blanca'] as double) > 0)
                  _buildResultadoFila(
                    'TOTAL Arena Blanca (OP)',
                    _resultadoCalculo!['op_arena_blanca'] as double,
                    isPrincipal: true,
                  ),
                _buildResultadoFila(
                  'TOTAL Cemento (OP)',
                  _resultadoCalculo!['op_cemento'] as double,
                  isPrincipal: true,
                ),

                const SizedBox(height: 16),
                const Text(
                  'TOTAL Aditivos Requeridos:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                if (_resultadoCalculo!['op_aditivos'] != null)
                  ...(_resultadoCalculo!['op_aditivos']
                          as List<Map<String, dynamic>>)
                      .map((aditivoMap) {
                        final nombre = aditivoMap['nombre'] as String? ?? 'Aditivo';
                        final origen = aditivoMap['origen'] as String? ?? 'Sin Tolva Asignada';
                        final textoOrigen = origen == 'Sin Tolva Asignada' ? '(Sin Tolva Asignada)' : '($origen)';
                        return _buildResultadoFila(
                          '  • TOTAL $nombre $textoOrigen',
                          aditivoMap['cantidad'] as double,
                          isAditivo: true,
                        );
                      }),
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
    );
  }
}
