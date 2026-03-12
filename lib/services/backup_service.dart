import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BackupService {
  /// Solicita al usuario dónde guardar el archivo JSON y lo escribe.
  static Future<bool> guardarBackupLocal(BuildContext context, String jsonContent) async {
    try {
      // Obtenemos una fecha formateada para el nombre por defecto
      final now = DateTime.now();
      final fechaFormateada = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
      
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: '¿Dónde desea guardar el Backup de sus Fórmulas?',
        fileName: 'formulas_backup_$fechaFormateada.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (outputFile == null) {
        // User canceled the picker
        return false;
      }

      // Asegurar que el archivo tenga la extensión correcta
      if (!outputFile.toLowerCase().endsWith('.json')) {
        outputFile = '$outputFile.json';
      }

      final File file = File(outputFile);
      await file.writeAsString(jsonContent);
      return true;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Error al guardar el backup: $e'), backgroundColor: Colors.red),
        );
      }
      return false;
    }
  }

  /// Solicita al usuario seleccionar un archivo JSON y devuelve su contenido de texto.
  static Future<String?> cargarBackupLocal(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Seleccione el archivo JSON de sus fórmulas',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final File file = File(result.files.single.path!);
        final String contents = await file.readAsString();
        return contents;
      } else {
        // User canceled the picker
        return null;
      }
    } catch (e) {
       if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Error al leer el backup: $e'), backgroundColor: Colors.red),
        );
      }
      return null;
    }
  }
}
