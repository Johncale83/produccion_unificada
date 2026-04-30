import 'package:isar/isar.dart';

part 'isar_catalogo_aditivo.g.dart';

@collection
class IsarCatalogoAditivo {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? nombre;

  String? origen;
  
  double? pesoBulto;
}
