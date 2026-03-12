// Archivo: lib/calculadora_logica.dart

import 'dart:math';

// --- Constantes del Rollo (Fijas) ---
const double diametroNucleoCm = 9.5;
const double calibrePlasticoMicras = 110.0;

// --- ESTRUCTURA 1: Longitud de la bolsa por formato (en cm) ---
const Map<int, double> longitudesPorFormato = {
  20: 58.0,
  25: 64.0,
  30: 64.0,
  40: 70.0,
};

// --- ESTRUCTURA 2: Bolsas por estiba según el formato (Capacidad variable) ---
const Map<int, int> bolsasPorEstibaPorFormato = {
  20: 70, // 20 kg -> 70 bolsas/estiba
  25: 60, // 25 kg -> 60 bolsas/estiba
  30: 45, // 30 kg -> 45 bolsas/estiba
  40: 35, // 40 kg -> 35 bolsas/estiba
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
