import 'package:flutter/material.dart';
import 'package:produccion_unificada/models/isar_formula.dart';
import 'package:produccion_unificada/services/database_service.dart';
import 'package:produccion_unificada/services/formula_state.dart';
import 'package:produccion_unificada/constants.dart';

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

  final List<Map<String, TextEditingController>> _materialesPrincipalesControllers = [];
  final List<String> _opcionesSilos = List.generate(8, (i) => 'Silo ${i + 1}');

  bool _esBlanca = false;
  double _totalCalculado = 0.0;
  bool _isSaving = false;

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
      _esBlanca = f.esBlanca ?? false;
      _referenciaController.text = f.referencia ?? '';
      _pesoBaseController.text = (f.pesoBaseKg ?? 2400.0).toString();

      if (f.materialesPrincipales != null && f.materialesPrincipales!.isNotEmpty) {
        for (var mat in f.materialesPrincipales!) {
          _agregarMaterialPrincipalRow(
            nombre: mat.nombre,
            categoria: mat.categoria,
            cantidad: mat.cantidadKg?.toString(),
          );
        }
      } else {
        // MIGRACIÓN: Convertir campos antiguos a la nueva estructura dinámica
        if ((f.arenaSilo1Kg ?? 0) > 0) _agregarMaterialPrincipalRow(nombre: 'Silo 1', categoria: 'Arena Amarilla', cantidad: f.arenaSilo1Kg.toString());
        if ((f.arenaSilo2Kg ?? 0) > 0) _agregarMaterialPrincipalRow(nombre: 'Silo 2', categoria: 'Arena Amarilla', cantidad: f.arenaSilo2Kg.toString());
        if ((f.arenaBlancaSilo4Kg ?? 0) > 0) _agregarMaterialPrincipalRow(nombre: 'Silo 4', categoria: 'Arena Blanca', cantidad: f.arenaBlancaSilo4Kg.toString());
        if ((f.arenaSilo5Kg ?? 0) > 0) _agregarMaterialPrincipalRow(nombre: 'Silo 5', categoria: 'Arena Silice 10-40', cantidad: f.arenaSilo5Kg.toString());
        
        if (!(_esBlanca)) {
          if ((f.cementoKg ?? 0) > 0) _agregarMaterialPrincipalRow(nombre: 'Silo 3', categoria: 'Cemento', cantidad: f.cementoKg.toString());
        } else {
          if ((f.cementoSilo7Kg ?? 0) > 0) _agregarMaterialPrincipalRow(nombre: 'Silo 7', categoria: 'Cemento', cantidad: f.cementoSilo7Kg.toString());
          if ((f.cementoSilo8Kg ?? 0) > 0) _agregarMaterialPrincipalRow(nombre: 'Silo 8', categoria: 'Cemento', cantidad: f.cementoSilo8Kg.toString());
        }
      }

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

      setState(() {
        _calcularTotalEnTiempoReal();
      });
    }
  }

  void _agregarListeners({bool initial = false}) {
    if (initial) {
      _pesoBaseController.addListener(_calcularTotalEnTiempoReal);
    }
    
    for (var row in _materialesPrincipalesControllers) {
      if (!initial) {
        row['cantidad']?.removeListener(_calcularTotalEnTiempoReal);
      }
      row['cantidad']?.addListener(_calcularTotalEnTiempoReal);
    }

    for (var row in _aditivosControllers) {
      if (!initial) {
        row['cantidad']?.removeListener(_calcularTotalEnTiempoReal);
      }
      row['cantidad']?.addListener(_calcularTotalEnTiempoReal);
    }

    _calcularTotalEnTiempoReal();
  }

  void _calcularTotalEnTiempoReal() {
    double principalesTotal = 0.0;
    for (var row in _materialesPrincipalesControllers) {
      principalesTotal +=
          double.tryParse(row['cantidad']!.text.replaceAll(',', '.')) ?? 0.0;
    }

    double aditivosTotal = 0.0;
    for (var row in _aditivosControllers) {
      aditivosTotal +=
          double.tryParse(row['cantidad']!.text.replaceAll(',', '.')) ?? 0.0;
    }

    setState(() {
      _totalCalculado = principalesTotal + aditivosTotal;
    });
  }

  void _agregarMaterialPrincipalRow({String? nombre, String? categoria, String? cantidad}) {
    setState(() {
      final controllerNombre = TextEditingController(text: nombre ?? 'Silo 1');
      final controllerCategoria = TextEditingController(text: categoria ?? 'Arena Amarilla');
      final controllerCantidad = TextEditingController(text: cantidad ?? '');
      controllerCantidad.addListener(_calcularTotalEnTiempoReal);

      _materialesPrincipalesControllers.add({
        'nombre': controllerNombre,
        'categoria': controllerCategoria,
        'cantidad': controllerCantidad,
      });
    });
  }

  void _removerMaterialPrincipalRow(int index) {
    setState(() {
      _materialesPrincipalesControllers[index]['cantidad']?.removeListener(
        _calcularTotalEnTiempoReal,
      );
      _materialesPrincipalesControllers[index]['nombre']?.dispose();
      _materialesPrincipalesControllers[index]['categoria']?.dispose();
      _materialesPrincipalesControllers[index]['cantidad']?.dispose();
      _materialesPrincipalesControllers.removeAt(index);
    });
    _calcularTotalEnTiempoReal();
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

  Future<bool> _existeReferencia(String referencia, {int? excludeId}) async {
    final todas = await DatabaseService.getAllFormulas();
    return todas.any((f) =>
      f.referencia?.toUpperCase() == referencia.toUpperCase() &&
      f.id != excludeId
    );
  }

  Future<void> _guardarFormula() async {
    if (_formKey.currentState!.validate()) {
      final messenger = ScaffoldMessenger.of(context);
      setState(() => _isSaving = true);
      
      final pesoBase = double.tryParse(_pesoBaseController.text.replaceAll(',', '.')) ?? 2400.0;
      final diferencia = (_totalCalculado - pesoBase).abs();
      final bool estaCuadrada = diferencia < 0.1;
      
      if (!estaCuadrada) {
        final confirmar = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('⚠️ Fórmula Descuadrada'),
            content: Text(
              'La suma actual (${_totalCalculado.toStringAsFixed(2)} kg) no coincide con el peso base ($pesoBase kg).\n\n'
              'Diferencia: ${diferencia.toStringAsFixed(2)} kg\n\n'
              '¿Desea guardar de todas formas?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('GuardarIgual'),
              ),
            ],
          ),
        );
        if (confirmar != true) {
          if (mounted) setState(() => _isSaving = false);
          return;
        }
      }

      final ref = _referenciaController.text.trim().toUpperCase();
      final existe = await _existeReferencia(ref, excludeId: widget.formulaAEditar?.id);
      if (existe) {
        if (!mounted) return;
        messenger.showSnackBar(
          SnackBar(
            content: Text('Ya existe una fórmula con la referencia $ref'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      try {
        List<IsarMaterialPrincipal> principales = [];
        for (var row in _materialesPrincipalesControllers) {
          final nombre = row['nombre']!.text.trim();
          final categoria = row['categoria']!.text.trim();
          final cantidadStr = row['cantidad']!.text.trim().replaceAll(',', '.');

          if (cantidadStr.isNotEmpty) {
            principales.add(
              IsarMaterialPrincipal()
                ..nombre = nombre
                ..categoria = categoria
                ..cantidadKg = double.tryParse(cantidadStr),
            );
          }
        }

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
          ..materialesPrincipales = principales
          ..aditivos = aditivos;

        // Usar FormulaState en lugar de DatabaseService directo para notificar cambios globales
        if (widget.formulaAEditar == null) {
          await formulaState.agregarFormula(formulaToSave);
        } else {
          await formulaState.actualizarFormula(formulaToSave);
        }

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
          if (mounted) {
            Navigator.pop(context);
          }
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
      } finally {
        if (mounted) {
          setState(() => _isSaving = false);
        }
      }
    }
  }

  @override
  void dispose() {
    _referenciaController.dispose();
    _pesoBaseController.dispose();
    for (var row in _materialesPrincipalesControllers) {
      row['nombre']?.dispose();
      row['categoria']?.dispose();
      row['cantidad']?.dispose();
    }
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('¿Salir?'),
            content: const Text('¿Estás seguro de que quieres salir sin guardar los cambios?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Salir'),
              ),
            ],
          ),
        );
        if (shouldPop == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
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
                  keyboardType: TextInputType.number,
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Materias Primas Principales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryIndustrial,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _agregarMaterialPrincipalRow(),
                      icon: const Icon(Icons.add),
                      label: const Text('Añadir Principal'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                ..._materialesPrincipalesControllers.asMap().entries.map((entry) {
                  int idx = entry.key;
                  var row = entry.value;
                  
                  return Padding(
                    key: ValueKey('main_mat_$idx'),
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        // 1. SILO
                        SizedBox(
                          width: 85,
                          child: DropdownButtonFormField<String>(
                            value: _opcionesSilos.contains(row['nombre']?.text) 
                                ? row['nombre']?.text 
                                : _opcionesSilos[0],
                            decoration: const InputDecoration(
                              labelText: 'Silo',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            ),
                            items: _opcionesSilos.map((silo) => DropdownMenuItem(
                              value: silo, 
                              child: Text(silo.split(' ').last, style: const TextStyle(fontSize: 14))
                            )).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => row['nombre']?.text = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 6),
                        
                        // 2. MATERIA PRIMA / CLASIFICACIÓN
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: row['categoria'], // Usamos el controlador de categoría para el nombre libre
                            decoration: const InputDecoration(
                              labelText: 'Materia Prima / Clasificación',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        
                        // 3. KILOGRAMOS
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: row['cantidad'],
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Kg',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            ),
                          ),
                        ),
                        
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                          onPressed: () => _removerMaterialPrincipalRow(idx),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  );
                }),

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
                    key: ValueKey('aditivo_$idx'),
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
                                      
                                      // Buscar el aditivo en el catálogo y autocompletar el origen si existe
                                      try {
                                        final aditivoInfo = _catalogoAditivos.firstWhere((a) => a.nombre == val);
                                        if (aditivoInfo.origen != null && aditivoInfo.origen!.isNotEmpty) {
                                          row['origen']?.text = aditivoInfo.origen!;
                                        }
                                      } catch (_) {
                                        // Si no se encuentra o no tiene origen, no hace nada
                                      }
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
                        Builder(
                          builder: (context) {
                            final currentValue = row['origen']?.text ?? 'Minoritario 1';
                            final defaultOrigins = [
                              'Minoritario 1', 'Minoritario 2', 'Minoritario 3', 
                              'Minoritario 4', 'Minoritario 5', 'Minoritario 6', 
                              'Aglomerante PDF', 'Tlva Fibra'
                            ];
                            
                            // Conjunto de items únicos
                            final allItems = <String>{...defaultOrigins};
                            if (currentValue.isNotEmpty) allItems.add(currentValue);
                            
                            // Añadir orígenes del catálogo (solo los que no estén vacíos)
                            for (var adit in _catalogoAditivos) {
                              if (adit.origen != null && adit.origen!.isNotEmpty) {
                                allItems.add(adit.origen!);
                              }
                            }

                            return DropdownButtonFormField<String>(
                              value: allItems.contains(currentValue) ? currentValue : 'Minoritario 1',
                              decoration: const InputDecoration(
                                labelText: 'Tolva de Origen',
                                border: OutlineInputBorder(),
                              ),
                              items: allItems.map((opt) {
                                String label = opt;
                                if (opt == 'Tlva Fibra') label = 'Tolva Fibra (Tlva)';
                                return DropdownMenuItem(value: opt, child: Text(label));
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    row['origen']?.text = val;
                                  });
                                }
                              },
                            );
                          }
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _isSaving ? null : _guardarFormula,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: primaryIndustrial,
                    foregroundColor: Colors.white,
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
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
      ),
    );
  }
}
