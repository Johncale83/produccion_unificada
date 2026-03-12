import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/isar_formula.dart';
import '../constants.dart';

class GestorAditivosScreen extends StatefulWidget {
  const GestorAditivosScreen({super.key});

  @override
  State<GestorAditivosScreen> createState() => _GestorAditivosScreenState();
}

class _GestorAditivosScreenState extends State<GestorAditivosScreen> {
  final TextEditingController _nuevoAditivoController = TextEditingController();
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
    if (nombre.isEmpty) return;

    await DatabaseService.addAditivoCatalogo(nombre);
    _nuevoAditivoController.clear();
    await _cargarAditivos();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Aditivo "$nombre" agregado al catálogo.')),
      );
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nuevoAditivoController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del nuevo aditivo',
                      hintText: 'Ej: Wekcelo HD',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _agregarAditivo(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _agregarAditivo,
                  icon: const Icon(Icons.add),
                  label: const Text('Añadir'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryIndustrial,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _eliminarAditivo(aditivo),
                              tooltip: 'Eliminar del catálogo',
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
