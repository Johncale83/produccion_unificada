import 'package:flutter/material.dart';
import 'package:produccion_unificada/models/isar_formula.dart';
import 'package:produccion_unificada/services/database_service.dart';
import '../constants.dart';

class AgregarFormulaScreen extends StatefulWidget {
  final IsarFormula? formulaAEditar;
  const AgregarFormulaScreen({super.key, this.formulaAEditar});

  @override
  State<AgregarFormulaScreen> createState() => _AgregarFormulaScreenState();
}

class _AgregarFormulaScreenState extends State<AgregarFormulaScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _referenciaController = TextEditingController();
  final TextEditingController _pesoBaseController = TextEditingController(
    text: '2400.0',
  );
  final TextEditingController _cementoController = TextEditingController();
  final TextEditingController _arenaSilo1Controller = TextEditingController();
  final TextEditingController _arenaSilo2Controller = TextEditingController();
  final TextEditingController _arenaBlancaController = TextEditingController();

  bool _esBlanca = false;
  double _totalCalculado = 0.0;

  final List<Map<String, TextEditingController>> _aditivosControllers = [];

  List<IsarCatalogoAditivo> _catalogoAditivos = [];

  @override
  void initState() {
    super.initState();
    _inicializarDatos();
    _agregarListeners(initial: true);
  }

  Future<void> _inicializarDatos() async {
    final aditivos = await DatabaseService.getAditivosCatalogo();
    if (mounted) {
      setState(() {
        _catalogoAditivos = aditivos;
        _catalogoAditivos.sort((a, b) => (a.nombre ?? '').compareTo(b.nombre ?? ''));
      });
    }
    _cargarDatosEdicion();
  }

  void _cargarDatosEdicion() {
    if (widget.formulaAEditar != null) {
      final f = widget.formulaAEditar!;
      // _esBlanca PRIMERO para que los listeners calculen con el tipo correcto
      _esBlanca = f.esBlanca ?? false;
      _referenciaController.text = f.referencia ?? '';
      _pesoBaseController.text = (f.pesoBaseKg ?? 2400.0).toString();
      _cementoController.text = (f.cementoKg ?? 0.0).toString();
      _arenaSilo1Controller.text = (f.arenaSilo1Kg ?? 0.0).toString();
      _arenaSilo2Controller.text = (f.arenaSilo2Kg ?? 0.0).toString();
      _arenaBlancaController.text = (f.arenaBlancaKg ?? 0.0).toString();

      if (f.aditivos != null) {
        for (var aditivo in f.aditivos!) {
          _aditivosControllers.add({
            'nombre': TextEditingController(text: aditivo.nombre),
            'cantidad': TextEditingController(
              text: aditivo.cantidadKg?.toString() ?? '',
            ),
            'origen': TextEditingController(text: aditivo.origen ?? 'Minoritario 1'),
          });
        }
      }

      // Forzar recálculo después de cargar todos los datos
      setState(() {
        _calcularTotalEnTiempoReal();
      });
    }
  }

  void _agregarListeners({bool initial = false}) {
    if (initial) {
      _pesoBaseController.addListener(_calcularTotalEnTiempoReal);
      _cementoController.addListener(_calcularTotalEnTiempoReal);
      _arenaSilo1Controller.addListener(_calcularTotalEnTiempoReal);
      _arenaSilo2Controller.addListener(_calcularTotalEnTiempoReal);
      _arenaBlancaController.addListener(_calcularTotalEnTiempoReal);
    }

    for (var row in _aditivosControllers) {
      row['cantidad']?.removeListener(_calcularTotalEnTiempoReal);
      row['cantidad']?.addListener(_calcularTotalEnTiempoReal);
    }

    _calcularTotalEnTiempoReal();
  }

  void _calcularTotalEnTiempoReal() {
    double cemento =
        double.tryParse(_cementoController.text.replaceAll(',', '.')) ?? 0;
    double arenaAmarilla =
        _esBlanca
            ? 0
            : ((double.tryParse(_arenaSilo1Controller.text.replaceAll(',', '.')) ?? 0) +
               (double.tryParse(_arenaSilo2Controller.text.replaceAll(',', '.')) ?? 0));
    double arenaBlanca =
        !_esBlanca
            ? 0
            : (double.tryParse(
                  _arenaBlancaController.text.replaceAll(',', '.'),
                ) ??
                0);

    double aditivosTotal = 0.0;
    for (var row in _aditivosControllers) {
      aditivosTotal +=
          double.tryParse(row['cantidad']!.text.replaceAll(',', '.')) ?? 0.0;
    }

    setState(() {
      _totalCalculado = cemento + arenaAmarilla + arenaBlanca + aditivosTotal;
    });
  }

  void _agregarAditivoRow() {
    setState(() {
      final controllerNombre = TextEditingController();
      final controllerCantidad = TextEditingController();
      controllerCantidad.addListener(_calcularTotalEnTiempoReal);

      _aditivosControllers.add({
        'nombre': controllerNombre,
        'cantidad': controllerCantidad,
        'origen': TextEditingController(text: 'Minoritario 1'),
      });
    });
  }

  void _removerAditivoRow(int index) {
    setState(() {
      _aditivosControllers[index]['nombre']?.dispose();
      _aditivosControllers[index]['cantidad']?.removeListener(
        _calcularTotalEnTiempoReal,
      );
      _aditivosControllers[index]['cantidad']?.dispose();
      _aditivosControllers[index]['origen']?.dispose();
      _aditivosControllers.removeAt(index);
    });
    _calcularTotalEnTiempoReal();
  }

  Future<void> _guardarFormula() async {
    if (_formKey.currentState!.validate()) {
      try {
        List<IsarAditivo> aditivos = [];
        for (var row in _aditivosControllers) {
          final nombre = row['nombre']!.text.trim();
          final cantidadStr = row['cantidad']!.text.trim().replaceAll(',', '.');
          final origenStr = row['origen']!.text.trim();

          if (nombre.isNotEmpty && cantidadStr.isNotEmpty) {
            aditivos.add(
              IsarAditivo()
                ..nombre = nombre
                ..cantidadKg = double.tryParse(cantidadStr)
                ..origen = origenStr,
            );
          }
        }

        final formulaToSave = widget.formulaAEditar ?? IsarFormula();

        formulaToSave
          ..referencia = _referenciaController.text.trim().toUpperCase()
          ..esBlanca = _esBlanca
          ..pesoBaseKg =
              double.tryParse(_pesoBaseController.text.replaceAll(',', '.')) ??
              2400.0
          ..cementoKg =
              double.tryParse(_cementoController.text.replaceAll(',', '.')) ??
              0.0
          ..arenaSilo1Kg =
              double.tryParse(
                _arenaSilo1Controller.text.replaceAll(',', '.'),
              ) ??
              0.0
          ..arenaSilo2Kg =
              double.tryParse(
                _arenaSilo2Controller.text.replaceAll(',', '.'),
              ) ??
              0.0
          ..arenaBlancaKg =
              double.tryParse(
                _arenaBlancaController.text.replaceAll(',', '.'),
              ) ??
              0.0
          ..aditivos = aditivos;

        await DatabaseService.agregarFormula(formulaToSave);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.formulaAEditar == null
                    ? 'Fórmula guardada exitosamente'
                    : 'Fórmula actualizada exitosamente',
              ),
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al guardar: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _referenciaController.dispose();
    _pesoBaseController.dispose();
    _cementoController.dispose();
    _arenaSilo1Controller.dispose();
    _arenaSilo2Controller.dispose();
    _arenaBlancaController.dispose();
    for (var row in _aditivosControllers) {
      row['nombre']?.dispose();
      row['cantidad']?.dispose();
      row['origen']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double pesoBaseRequerido =
        double.tryParse(_pesoBaseController.text.replaceAll(',', '.')) ?? 0;
    final bool estaCuadrada =
        (_totalCalculado - pesoBaseRequerido).abs() <
        0.1; // tolerar pequeñas variaciones decimales

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.formulaAEditar == null
              ? 'Agregar Nueva Fórmula'
              : 'Editar Fórmula',
        ),
        backgroundColor: primaryIndustrial,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                16.0,
                16.0,
                16.0,
                100.0,
              ), // Extra padding al fondo
              children: [
                const Text(
                  'Información General',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryIndustrial,
                  ),
                ),
                const SizedBox(height: 10),

                SwitchListTile(
                  title: const Text('¿Es una fórmula Blanca?'),
                  subtitle: Text(
                    _esBlanca
                        ? '(Fórmula para rollos/blancos)'
                        : '(Fórmula Gris estándar)',
                  ),
                  value: _esBlanca,
                  activeColor: primaryIndustrial,
                  onChanged: (val) {
                    setState(() {
                      _esBlanca = val;
                      _calcularTotalEnTiempoReal();
                    });
                  },
                ),

                TextFormField(
                  controller: _referenciaController,
                  decoration: const InputDecoration(
                    labelText: 'Referencia (Ej: 901XXXXXX)',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (val) => val == null || val.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _pesoBaseController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Peso Base Esperado',
                    border: OutlineInputBorder(),
                    suffixText: 'kg',
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Materias Primas Principales',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryIndustrial,
                  ),
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _cementoController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Cemento (kg)',
                    border: OutlineInputBorder(),
                    suffixText: 'kg',
                  ),
                  validator:
                      (val) => val == null || val.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 10),

                if (!_esBlanca) ...[
                  TextFormField(
                    controller: _arenaSilo1Controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Arena Amarilla (Silo 1) Kg',
                      border: OutlineInputBorder(),
                      suffixText: 'kg',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _arenaSilo2Controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Arena Amarilla (Silo 2) Kg',
                      border: OutlineInputBorder(),
                      suffixText: 'kg',
                    ),
                  ),
                ] else
                  TextFormField(
                    controller: _arenaBlancaController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Arena Blanca (kg)',
                      border: OutlineInputBorder(),
                      suffixText: 'kg',
                    ),
                  ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Aditivos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryIndustrial,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _agregarAditivoRow,
                      icon: const Icon(Icons.add),
                      label: const Text('Añadir Aditivo'),
                    ),
                  ],
                ),

                ..._aditivosControllers.asMap().entries.map((entry) {
                  int idx = entry.key;
                  var row = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                value: _catalogoAditivos.any((a) => a.nombre == row['nombre']?.text)
                                    ? row['nombre']?.text
                                    : null,
                                decoration: InputDecoration(
                                  labelText: 'Nombre Aditivo ${idx + 1}',
                                  border: const OutlineInputBorder(),
                                ),
                                items: _catalogoAditivos.map((aditivo) {
                                  return DropdownMenuItem<String>(
                                    value: aditivo.nombre,
                                    child: Text(aditivo.nombre ?? 'Sin nombre'),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      row['nombre']?.text = val;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: row['cantidad'],
                                keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Kg',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removerAditivoRow(idx),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: ['Minoritario 1', 'Minoritario 2', 'Minoritario 3', 'Minoritario 4', 'Minoritario 5', 'Minoritario 6', 'Aglomerante PDF', 'Tlva Fibra']
                                  .contains(row['origen']?.text) 
                              ? row['origen']?.text 
                              : 'Minoritario 1',
                          decoration: const InputDecoration(
                            labelText: 'Tolva de Origen',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Minoritario 1', child: Text('Minoritario 1')),
                            DropdownMenuItem(value: 'Minoritario 2', child: Text('Minoritario 2')),
                            DropdownMenuItem(value: 'Minoritario 3', child: Text('Minoritario 3')),
                            DropdownMenuItem(value: 'Minoritario 4', child: Text('Minoritario 4')),
                            DropdownMenuItem(value: 'Minoritario 5', child: Text('Minoritario 5')),
                            DropdownMenuItem(value: 'Minoritario 6', child: Text('Minoritario 6')),
                            DropdownMenuItem(value: 'Aglomerante PDF', child: Text('Aglomerante PDF')),
                            DropdownMenuItem(value: 'Tlva Fibra', child: Text('Tolva Fibra (Tlva)')),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                row['origen']?.text = val;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _guardarFormula,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: primaryIndustrial,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    widget.formulaAEditar == null
                        ? 'GUARDAR NUEVA FÓRMULA'
                        : 'ACTUALIZAR FÓRMULA',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: estaCuadrada ? Colors.green[800] : Colors.amber[900],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      children: [
                        const TextSpan(text: 'Suma Actual: '),
                        TextSpan(
                          text: '${_totalCalculado.toStringAsFixed(2)} kg\n',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text:
                              estaCuadrada
                                  ? '¡Fórmula Cuadrada!'
                                  : 'Diferencia: ${(_totalCalculado - pesoBaseRequerido).abs().toStringAsFixed(2)} kg',
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    estaCuadrada ? Icons.check_circle : Icons.warning,
                    color: Colors.white,
                    size: 36,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
