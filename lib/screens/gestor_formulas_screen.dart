// Gestor de Fórmulas Screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:produccion_unificada/models/isar_formula.dart';
import 'package:produccion_unificada/services/database_service.dart';
import 'package:produccion_unificada/services/backup_service.dart';
import 'package:produccion_unificada/services/formula_state.dart';
import 'package:produccion_unificada/screens/agregar_formula_screen.dart';
import 'package:produccion_unificada/screens/gestor_aditivos_screen.dart';
import 'package:produccion_unificada/constants.dart';

class GestorFormulasScreen extends StatefulWidget {
  const GestorFormulasScreen({super.key});

  @override
  State<GestorFormulasScreen> createState() => _GestorFormulasScreenState();
}

class _GestorFormulasScreenState extends State<GestorFormulasScreen> with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _eliminarFormula(IsarFormula formula) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Eliminación'),
            content: Text(
              '¿Está seguro que desea eliminar la fórmula ${formula.referencia}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );

    if (confirmar == true) {
      final formulaEliminada = formula;
      await formulaState.eliminarFormula(formula.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fórmula ${formula.referencia} eliminada'),
            action: SnackBarAction(
              label: 'Deshacer',
              onPressed: () async {
                await formulaState.agregarFormula(formulaEliminada);
              },
            ),
          ),
        );
      }
    }
  }

  void _navegarAEdicion([IsarFormula? formula]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgregarFormulaScreen(formulaAEditar: formula),
      ),
    );
  }

  Future<void> _exportarBackup() async {
    final jsonStr = await DatabaseService.exportarDatosJson();
    
    if (!mounted) return;
    final guardado = await BackupService.guardarBackupLocal(
      context,
      jsonStr,
    );
    
    if (!mounted) return;
    if (guardado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copia de seguridad guardada con éxito.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _importarBackup() async {
    final jsonStr = await BackupService.cargarBackupLocal(context);
    
    if (!mounted) return;
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final procesados = await DatabaseService.importarDatosJson(
          jsonStr,
        );
        await formulaState.cargarFormulas();
        
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Se restauraron/agregaron $procesados fórmulas exitosamente.',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al importar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fState = context.watch<FormulaState>();
    final formulas = fState.formulas;
    final isLoading = fState.isLoading;

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final sq = _searchQuery.toLowerCase();
    
    final grises = formulas.where((f) => 
      f.esBlanca == false && 
      (f.referencia?.toLowerCase().contains(sq) ?? false)
    ).toList();
    
    final blancas = formulas.where((f) => 
      f.esBlanca == true && 
      (f.referencia?.toLowerCase().contains(sq) ?? false)
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Fórmulas'),
        backgroundColor: primaryIndustrial,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'exportar') {
                await _exportarBackup();
              } else if (value == 'importar') {
                await _importarBackup();
              } else if (value == 'aditivos') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GestorAditivosScreen(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'exportar',
                  child: ListTile(
                    leading: Icon(Icons.upload_file),
                    title: Text('Exportar Backup'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'importar',
                  child: ListTile(
                    leading: Icon(Icons.download),
                    title: Text('Restaurar Backup'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'aditivos',
                  child: ListTile(
                    leading: Icon(Icons.science),
                    title: Text('Gestionar Aditivos'),
                  ),
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.amber,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          controller: _tabController,
          tabs: const [Tab(text: 'Fórmulas Grises'), Tab(text: 'Fórmulas Blancas')],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Buscar Referencia',
                hintText: 'Ej. 901...',
                prefixIcon: const Icon(Icons.search, color: primaryIndustrial),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildListaFormulas(grises), _buildListaFormulas(blancas)],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryIndustrial,
        foregroundColor: Colors.white,
        onPressed: () => _navegarAEdicion(),
        icon: const Icon(Icons.add),
        label: const Text('Nueva Fórmula'),
      ),
    );
  }

  Widget _buildListaFormulas(List<IsarFormula> lista) {
    if (lista.isEmpty) {
      return const Center(
        child: Text(
          'No hay fórmulas guardadas en esta categoría.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80), // Espacio para el FAB
      itemCount: lista.length,
      itemBuilder: (context, index) {
        final f = lista[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  f.esBlanca == true ? Colors.blueGrey[100] : Colors.grey[400],
              child: Icon(
                Icons.science,
                color: f.esBlanca == true ? Colors.blue[800] : Colors.black87,
              ),
            ),
            title: Text(
              f.referencia ?? 'Sin Ref',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(
              'Base: ${f.pesoBaseKg} kg | Aditivos: ${f.aditivos?.length ?? 0}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _navegarAEdicion(f),
                  tooltip: 'Editar Fórmula',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _eliminarFormula(f),
                  tooltip: 'Eliminar Fórmula',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
