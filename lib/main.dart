// Archivo: lib/main.dart

// Vamos a explicar cada línea de este archivo de manera sencilla, para alguien que está aprendiendo Flutter y programación en general.

// Las siguientes líneas son "importaciones". Sirven para decirle al proyecto qué herramientas y archivos va a usar más adelante:
import 'package:flutter/services.dart'; // Permite realizar tareas con el sistema, como cerrar la app.
import 'package:flutter/material.dart';  // Importa todo lo necesario para hacer apps con Material Design.
import 'package:provider/provider.dart'; // Importa Provider, una herramienta para manejar el estado (datos que cambian).
import 'package:calproind/screens/calculadora_rollos_screen.dart';
import 'package:calproind/screens/calculadora_proporciones_screen.dart';
import 'package:calproind/constants.dart';

import 'package:calproind/services/database_service.dart';       // Servicio para la base de datos de la app.
import 'package:calproind/services/preferencias_service.dart';   // Servicio que maneja las preferencias del usuario.
import 'package:calproind/services/formula_state.dart';          // Aquí está la gestión de las fórmulas.
import 'package:calproind/screens/gestor_formulas_screen.dart';  // Pantalla para ver/agregar fórmulas.
import 'package:calproind/screens/configuracion_rollos_screen.dart'; // Pantalla para configuración de rollos.
import 'package:calproind/screens/gestor_aditivos_screen.dart';      // Pantalla para gestionar aditivos.

// Esta es la función principal, el punto de inicio de toda aplicación Flutter.
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Esto asegura que todo esté listo antes de iniciar la app.
  await DatabaseService.init();  // Inicializamos el servicio de base de datos (preparamos y abrimos la base de datos).
  await PreferenciasService.init(); // Cargamos las preferencias del usuario almacenadas.
  await formulaState.cargarFormulas(); // Cargamos todas las fórmulas que hay almacenadas.
  runApp(const AplicacionUnificada()); // Aquí se inicia la app mostrando el widget principal.
}

// La siguiente clase representa la app principal.
class AplicacionUnificada extends StatelessWidget {
  const AplicacionUnificada({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí le decimos a Flutter cómo debe lucir y comportarse la app.
    // ChangeNotifierProvider permite que partes de la app reaccionen cuando cambian las fórmulas.
    return ChangeNotifierProvider.value(
      value: formulaState,
      child: MaterialApp(
        title: 'CalProInd (Rollos)', // Nombre que puede usarse en el sistema operativo.
        theme: ThemeData(
          primarySwatch: primaryIndustrial,             // Color principal de la app, definido en constants.dart.
          scaffoldBackgroundColor: Colors.white,         // Fondo principal en blanco.
          appBarTheme: const AppBarTheme(                // Configuración para las barras superiores.
            backgroundColor: primaryIndustrial,          // Color de fondo.
            foregroundColor: Colors.white,               // Color del texto y los íconos.
            elevation: 0,                                // Sin sombra debajo de la barra.
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity, // Ajusta el tamaño visual según el dispositivo.
        ),
        home: const HomeScreen(),            // Pantalla inicial de la app.
        debugShowCheckedModeBanner: false,   // Quita la franja "Debug" roja al lado de la pantalla.
      ),
    );
  }
}

// Este widget es la pantalla principal que verá el usuario.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Este es el estado de la pantalla principal. Controla, por ejemplo, qué pestaña está activa.
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController; // Controla las pestañas.

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Crea dos pestañas ("Proporciones" y "Rollos").
  }

  @override
  void dispose() {
    _tabController.dispose(); // Libera el controlador cuando no se necesita más.
    super.dispose();
  }

  // Aquí se define cómo se debe ver toda la pantalla principal.
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Estructura básica de una pantalla en Flutter.
      appBar: AppBar( // Barra superior de la app.
        title: const Text('Calculadora de Produccion'),
        bottom: TabBar( // Aquí agregamos las pestañas.
          controller: _tabController,     // Controlador de las pestañas.
          indicatorColor: Colors.amber,   // Color de la línea bajo la pestaña activa.
          labelColor: Colors.white,       // Color del texto en la pestaña activa.
          unselectedLabelColor: Colors.white70, // Color de texto en pestañas inactivas.
          tabs: const [
            Tab(icon: Icon(Icons.science), text: 'Proporciones'), // Primera pestaña.
            Tab(icon: Icon(Icons.inventory_2), text: 'Rollos'),   // Segunda pestaña.
          ],
        ),
        actions: [ // Botones que aparecen a la derecha de la AppBar.
          PopupMenuButton<String>( // Botón de menú con varias opciones.
            icon: const Icon(Icons.settings),
            tooltip: 'Configuración y Gestores',
            onSelected: (value) async { // Qué hacer cuando eliges una opción del menú.
              switch (value) {
                case 'formulas':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GestorFormulasScreen()),
                  );
                  break;
                case 'rollos':
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ConfiguracionRollosScreen()),
                  );
                  break;
                case 'aditivos':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GestorAditivosScreen()),
                  );
                  break;
                case 'sync':
                  // Sincronización: Recarga de datos desde un origen principal (por ejemplo, reiniciar datos por defecto).
                  final confirmar = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar Sincronización'),
                      content: const Text(
                        'Esta acción sobrescribirá todas las fórmulas actuales con los datos predeterminados. '
                        'Se perderán los cambios manuales que no hayan sido exportados. '
                        '¿Desea continuar?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text(
                            'Sincronizar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (confirmar != true) break;

                  final count = await DatabaseService.seedInitialData(force: true);
                  await formulaState.cargarFormulas();
                  // Si sigue en pantalla, muestra mensaje que terminó la sincronización y cuántos datos hay.
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Sincronización Completada. Fórmulas en BD: $count'),
                      ),
                    );
                  }
                  break;
              }
            },
            // Estas son las opciones que aparecen al desplegar el menú.
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'formulas',
                child: ListTile(
                  leading: Icon(Icons.list_alt, color: Colors.indigo),
                  title: Text('Gestor de Fórmulas'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'aditivos',
                child: ListTile(
                  leading: Icon(Icons.category, color: Colors.orange),
                  title: Text('Catálogo de Aditivos'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'rollos',
                child: ListTile(
                  leading: Icon(Icons.settings_applications, color: Colors.teal),
                  title: Text('Ajustes de Rollos'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuDivider(), // Línea separadora en el menú
              const PopupMenuItem(
                value: 'sync',
                child: ListTile(
                  leading: Icon(Icons.sync, color: Colors.blue),
                  title: Text('Sincronizar Datos'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Salir',
            onPressed: () {
              SystemNavigator.pop(); // Al presionar, se cierra la aplicación.
            },
          ),
          const SizedBox(width: 8), // Espacio pequeño al final de la barra.
        ],
      ),
      body: TabBarView( // Aquí se muestran los contenidos de cada pestaña.
        controller: _tabController,
        children: const [
          CalculadoraProporcionesScreen(), // Pantalla para calcular proporciones.
          CalculadoraRollosScreen(),       // Pantalla para calcular rollos.
        ],
      ),
    );
  }
}
