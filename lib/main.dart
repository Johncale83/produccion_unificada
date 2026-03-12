// Archivo: lib/main.dart

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'calculadora_rollos_screen.dart';
import 'calculadora_proporciones_screen.dart';
import 'constants.dart';

import 'package:produccion_unificada/services/database_service.dart';
import 'package:produccion_unificada/screens/gestor_formulas_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.init();
  runApp(const AplicacionUnificada());
}

class AplicacionUnificada extends StatelessWidget {
  const AplicacionUnificada({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Producción',
      theme: ThemeData(
        primarySwatch: primaryIndustrial,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryIndustrial,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      // Oculta la franja roja de debug
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Producción'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Forzar Sincronización de Base de Datos',
            onPressed: () async {
              await DatabaseService.seedInitialData();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sincronización de Base de Datos Completada'),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Salir',
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CollapsibleSection(
              title: 'Proporciones de Materiales',
              icon: Icons.science,
              initiallyExpanded: true,
              child: CalculadoraProporcionesScreen(),
            ),
            Divider(thickness: 2, height: 2),
            _CollapsibleSection(
              title: 'Calculadora de Rollos',
              icon: Icons.inventory_2,
              initiallyExpanded: false,
              child: CalculadoraRollosScreen(),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton.extended(
            backgroundColor: primaryIndustrial,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GestorFormulasScreen(),
                ),
              );
            },
            icon: const Icon(Icons.list_alt),
            label: const Text('Gestor de Fórmulas'),
          );
        },
      ),
    );
  }
}

// === Widget personalizado que mantiene el estado al colapsar ===
class _CollapsibleSection extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final bool initiallyExpanded;

  const _CollapsibleSection({
    required this.title,
    required this.icon,
    required this.child,
    this.initiallyExpanded = true,
  });

  @override
  State<_CollapsibleSection> createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<_CollapsibleSection> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            color: const Color(0xFFEEF0FF),
            child: Row(
              children: [
                Icon(widget.icon, color: primaryIndustrial, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryIndustrial,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: primaryIndustrial,
                ),
              ],
            ),
          ),
        ),
        // Visibility(maintainState: true) mantiene el widget vivo en el arbol
        // aunque no sea visible → el estado (resultados, formula, etc.) se preserva
        Visibility(
          maintainState: true,
          visible: _expanded,
          child: widget.child,
        ),
      ],
    );
  }
}
