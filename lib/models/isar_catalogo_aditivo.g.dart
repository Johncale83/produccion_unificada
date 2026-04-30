// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_catalogo_aditivo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarCatalogoAditivoCollection on Isar {
  IsarCollection<IsarCatalogoAditivo> get isarCatalogoAditivos =>
      this.collection();
}

const IsarCatalogoAditivoSchema = CollectionSchema(
  name: r'IsarCatalogoAditivo',
  id: -4054540877865697339,
  properties: {
    r'nombre': PropertySchema(
      id: 0,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'origen': PropertySchema(
      id: 1,
      name: r'origen',
      type: IsarType.string,
    ),
    r'pesoBulto': PropertySchema(
      id: 2,
      name: r'pesoBulto',
      type: IsarType.double,
    )
  },
  estimateSize: _isarCatalogoAditivoEstimateSize,
  serialize: _isarCatalogoAditivoSerialize,
  deserialize: _isarCatalogoAditivoDeserialize,
  deserializeProp: _isarCatalogoAditivoDeserializeProp,
  idName: r'id',
  indexes: {
    r'nombre': IndexSchema(
      id: -8239814765453414572,
      name: r'nombre',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'nombre',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarCatalogoAditivoGetId,
  getLinks: _isarCatalogoAditivoGetLinks,
  attach: _isarCatalogoAditivoAttach,
  version: '3.1.0+1',
);

int _isarCatalogoAditivoEstimateSize(
  IsarCatalogoAditivo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.nombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.origen;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarCatalogoAditivoSerialize(
  IsarCatalogoAditivo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.nombre);
  writer.writeString(offsets[1], object.origen);
  writer.writeDouble(offsets[2], object.pesoBulto);
}

IsarCatalogoAditivo _isarCatalogoAditivoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarCatalogoAditivo();
  object.id = id;
  object.nombre = reader.readStringOrNull(offsets[0]);
  object.origen = reader.readStringOrNull(offsets[1]);
  object.pesoBulto = reader.readDoubleOrNull(offsets[2]);
  return object;
}

P _isarCatalogoAditivoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarCatalogoAditivoGetId(IsarCatalogoAditivo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarCatalogoAditivoGetLinks(
    IsarCatalogoAditivo object) {
  return [];
}

void _isarCatalogoAditivoAttach(
    IsarCollection<dynamic> col, Id id, IsarCatalogoAditivo object) {
  object.id = id;
}

extension IsarCatalogoAditivoByIndex on IsarCollection<IsarCatalogoAditivo> {
  Future<IsarCatalogoAditivo?> getByNombre(String? nombre) {
    return getByIndex(r'nombre', [nombre]);
  }

  IsarCatalogoAditivo? getByNombreSync(String? nombre) {
    return getByIndexSync(r'nombre', [nombre]);
  }

  Future<bool> deleteByNombre(String? nombre) {
    return deleteByIndex(r'nombre', [nombre]);
  }

  bool deleteByNombreSync(String? nombre) {
    return deleteByIndexSync(r'nombre', [nombre]);
  }

  Future<List<IsarCatalogoAditivo?>> getAllByNombre(
      List<String?> nombreValues) {
    final values = nombreValues.map((e) => [e]).toList();
    return getAllByIndex(r'nombre', values);
  }

  List<IsarCatalogoAditivo?> getAllByNombreSync(List<String?> nombreValues) {
    final values = nombreValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'nombre', values);
  }

  Future<int> deleteAllByNombre(List<String?> nombreValues) {
    final values = nombreValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'nombre', values);
  }

  int deleteAllByNombreSync(List<String?> nombreValues) {
    final values = nombreValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'nombre', values);
  }

  Future<Id> putByNombre(IsarCatalogoAditivo object) {
    return putByIndex(r'nombre', object);
  }

  Id putByNombreSync(IsarCatalogoAditivo object, {bool saveLinks = true}) {
    return putByIndexSync(r'nombre', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNombre(List<IsarCatalogoAditivo> objects) {
    return putAllByIndex(r'nombre', objects);
  }

  List<Id> putAllByNombreSync(List<IsarCatalogoAditivo> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'nombre', objects, saveLinks: saveLinks);
  }
}

extension IsarCatalogoAditivoQueryWhereSort
    on QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QWhere> {
  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarCatalogoAditivoQueryWhere
    on QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QWhereClause> {
  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhereClause>
      nombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nombre',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhereClause>
      nombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nombre',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhereClause>
      nombreEqualTo(String? nombre) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nombre',
        value: [nombre],
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterWhereClause>
      nombreNotEqualTo(String? nombre) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nombre',
              lower: [],
              upper: [nombre],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nombre',
              lower: [nombre],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nombre',
              lower: [nombre],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nombre',
              lower: [],
              upper: [nombre],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarCatalogoAditivoQueryFilter on QueryBuilder<IsarCatalogoAditivo,
    IsarCatalogoAditivo, QFilterCondition> {
  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'origen',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'origen',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'origen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'origen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'origen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'origen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'origen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'origen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'origen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'origen',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'origen',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      origenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'origen',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      pesoBultoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pesoBulto',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      pesoBultoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pesoBulto',
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      pesoBultoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pesoBulto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      pesoBultoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pesoBulto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      pesoBultoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pesoBulto',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterFilterCondition>
      pesoBultoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pesoBulto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension IsarCatalogoAditivoQueryObject on QueryBuilder<IsarCatalogoAditivo,
    IsarCatalogoAditivo, QFilterCondition> {}

extension IsarCatalogoAditivoQueryLinks on QueryBuilder<IsarCatalogoAditivo,
    IsarCatalogoAditivo, QFilterCondition> {}

extension IsarCatalogoAditivoQuerySortBy
    on QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QSortBy> {
  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      sortByOrigen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origen', Sort.asc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      sortByOrigenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origen', Sort.desc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      sortByPesoBulto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoBulto', Sort.asc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      sortByPesoBultoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoBulto', Sort.desc);
    });
  }
}

extension IsarCatalogoAditivoQuerySortThenBy
    on QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QSortThenBy> {
  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      thenByOrigen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origen', Sort.asc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      thenByOrigenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origen', Sort.desc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      thenByPesoBulto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoBulto', Sort.asc);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QAfterSortBy>
      thenByPesoBultoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoBulto', Sort.desc);
    });
  }
}

extension IsarCatalogoAditivoQueryWhereDistinct
    on QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QDistinct> {
  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QDistinct>
      distinctByNombre({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QDistinct>
      distinctByOrigen({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'origen', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QDistinct>
      distinctByPesoBulto() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pesoBulto');
    });
  }
}

extension IsarCatalogoAditivoQueryProperty
    on QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QQueryProperty> {
  QueryBuilder<IsarCatalogoAditivo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarCatalogoAditivo, String?, QQueryOperations>
      nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<IsarCatalogoAditivo, String?, QQueryOperations>
      origenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'origen');
    });
  }

  QueryBuilder<IsarCatalogoAditivo, double?, QQueryOperations>
      pesoBultoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pesoBulto');
    });
  }
}
