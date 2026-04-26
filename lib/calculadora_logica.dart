// Archivo: lib/calculadora_logica.dart

import 'dart:math';

// --- Constantes del Rollo (Fijas) ---
const double diametroNucleoCm = 9.5;
const double calibrePlasticoMicras = 110.0;

// --- ESTRUCTURA 1: Longitud de la bolsa por formato (en cm) ---
const Map<int, double> longitudesPorFormato = {
  10: 18.0,
  20: 58.0,
  25: 64.0,
  30: 64.0,
  40: 70.0,
};

// --- ESTRUCTURA 2: Ancho de bobina por defecto (en cm) ---
const Map<int, double> defaultAnchosPorFormato = {
  10: 68.0,
  20: 82.46,
  25: 82.46,
  30: 104.8,
  40: 104.8,
};

// --- ESTRUCTURA 3: Bolsas por estiba según el formato (Capacidad variable) ---
const Map<int, int> bolsasPorEstibaPorFormato = {
  10: 140,
  20: 70,
  25: 60,
  30: 45,
  40: 35,
};

/// Calcula todas las métricas de producción y empaque de un rollo.
Map<String, int> calcularProduccionYEmpaque({
  required double grosorPlasticoCm,
  required int formatoKg,
}) {
  final double? longitudBolsaCm = longitudesPorFormato[formatoKg];
  final int? bolsasPorEstiba = bolsasPorEstibaPorFormato[formatoKg];

  if (longitudBolsaCm == null || bolsasPorEstiba == null) {
    throw Exception(
      "Datos de formato $formatoKg kg incompletos o no encontrados.",
    );
  }

  // Cálculos intermedios
  final double calibrePlasticoCmFinal = calibrePlasticoMicras / 10000.0;
  final double radioNucleoCm = diametroNucleoCm / 2.0;
  final double radioTotalRolloCm = radioNucleoCm + grosorPlasticoCm;

  final double areaTransversalPlasticoCm2 =
      pi * (pow(radioTotalRolloCm, 2) - pow(radioNucleoCm, 2));

  final double longitudTotalPlasticoCm =
      areaTransversalPlasticoCm2 / calibrePlasticoCmFinal;

  // Número de Bolsas
  final int numeroBolsas = (longitudTotalPlasticoCm / longitudBolsaCm).floor();

  // Cálculos de Empaque
  final int cantidadTotalEstibas = (numeroBolsas / bolsasPorEstiba).floor();

  final int cantidadBultosAdicionales = numeroBolsas % bolsasPorEstiba;

  return {
    'numeroBolsas': numeroBolsas,
    'cantidadTotalEstibas': cantidadTotalEstibas,
    'cantidadBultosAdicionales': cantidadBultosAdicionales,
  };
}

/// Versión configurable: acepta parámetros de entorno en lugar de usar constantes.
/// Usada cuando el usuario ha personalizado los valores en la pantalla de configuración.
Map<String, int> calcularProduccionYEmpaqueConConfig({
  required double grosorPlasticoCm,
  required int formatoKg,
  required Map<int, double> longitudesPorFormato,
  required Map<int, int> bolsasPorEstibaPorFormato,
  required double diametroNucleoCm,
  required double calibrePlasticoMicras,
}) {
  final double? longitudBolsaCm = longitudesPorFormato[formatoKg];
  final int? bolsasPorEstiba = bolsasPorEstibaPorFormato[formatoKg];

  if (longitudBolsaCm == null || bolsasPorEstiba == null) {
    throw Exception(
      "Datos de formato $formatoKg kg incompletos o no encontrados.",
    );
  }

  final double calibreCm = calibrePlasticoMicras / 10000.0;
  final double radioNucleoCm = diametroNucleoCm / 2.0;
  final double radioTotalRolloCm = radioNucleoCm + grosorPlasticoCm;

  final double areaAnilloCm2 =
      pi * (pow(radioTotalRolloCm, 2) - pow(radioNucleoCm, 2));

  final double longitudTotalCm = areaAnilloCm2 / calibreCm;

  final int numeroBolsas = (longitudTotalCm / longitudBolsaCm).floor();
  final int cantidadTotalEstibas = (numeroBolsas / bolsasPorEstiba).floor();
  final int cantidadBultosAdicionales = numeroBolsas % bolsasPorEstiba;

  return {
    'numeroBolsas': numeroBolsas,
    'cantidadTotalEstibas': cantidadTotalEstibas,
    'cantidadBultosAdicionales': cantidadBultosAdicionales,
  };
}
