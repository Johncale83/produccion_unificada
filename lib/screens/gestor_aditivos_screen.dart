import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:produccion_unificada/services/database_service.dart';
import 'package:produccion_unificada/models/isar_formula.dart';
import 'package:produccion_unificada/services/formula_state.dart';
import 'package:produccion_unificada/constants.dart';

class GestorAditivosScreen extends StatefulWidget {
  const GestorAditivosScreen({super.key});

  @override
  State<GestorAditivosScreen> createState() => _GestorAditivosScreenState();
}

class _GestorAditivosScreenState extends State<GestorAditivosScreen> {
  final TextEditingController _nuevoAditivoController = TextEditingController();
  final TextEditingController _nuevoOrigenController = TextEditingController();
  final TextEditingController _nuevoPesoBultoController = TextEditingController(text: '25.0');
  List<IsarCatalogoAditivo> _aditivos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarAditivos();
  }

  Future<void> _cargarAditivos() async {
    setState(() => _isLoading = true);
    final aditivos = await DatabaseService.getAditivosCatalogo();
    setState(() {
      _aditivos = aditivos;
      // Organize alphabetically
      _aditivos.sort((a, b) => (a.nombre ?? '').compareTo(b.nombre ?? ''));
      _isLoading = false;
    });
  }

  Future<void> _agregarAditivo() async {
    final nombre = _nuevoAditivoController.text.trim();
    final origen = _nuevoOrigenController.text.trim();
    final peso = double.tryParse(_nuevoPesoBultoController.text.trim()) ?? 25.0;

    if (nombre.isEmpty) return;

    await DatabaseService.addAditivoCatalogo(
      nombre, 
      origen: origen.isEmpty ? null : origen,
      pesoBulto: peso,
    );
    _nuevoAditivoController.clear();
    _nuevoOrigenController.clear();
    _nuevoPesoBultoController.text = '25.0';
    
    // IMPORTANTE: Refrescar el estado global para que la calculadora y otros lo vean
    if (mounted) {
      await Provider.of<FormulaState>(context, listen: false).cargarFormulas();
    }
    await _cargarAditivos();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Aditivo "$nombre" agregado al catálogo.')),
      );
    }
  }

  Future<void> _editarAditivo(IsarCatalogoAditivo aditivo) async {
    final nombreController = TextEditingController(text: aditivo.nombre);
    final origenController = TextEditingController(text: aditivo.origen);
    final pesoController = TextEditingController(text: (aditivo.pesoBulto ?? 25.0).toString());

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Aditivo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: origenController,
              decoration: const InputDecoration(labelText: 'Ubicación/Tolva'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pesoController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Peso por bulto (Kg)', suffixText: 'kg'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (result == true) {
      await DatabaseService.updateAditivoCatalogo(
        aditivo.id,
        nombreController.text,
        origenController.text,
        double.tryParse(pesoController.text) ?? 25.0,
      );
      if (mounted) {
        await Provider.of<FormulaState>(context, listen: false).cargarFormulas();
      }
      await _cargarAditivos();
    }
  }

  Future<void> _eliminarAditivo(IsarCatalogoAditivo aditivo) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Aditivo'),
        content: Text('¿Estás seguro de que deseas eliminar "${aditivo.nombre}" del catálogo global? Las fórmulas existentes no se alterarán, pero ya no podrás seleccionarlo en fórmulas nuevas.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseService.deleteAditivoCatalogo(aditivo.id);
      if (mounted) {
        await Provider.of<FormulaState>(context, listen: false).cargarFormulas();
      }
      await _cargarAditivos();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aditivo eliminado del catálogo.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nuevoAditivoController.dispose();
    _nuevoOrigenController.dispose();
    _nuevoPesoBultoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Aditivos'),
        backgroundColor: primaryIndustrial,
      ),
      body: Column(
        children: [
          // Sección para agregar nuevo aditivo
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[100],
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _nuevoAditivoController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre del aditivo',
                          hintText: 'Ej: Wekcelo HD',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _nuevoOrigenController,
                        decoration: const InputDecoration(
                          labelText: 'Ubicación',
                          hintText: 'Ej: Silo 10',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _nuevoPesoBultoController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Kg/Bulto',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) => _agregarAditivo(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _agregarAditivo,
                    icon: const Icon(Icons.add),
                    label: const Text('Añadir al Catálogo Global'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryIndustrial,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1, thickness: 1),

          // Lista de aditivos existentes
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _aditivos.isEmpty
                    ? const Center(child: Text('No hay aditivos en el catálogo. Agrega uno arriba.'))
                    : ListView.builder(
                        itemCount: _aditivos.length,
                        itemBuilder: (context, index) {
                          final aditivo = _aditivos[index];
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.indigo,
                              child: Icon(Icons.science, color: Colors.white),
                            ),
                            title: Text(
                              aditivo.nombre ?? 'Sin nombre',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              (aditivo.nombre?.toUpperCase().contains('AGLOMERANTE') ?? false) || (aditivo.origen?.toUpperCase().contains('PDF') ?? false)
                                  ? (aditivo.origen ?? 'Sin ubicación')
                                  : '${aditivo.origen ?? 'Sin ubicación'} • ${aditivo.pesoBulto ?? 25.0} kg/bulto',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.indigo),
                                  onPressed: () => _editarAditivo(aditivo),
                                  tooltip: 'Editar aditivo',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.pink),
                                  onPressed: () => _eliminarAditivo(aditivo),
                                  tooltip: 'Eliminar del catálogo',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
