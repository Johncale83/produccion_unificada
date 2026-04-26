// Archivo: lib/screens/calculadora_rollos_solo_screen.dart
import 'package:flutter/material.dart';
import 'package:produccion_unificada/calculadora_logica.dart';
import 'package:produccion_unificada/constants.dart';
import 'package:produccion_unificada/services/configuracion_rollos_service.dart';
import 'package:produccion_unificada/services/preferencias_service.dart';

class CalculadoraRollosSoloScreen extends StatefulWidget {
  const CalculadoraRollosSoloScreen({super.key});

  @override
  State<CalculadoraRollosSoloScreen> createState() => _CalculadoraRollosSoloScreenState();
}

class _CalculadoraRollosSoloScreenState extends State<CalculadoraRollosSoloScreen> {
  final TextEditingController _grosorController = TextEditingController();
  
  final List<int> _formatosDisponibles = [10, 20, 25, 30, 40];
  int _formatoSeleccionado = 25;
  
  int _resultadoBolsas = 0;
  int _resultadoEstibas = 0;
  int _resultadoBultosSobrantes = 0;
  String _mensajeError = '';
  
  ConfiguracionRollos? _config;

  @override
  void initState() {
    super.initState();
    _formatoSeleccionado = PreferenciasService.formatoRollos;
    _cargarConfiguracion();
  }

  Future<void> _cargarConfiguracion() async {
    final config = await ConfiguracionRollosService.cargar();
    if (mounted) setState(() => _config = config);
  }

  void _calcular() {
    final double? grosorCm = double.tryParse(_grosorController.text.replaceAll(',', '.'));

    if (grosorCm == null || grosorCm <= 0) {
      setState(() => _mensajeError = 'Ingrese un grosor válido.');
      return;
    }

    final cfg = _config;
    final res = calcularProduccionYEmpaqueConConfig(
      grosorPlasticoCm: grosorCm,
      formatoKg: _formatoSeleccionado,
      longitudesPorFormato: cfg?.longitudesPorFormato ?? longitudesPorFormato,
      bolsasPorEstibaPorFormato: cfg?.bolsasPorEstibaPorFormato ?? bolsasPorEstibaPorFormato,
      diametroNucleoCm: cfg?.diametroNucleoCm ?? diametroNucleoCm,
      calibrePlasticoMicras: cfg?.calibrePlasticoMicras ?? calibrePlasticoMicras,
    );

    setState(() {
      _resultadoBolsas = res['numeroBolsas']!;
      
      final int capEstiba = cfg?.bolsasPorEstibaPorFormato[_formatoSeleccionado] ?? bolsasPorEstibaPorFormato[_formatoSeleccionado]!;
      _resultadoEstibas = _resultadoBolsas ~/ capEstiba;
      _resultadoBultosSobrantes = _resultadoBolsas % capEstiba;
      _mensajeError = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildForm(),
          const SizedBox(height: 20),
          if (_mensajeError.isNotEmpty)
            Text(_mensajeError, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
          _buildResults(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: _formatoSeleccionado,
              decoration: const InputDecoration(labelText: 'Formato de empaque'),
              items: _formatosDisponibles.map((f) => DropdownMenuItem(value: f, child: Text('$f kg'))).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _formatoSeleccionado = val);
              },
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _grosorController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Grosor en el rollo (cm)',
                border: OutlineInputBorder(),
                suffixText: 'cm',
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                _calcular();
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _calcular,
                icon: const Icon(Icons.calculate),
                label: const Text('CALCULAR EMPAQUE',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: primaryIndustrial[900],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    if (_resultadoBolsas == 0) return const SizedBox.shrink();
    return Column(
      children: [
        _MetricCard(title: 'Bolsas Totales', value: '$_resultadoBolsas', icon: Icons.inventory_2, color: Colors.indigo),
        _MetricCard(title: 'Estibas Completas', value: '$_resultadoEstibas', icon: Icons.layers, color: Colors.green),
        _MetricCard(title: 'Bultos Adicionales', value: '$_resultadoBultosSobrantes', icon: Icons.more_horiz, color: Colors.orange),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withValues(alpha: 0.2), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        trailing: Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
