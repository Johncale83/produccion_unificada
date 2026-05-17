// Archivo: lib/main_rollos.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calproind/constants.dart';
import 'package:calproind/services/preferencias_service.dart';
import 'package:calproind/screens/calculadora_rollos_solo_screen.dart';
import 'package:calproind/screens/calculadora_bobinas_solo_screen.dart';
import 'package:calproind/screens/calculadora_estibas_screen.dart';
import 'package:calproind/screens/configuracion_rollos_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenciasService.init();
  runApp(const AppSoloRollos());
}

class AppSoloRollos extends StatelessWidget {
  const AppSoloRollos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Plástico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryIndustrial,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryIndustrial,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const RollosHomeScreen(),
    );
  }
}

class RollosHomeScreen extends StatefulWidget {
  const RollosHomeScreen({super.key});

  @override
  State<RollosHomeScreen> createState() => _RollosHomeScreenState();
}

class _RollosHomeScreenState extends State<RollosHomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _refreshCounter = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Produccion'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.scale), text: 'KG Rollo'),
            Tab(icon: Icon(Icons.inventory_2), text: 'Empaque'),
            Tab(icon: Icon(Icons.layers), text: 'Estibas'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Configuración de Rollos',
            onPressed: () async {
              final refresh = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ConfiguracionRollosScreen()),
              );
              if (refresh == true) {
                setState(() {
                  _refreshCounter++;
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => SystemNavigator.pop(),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CalculadoraBobinasSoloScreen(key: ValueKey('bobinas_$_refreshCounter')),
          CalculadoraRollosSoloScreen(key: ValueKey('rollos_$_refreshCounter')),
          const CalculadoraEstibasScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: const Text(
          'Desarrollado por Jhon Calentura',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
