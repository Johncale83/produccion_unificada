// Archivo: lib/calculadora_rollos_screen.dart

import 'package:flutter/material.dart';
import 'calculadora_logica.dart';
import 'constants.dart';
import 'models/isar_formula.dart';
import 'services/database_service.dart';
import 'services/configuracion_rollos_service.dart';
import 'screens/configuracion_rollos_screen.dart';

class CalculadoraRollosScreen extends StatefulWidget {
  const CalculadoraRollosScreen({super.key});

  @override
  State<CalculadoraRollosScreen> createState() =>
      _CalculadoraRollosScreenState();
}

class _CalculadoraRollosScreenState extends State<CalculadoraRollosScreen> {
  final TextEditingController _grosorController = TextEditingController();
  final TextEditingController _formulaController = TextEditingController();

  final List<int> _formatosDisponibles = longitudesPorFormato.keys.toList();

  int _formatoSeleccionado = 25;
  int _bolsasPorEstibaActual = 0;

  int _resultadoBolsas = 0;
  int _resultadoEstibas = 0;
  int _resultadoBultosAdicionales = 0;
  String _mensajeError = '';

  // --- Fórmulas e integración ---
  List<IsarFormula> _formulas = [];
  IsarFormula? _formulaSeleccionada;

  // --- Resultados de integración ---
  int? _cargasCompletas;
  double? _fraccionParcial;
  double? _kgTotales;
  Map<String, dynamic>? _resultadoCargaParcial;

  // --- Configuración de rollos ---
  ConfiguracionRollos? _config;

  @override
  void initState() {
    super.initState();
    _formatoSeleccionado = 25;
    _bolsasPorEstibaActual = bolsasPorEstibaPorFormato[25]!;
    _cargarFormulas();
    _cargarConfiguracion();
  }

  Future<void> _cargarConfiguracion() async {
    final config = await ConfiguracionRollosService.cargar();
    if (mounted) {
      setState(() {
        _config = config;
        _bolsasPorEstibaActual =
            config.bolsasPorEstibaPorFormato[_formatoSeleccionado] ?? 60;
      });
    }
  }

  Future<void> _cargarFormulas() async {
    final formulas = await DatabaseService.getAllFormulas();
    if (mounted) {
      setState(() {
        _formulas = formulas;
      });
    }
  }

  void _calcular() {
    FocusScope.of(context).unfocus();

    final double? grosorCm = double.tryParse(
      _grosorController.text.replaceAll(',', '.'),
    );

    if (grosorCm == null || grosorCm <= 0) {
      setState(() {
        _mensajeError = 'Ingrese un grosor válido (> 0) para el plástico.';
      });
      return;
    }

    try {
      final cfg = _config;
      final longitudes = cfg?.longitudesPorFormato ?? longitudesPorFormato;
      final estibas = cfg?.bolsasPorEstibaPorFormato ?? bolsasPorEstibaPorFormato;
      final diametro = cfg?.diametroNucleoCm ?? diametroNucleoCm;
      final calibre = cfg?.calibrePlasticoMicras ?? calibrePlasticoMicras;
      final recorrido = cfg?.recorridoBultos ?? 20;

      final int bolsasPorEstibaActual = estibas[_formatoSeleccionado]!;

      final Map<String, int> resultados = calcularProduccionYEmpaqueConConfig(
        grosorPlasticoCm: grosorCm,
        formatoKg: _formatoSeleccionado,
        longitudesPorFormato: longitudes,
        bolsasPorEstibaPorFormato: estibas,
        diametroNucleoCm: diametro,
        calibrePlasticoMicras: calibre,
      );

      final int numBolsasBase = resultados['numeroBolsas']!;
      final int totalBolsas = numBolsasBase + recorrido;
      final double kgTotales = totalBolsas * _formatoSeleccionado.toDouble();

      // --- Integración con fórmula ---
      int? cargasCompletas;
      double? fraccion;
      Map<String, dynamic>? resultadoParcial;

      if (_formulaSeleccionada != null) {
        final double pesoBase = _formulaSeleccionada!.pesoBaseKg ?? 2400.0;
        final double cargasExactas = kgTotales / pesoBase;
        cargasCompletas = cargasExactas.floor();
        fraccion = cargasExactas - cargasCompletas;

        if (fraccion > 0.01) {
          final double kgParcial = fraccion * pesoBase;
          resultadoParcial = _formulaSeleccionada!.calcularProporciones(kgParcial);
        }
      }

      setState(() {
        _resultadoBolsas = totalBolsas;
        _resultadoEstibas = totalBolsas ~/ bolsasPorEstibaActual;
        _resultadoBultosAdicionales = totalBolsas % bolsasPorEstibaActual;
        _bolsasPorEstibaActual = bolsasPorEstibaActual;
        _mensajeError = '';
        _kgTotales = kgTotales;
        _cargasCompletas = cargasCompletas;
        _fraccionParcial = fraccion;
        _resultadoCargaParcial = resultadoParcial;
      });
    } catch (e) {
      setState(() {
        _mensajeError = e.toString();
      });
    }
  }

