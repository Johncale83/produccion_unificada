// Archivo: lib/screens/calculadora_bobinas_solo_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:calproind/constants.dart';
import 'package:calproind/services/configuracion_rollos_service.dart';
import 'package:calproind/services/preferencias_service.dart';
import 'package:calproind/calculadora_logica.dart';

class CalculadoraBobinasSoloScreen extends StatefulWidget {
  const CalculadoraBobinasSoloScreen({super.key});

  @override
  State<CalculadoraBobinasSoloScreen> createState() => _CalculadoraBobinasSoloScreenState();
}

class _CalculadoraBobinasSoloScreenState extends State<CalculadoraBobinasSoloScreen> {
  final TextEditingController _grosorController = TextEditingController();
  
  final List<int> _formatosDisponibles = [10, 20, 25, 30, 40];
  int _formatoSeleccionado = 25;
  
  double _pesoTotalKg = 0.0;
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

    if (grosorCm == null || grosorCm <= 0) return;

    final cfg = _config;
    final diametro = cfg?.diametroNucleoCm ?? diametroNucleoCm;
    final ancho = cfg?.anchosPorFormato[_formatoSeleccionado] ?? 45.0;

    // 1. Área Transversal (cm2)
    final double rCore = diametro / 2.0;
    final double rTotal = rCore + grosorCm;
    final double areaTransversal = pi * (pow(rTotal, 2) - pow(rCore, 2));

    // 2. Volumen y Peso
    final double volumenCm3 = areaTransversal * ancho;
    final double pesoKg = (volumenCm3 * 0.92) / 1000.0;

    setState(() {
      _pesoTotalKg = pesoKg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputSection(),
            const SizedBox(height: 30),
            _buildResultSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Configuración del Cálculo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),
            
            const Text('Formato (Determina el ancho)', style: TextStyle(fontSize: 14, color: Colors.grey)),
            DropdownButton<int>(
              value: _formatoSeleccionado,
              isExpanded: true,
              items: _formatosDisponibles.map((f) => DropdownMenuItem(value: f, child: Text('$f kg'))).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _formatoSeleccionado = val);
                  _calcular();
                }
              },
            ),
            const SizedBox(height: 20),
            
            const Text('Grosor del plástico en el rollo (cm)', style: TextStyle(fontSize: 14, color: Colors.grey)),
            TextField(
              controller: _grosorController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Ej: 2.5',
                suffixText: 'cm',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.done, color: primaryIndustrial),
                  tooltip: 'Listo',
                  onPressed: () => FocusScope.of(context).unfocus(),
                ),
                border: const OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                _calcular();
                FocusScope.of(context).unfocus();
              },
              onChanged: (_) => _calcular(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection() {
    return Column(
      children: [
        _ResultTile(
          label: 'PESO ESTIMADO DEL ROLLO',
          value: '${_pesoTotalKg.toStringAsFixed(2)} kg',
          icon: Icons.scale,
          color: primaryIndustrial,
        ),
        const SizedBox(height: 15),
        Text(
          'Basado en ancho de ${_config?.anchosPorFormato[_formatoSeleccionado] ?? defaultAnchosPorFormato[_formatoSeleccionado]}cm y densidad 0.92g/cm³',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}

class _ResultTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _ResultTile({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
