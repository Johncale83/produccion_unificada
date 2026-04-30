// Archivo: lib/screens/configuracion_rollos_screen.dart
// Pantalla de configuración para editar los parámetros de la calculadora de rollos.

import 'package:flutter/material.dart';
import 'package:calproind/constants.dart';
import 'package:calproind/services/configuracion_rollos_service.dart';

class ConfiguracionRollosScreen extends StatefulWidget {
  const ConfiguracionRollosScreen({super.key});

  @override
  State<ConfiguracionRollosScreen> createState() =>
      _ConfiguracionRollosScreenState();
}

class _ConfiguracionRollosScreenState
    extends State<ConfiguracionRollosScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para campos generales
  final _diametroController = TextEditingController();
  final _calibreController = TextEditingController();

  // Controladores para longitudes de bolsa por formato
  final _long10Controller = TextEditingController();
  final _long20Controller = TextEditingController();
  final _long25Controller = TextEditingController();
  final _long30Controller = TextEditingController();
  final _long40Controller = TextEditingController();

  // Controladores para bolsas por estiba
  final _estiba10Controller = TextEditingController();
  final _estiba20Controller = TextEditingController();
  final _estiba25Controller = TextEditingController();
  final _estiba30Controller = TextEditingController();
  final _estiba40Controller = TextEditingController();

  // Controladores para anchos por formato
  final _ancho10Controller = TextEditingController();
  final _ancho20Controller = TextEditingController();
  final _ancho25Controller = TextEditingController();
  final _ancho30Controller = TextEditingController();
  final _ancho40Controller = TextEditingController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _cargarConfiguracion();
  }

  Future<void> _cargarConfiguracion() async {
    final config = await ConfiguracionRollosService.cargar();
    setState(() {
      _diametroController.text = config.diametroNucleoCm.toString();
      _calibreController.text = config.calibrePlasticoMicras.toString();
      _long10Controller.text = config.longitudesPorFormato[10]!.toString();
      _long20Controller.text = config.longitudesPorFormato[20]!.toString();
      _long25Controller.text = config.longitudesPorFormato[25]!.toString();
      _long30Controller.text = config.longitudesPorFormato[30]!.toString();
      _long40Controller.text = config.longitudesPorFormato[40]!.toString();
      _estiba10Controller.text =
          config.bolsasPorEstibaPorFormato[10]!.toString();
      _estiba20Controller.text =
          config.bolsasPorEstibaPorFormato[20]!.toString();
      _estiba25Controller.text =
          config.bolsasPorEstibaPorFormato[25]!.toString();
      _estiba30Controller.text =
          config.bolsasPorEstibaPorFormato[30]!.toString();
      _estiba40Controller.text =
          config.bolsasPorEstibaPorFormato[40]!.toString();
      _ancho10Controller.text = config.anchosPorFormato[10]!.toString();
      _ancho20Controller.text = config.anchosPorFormato[20]!.toString();
      _ancho25Controller.text = config.anchosPorFormato[25]!.toString();
      _ancho30Controller.text = config.anchosPorFormato[30]!.toString();
      _ancho40Controller.text = config.anchosPorFormato[40]!.toString();
      _loading = false;
    });
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    final config = ConfiguracionRollos(
      diametroNucleoCm:
          double.parse(_diametroController.text.replaceAll(',', '.')),
      calibrePlasticoMicras:
          double.parse(_calibreController.text.replaceAll(',', '.')),
      longitudesPorFormato: {
        10: double.parse(_long10Controller.text.replaceAll(',', '.')),
        20: double.parse(_long20Controller.text.replaceAll(',', '.')),
        25: double.parse(_long25Controller.text.replaceAll(',', '.')),
        30: double.parse(_long30Controller.text.replaceAll(',', '.')),
        40: double.parse(_long40Controller.text.replaceAll(',', '.')),
      },
      bolsasPorEstibaPorFormato: {
        10: int.parse(_estiba10Controller.text),
        20: int.parse(_estiba20Controller.text),
        25: int.parse(_estiba25Controller.text),
        30: int.parse(_estiba30Controller.text),
        40: int.parse(_estiba40Controller.text),
      },
      anchosPorFormato: {
        10: double.parse(_ancho10Controller.text.replaceAll(',', '.')),
        20: double.parse(_ancho20Controller.text.replaceAll(',', '.')),
        25: double.parse(_ancho25Controller.text.replaceAll(',', '.')),
        30: double.parse(_ancho30Controller.text.replaceAll(',', '.')),
        40: double.parse(_ancho40Controller.text.replaceAll(',', '.')),
      },
    );
    await ConfiguracionRollosService.guardar(config);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Configuración guardada correctamente'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true); // Devuelve true para forzar recarga
    }
  }

  Future<void> _restaurarDefectos() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restaurar valores por defecto'),
        content: const Text(
            '¿Estás seguro? Se restaurarán todos los valores originales de la calculadora.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text('Restaurar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirmar == true) {
      await ConfiguracionRollosService.restaurarDefectos();
      await _cargarConfiguracion();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Valores restaurados al original')),
        );
      }
    }
  }

  @override
  void dispose() {
    for (final c in [
      _diametroController, _calibreController,
      _long10Controller, _long20Controller, _long25Controller, _long30Controller, _long40Controller,
      _estiba10Controller, _estiba20Controller, _estiba25Controller, _estiba30Controller, _estiba40Controller,
      _ancho10Controller, _ancho20Controller, _ancho25Controller, _ancho30Controller, _ancho40Controller,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Rollos'),
        backgroundColor: primaryIndustrial,
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Restaurar valores por defecto',
            onPressed: _restaurarDefectos,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ─── SECCIÓN: Parámetros del rollo ───
              _sectionHeader('Parámetros del Rollo', Icons.settings),
              const SizedBox(height: 12),
              _campoDecimal(
                controller: _diametroController,
                label: 'Diámetro del núcleo (cm)',
                hint: 'Ej: 9.5',
              ),
              const SizedBox(height: 12),
              _campoDecimal(
                controller: _calibreController,
                label: 'Calibre del plástico (micras)',
                hint: 'Ej: 110',
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 24),

              // ─── SECCIÓN: Longitud de bolsa por formato ───
              _sectionHeader('Longitud de Bolsa por Formato', Icons.straighten),
              const SizedBox(height: 4),
              const Text(
                'Longitud de corte de cada bolsa según el formato de empaque.',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _campoDecimal(controller: _long10Controller, label: '10 kg (cm)', hint: '45')),
                const SizedBox(width: 12),
                Expanded(child: _campoDecimal(controller: _long20Controller, label: '20 kg (cm)', hint: '58')),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _campoDecimal(controller: _long25Controller, label: '25 kg (cm)', hint: '64')),
                const SizedBox(width: 12),
                Expanded(child: _campoDecimal(controller: _long30Controller, label: '30 kg (cm)', hint: '64')),
              ]),
              const SizedBox(height: 12),
              _campoDecimal(controller: _long40Controller, label: '40 kg (cm)', hint: '70'),
              const SizedBox(height: 24),

              // ─── SECCIÓN: Ancho por Formato (KG Rollo) ───
              _sectionHeader('Ancho por Formato (KG Rollo)', Icons.swap_horiz),
              const SizedBox(height: 4),
              const Text(
                'Ancho físico de la película plástica para el cálculo de peso (kg).',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _campoDecimal(controller: _ancho10Controller, label: '10 kg (cm)', hint: '35')),
                const SizedBox(width: 12),
                Expanded(child: _campoDecimal(controller: _ancho20Controller, label: '20 kg (cm)', hint: '45')),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _campoDecimal(controller: _ancho25Controller, label: '25 kg (cm)', hint: '45')),
                const SizedBox(width: 12),
                Expanded(child: _campoDecimal(controller: _ancho30Controller, label: '30 kg (cm)', hint: '45')),
              ]),
              const SizedBox(height: 12),
              _campoDecimal(controller: _ancho40Controller, label: '40 kg (cm)', hint: '50'),
              const SizedBox(height: 24),

              // ─── SECCIÓN: Bolsas por estiba ───
              _sectionHeader('Bolsas por Estiba', Icons.layers),
              const SizedBox(height: 4),
              const Text(
                'Cantidad de bolsas que caben en una estiba según el formato.',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _campoEntero(controller: _estiba10Controller, label: '10 kg', hint: '100')),
                const SizedBox(width: 12),
                Expanded(child: _campoEntero(controller: _estiba20Controller, label: '20 kg', hint: '70')),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _campoEntero(controller: _estiba25Controller, label: '25 kg', hint: '60')),
                const SizedBox(width: 12),
                Expanded(child: _campoEntero(controller: _estiba30Controller, label: '30 kg', hint: '45')),
              ]),
              const SizedBox(height: 12),
              _campoEntero(controller: _estiba40Controller, label: '40 kg', hint: '35'),
              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: _guardar,
                icon: const Icon(Icons.save),
                label: const Text('GUARDAR CONFIGURACIÓN',
                    style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: primaryIndustrial[900],
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryIndustrial, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryIndustrial,
          ),
        ),
      ],
    );
  }

  Widget _campoDecimal({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val == null || val.isEmpty) return 'Requerido';
        if (double.tryParse(val.replaceAll(',', '.')) == null) {
          return 'Número inválido';
        }
        return null;
      },
    );
  }

  Widget _campoEntero({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val == null || val.isEmpty) return 'Requerido';
        if (int.tryParse(val) == null) return 'Número entero inválido';
        return null;
      },
    );
  }
}