  void _onFormatoChanged(int? newValue) {
    if (newValue != null) {
      setState(() {
        _formatoSeleccionado = newValue;
        _mensajeError = '';
        _bolsasPorEstibaActual = bolsasPorEstibaPorFormato[newValue]!;
      });
    }
  }

  String _porcentajeParcial() {
    if (_fraccionParcial == null) return '';
    return '${(_fraccionParcial! * 100).toStringAsFixed(1)}%';
  }

  void _limpiarDatos() {
    setState(() {
      _grosorController.clear();
      _formulaSeleccionada = null;
      _resultadoBolsas = 0;
      _resultadoEstibas = 0;
      _resultadoBultosAdicionales = 0;
      _mensajeError = '';
      _cargasCompletas = null;
      _fraccionParcial = null;
      _kgTotales = null;
      _resultadoCargaParcial = null;
    });
  }

  @override
  void dispose() {
    _grosorController.dispose();
    _formulaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // --- Botón Limpiar + Configuración ---
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.settings, color: primaryIndustrial),
                tooltip: 'Configuración de rollos',
                onPressed: () async {
                  final recargar = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ConfiguracionRollosScreen(),
                    ),
                  );
                  if (recargar == true) {
                    await _cargarConfiguracion();
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.clear_all, color: primaryIndustrial),
                tooltip: 'Limpiar datos',
                onPressed: _limpiarDatos,
              ),
            ],
          ),

          // --- 1. Formato ---
          const Text(
            '1. Formato de Empaque (Kg)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _formatoSeleccionado,
                isExpanded: true,
                items: _formatosDisponibles.map((int formato) {
                  return DropdownMenuItem<int>(
                    value: formato,
                    child: Text('$formato kg'),
                  );
                }).toList(),
                onChanged: _onFormatoChanged,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- 2. Grosor ---
          const Text(
            '2. Grosor del plástico (cm)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _grosorController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _calcular(),
            decoration: const InputDecoration(
              hintText: 'Ej: 2.0',
              border: OutlineInputBorder(),
              suffixText: 'cm',
            ),
          ),
          const SizedBox(height: 20),

          // --- 3. Fórmula vinculada ---
          const Text(
            '3. Fórmula de Producción (Opcional)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Autocomplete<IsarFormula>(
            displayStringForOption: (f) => f.referencia ?? '',
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) return _formulas;
              return _formulas.where(
                (f) => (f.referencia ?? '').toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    ),
              );
            },
            onSelected: (IsarFormula selection) {
              setState(() {
                _formulaSeleccionada = selection;
              });
            },
            fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Buscar referencia...',
                  border: const OutlineInputBorder(),
                  suffixIcon: _formulaSeleccionada != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            controller.clear();
                            setState(() {
                              _formulaSeleccionada = null;
                              _cargasCompletas = null;
                              _fraccionParcial = null;
                              _resultadoCargaParcial = null;
                            });
                          },
                        )
                      : const Icon(Icons.search),
                ),
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
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

          if (_formulaSeleccionada != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Chip(
                avatar: const Icon(Icons.check_circle, color: Colors.green),
                label: Text(
                  'Fórmula: ${_formulaSeleccionada!.referencia} · Base: ${_formulaSeleccionada!.pesoBaseKg?.toStringAsFixed(0)} kg',
                ),
                backgroundColor: Colors.green.shade50,
              ),
            ),

          if (_mensajeError.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                '¡ERROR! $_mensajeError',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: _calcular,
            icon: const Icon(Icons.send_rounded),
            label: const Text(
              'CALCULAR EMPAQUE',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: primaryIndustrial[900],
              foregroundColor: Colors.white,
            ),
          ),

          const SizedBox(height: 40),
          const Divider(color: Colors.black26),
          const Text(
            'RESUMEN DEL ROLLO',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryIndustrial,
            ),
          ),
          const SizedBox(height: 20),

          _ResultadoCard(
            title: 'Total de Bolsas',
            subtitle: 'Formato $_formatoSeleccionado kg',
            value: _resultadoBolsas,
            color: Colors.blue,
          ),
          _ResultadoCard(
            title: 'Cantidad Total de Estibas',
            subtitle: '($_bolsasPorEstibaActual bolsas/estiba)',
            value: _resultadoEstibas,
            color: Colors.green,
          ),
          _ResultadoCard(
            title: 'Bultos Adicionales',
            subtitle: '(Residuo de bolsas que no completan la estiba)',
            value: _resultadoBultosAdicionales,
            color: Colors.orange,
          ),

          // --- Sección de integración con fórmula ---
          if (_formulaSeleccionada != null && _cargasCompletas != null) ...[
            const SizedBox(height: 20),
            const Divider(thickness: 2, color: Colors.indigo),
            Text(
              'PRODUCCIÓN REQUERIDA (${_formulaSeleccionada!.referencia})',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryIndustrial,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total de kg del rollo: ${_kgTotales?.toStringAsFixed(0)} kg',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // Cargas completas
            Card(
              color: Colors.indigo.shade50,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Cargas Completas',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      '$_cargasCompletas',
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    Text(
                      'x ${_formulaSeleccionada!.pesoBaseKg?.toStringAsFixed(0)} kg = ${(_cargasCompletas! * (_formulaSeleccionada!.pesoBaseKg ?? 2400)).toStringAsFixed(0)} kg',
                      style: const TextStyle(color: Colors.black45, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),

            // Carga parcial
            if (_fraccionParcial != null && _fraccionParcial! > 0.01) ...[
              const SizedBox(height: 12),
              Card(
                color: Colors.orange.shade50,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'Carga Parcial: ${_porcentajeParcial()}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(_fraccionParcial! * (_formulaSeleccionada!.pesoBaseKg ?? 2400)).toStringAsFixed(1)} kg de mezcla',
                        style: const TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      if (_resultadoCargaParcial != null) ...[
                        const Divider(height: 20),
                        const Text(
                          'Ingredientes para esta carga:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        ..._buildIngredientesParciales(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],

          const SizedBox(height: 30),
          const Divider(color: Colors.black26),
          const Text(
            'Desarrollado por Jhon Calentura',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  List<Widget> _buildIngredientesParciales() {
    final resultados = _resultadoCargaParcial!;
    final List<Widget> items = [];

    // Arena Amarilla (Silo 1 y Silo 2) — clave: 'arena_amarilla_detalle'
    final arenaDetalle = resultados['arena_amarilla_detalle'] as List<Map<String, dynamic>>?;
    if (arenaDetalle != null) {
      for (var d in arenaDetalle) {
        items.add(_ingredienteRow(
          'Arena Amarilla (${d['origen']})',
          d['cantidad'] as double,
          Colors.amber.shade700,
        ));
      }
    }

    // Arena Blanca — clave: 'arena_blanca_detalle'
    final arenaBlancaDetalle = resultados['arena_blanca_detalle'] as List<Map<String, dynamic>>?;
    if (arenaBlancaDetalle != null) {
      for (var d in arenaBlancaDetalle) {
        items.add(_ingredienteRow(
          'Arena Blanca (${d['origen']})',
          d['cantidad'] as double,
          Colors.lightBlue.shade400,
        ));
      }
    }

    // Cemento — clave: 'cemento_detalle'
    final cementoDetalle = resultados['cemento_detalle'] as List<Map<String, dynamic>>?;
    if (cementoDetalle != null) {
      for (var d in cementoDetalle) {
        items.add(_ingredienteRow(
          'Cemento (${d['origen']})',
          d['cantidad'] as double,
          Colors.grey.shade600,
        ));
      }
    }

    // Aditivos — clave: 'aditivos_lista'
    final aditivos = resultados['aditivos_lista'] as List<Map<String, dynamic>>?;
    if (aditivos != null) {
      for (var a in aditivos) {
        final nombre = a['nombre'] as String;
        final origen = a['origen'] as String;
        final textoOrigen = origen == 'Sin Tolva Asignada' ? '(Sin Tolva)' : '($origen)';
        items.add(_ingredienteRow(
          '$nombre $textoOrigen',
          a['cantidad'] as double,
          Colors.deepPurple.shade300,
        ));
      }
    }

    if (items.isEmpty) {
      items.add(const Text(
        'Sin ingredientes registrados para esta fórmula.',
        style: TextStyle(color: Colors.black45, fontStyle: FontStyle.italic),
      ));
    }

    return items;
  }

  Widget _ingredienteRow(String nombre, double cantidad, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              nombre,
              style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          Text(
            '${cantidad.toStringAsFixed(1)} kg',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar
class _ResultadoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int value;
  final MaterialColor color;

  const _ResultadoCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 5),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
