import 'package:flutter/material.dart';
import 'package:calproind/constants.dart';

class CalculadoraEstibasScreen extends StatefulWidget {
  const CalculadoraEstibasScreen({super.key});

  @override
  State<CalculadoraEstibasScreen> createState() => _CalculadoraEstibasScreenState();
}

class FormatoEstiba {
  final String nombre;
  final int kgPorBulto;
  final int bultosPorEstiba;

  FormatoEstiba(this.nombre, this.kgPorBulto, this.bultosPorEstiba);
}

class _CalculadoraEstibasScreenState extends State<CalculadoraEstibasScreen> {
  final TextEditingController _kgController = TextEditingController();

  final List<FormatoEstiba> formatos = [
    FormatoEstiba('10 kg', 10, 140),
    FormatoEstiba('20 kg', 20, 70),
    FormatoEstiba('25 kg Estándar', 25, 60),
    FormatoEstiba('25 kg Flex', 25, 45),
    FormatoEstiba('40 kg', 40, 35),
  ];

  late FormatoEstiba _formatoSeleccionado;

  double _totalBultos = 0;
  int _estibasCompletas = 0;
  int _bultosSueltos = 0;

  @override
  void initState() {
    super.initState();
    _formatoSeleccionado = formatos[2]; // 25 kg estándar por defecto
  }

  @override
  void dispose() {
    _kgController.dispose();
    super.dispose();
  }

  void _calcular() {
    final double? kgTotales = double.tryParse(_kgController.text);
    if (kgTotales != null && kgTotales > 0) {
      setState(() {
        _totalBultos = kgTotales / _formatoSeleccionado.kgPorBulto;
        // Tomamos la parte entera de los bultos para el cálculo de estibas (los decimales significan que sobra un poco de material que no alcanza a hacer un bulto completo)
        int bultosEnteros = _totalBultos.floor();
        
        _estibasCompletas = bultosEnteros ~/ _formatoSeleccionado.bultosPorEstiba;
        _bultosSueltos = bultosEnteros % _formatoSeleccionado.bultosPorEstiba;
      });
    } else {
      setState(() {
        _totalBultos = 0;
        _estibasCompletas = 0;
        _bultosSueltos = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Tarjeta de Entrada ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'KILOGRAMOS TOTALES',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _kgController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: '0',
                        suffixText: 'kg',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.done, color: primaryIndustrial),
                          tooltip: 'Listo',
                          onPressed: () => FocusScope.of(context).unfocus(),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryIndustrial, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: primaryIndustrial, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.blueGrey.withValues(alpha: 0.05),
                      ),
                      onChanged: (value) => _calcular(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Selección de Formato ---
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                'FORMATO DE EMPAQUE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: formatos.map((formato) {
                final bool isSelected = _formatoSeleccionado == formato;
                return ChoiceChip(
                  label: Text(formato.nombre),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _formatoSeleccionado = formato;
                      });
                      _calcular();
                    }
                  },
                  selectedColor: primaryIndustrial,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  elevation: isSelected ? 2 : 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '* ${_formatoSeleccionado.bultosPorEstiba} bultos por estiba (${_formatoSeleccionado.kgPorBulto} kg c/u)',
                style: const TextStyle(fontSize: 13, color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 25),

            // --- Tarjeta de Resultados ---
            Card(
              elevation: 4,
              color: primaryIndustrial,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Column(
                  children: [
                    const Icon(Icons.inventory_2, color: Colors.white70, size: 40),
                    const SizedBox(height: 10),
                    const Text(
                      'TOTAL BULTOS',
                      style: TextStyle(fontSize: 14, color: Colors.white70, letterSpacing: 1.5),
                    ),
                    Text(
                      _totalBultos > 0 
                          ? (_totalBultos % 1 == 0 ? _totalBultos.toInt().toString() : _totalBultos.toStringAsFixed(2)) 
                          : '0',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                      child: Divider(color: Colors.white30, thickness: 1),
                    ),
                    const Text(
                      'DISTRIBUCIÓN LÓGISTICA',
                      style: TextStyle(fontSize: 12, color: Colors.white70, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(fontSize: 24, color: Colors.white),
                        children: [
                          TextSpan(
                            text: '$_estibasCompletas',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.amberAccent),
                          ),
                          const TextSpan(text: ' Estiba(s)'),
                          if (_bultosSueltos > 0) ...[
                            const TextSpan(text: '\n+ '),
                            TextSpan(
                              text: '$_bultosSueltos',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.amberAccent),
                            ),
                            const TextSpan(text: ' Bultos Sueltos'),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
