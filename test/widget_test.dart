import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion_unificada/main.dart';

void main() {
  testWidgets('La aplicación completa carga correctamente', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;

    // Prueba la aplicación completa tal como se lanza en main.dart
    await tester.pumpWidget(const AplicacionUnificada());

    await tester.pumpAndSettle();

    // Verificar elementos clave
    expect(find.text('Calculadora de Producción Unificada'), findsOneWidget);
    expect(find.text('Rollos y Empaque'), findsOneWidget);
    expect(find.text('Proporciones y Material'), findsOneWidget);

    // Verificar que el contenido de la primera pestaña es visible
    expect(find.text('1. Formato de Empaque (Kg)'), findsOneWidget);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
