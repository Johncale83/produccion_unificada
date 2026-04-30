// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_formula.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarFormulaCollection on Isar {
  IsarCollection<IsarFormula> get isarFormulas => this.collection();
}

const IsarFormulaSchema = CollectionSchema(
  name: r'IsarFormula',
  id: -8984892501972759564,
  properties: {
    r'aditivos': PropertySchema(
      id: 0,
      name: r'aditivos',
      type: IsarType.objectList,
      target: r'IsarAditivo',
    ),
    r'arenaBlancaSilo4Kg': PropertySchema(
      id: 1,
      name: r'arenaBlancaSilo4Kg',
      type: IsarType.double,
    ),
    r'arenaSilo1Kg': PropertySchema(
      id: 2,
      name: r'arenaSilo1Kg',
      type: IsarType.double,
    ),
    r'arenaSilo2Kg': PropertySchema(
      id: 3,
      name: r'arenaSilo2Kg',
      type: IsarType.double,
    ),
    r'arenaSilo5Kg': PropertySchema(
      id: 4,
      name: r'arenaSilo5Kg',
      type: IsarType.double,
    ),
    r'cementoKg': PropertySchema(
      id: 5,
      name: r'cementoKg',
      type: IsarType.double,
    ),
    r'cementoSilo7Kg': PropertySchema(
      id: 6,
      name: r'cementoSilo7Kg',
      type: IsarType.double,
    ),
    r'cementoSilo8Kg': PropertySchema(
      id: 7,
      name: r'cementoSilo8Kg',
      type: IsarType.double,
    ),
    r'esBlanca': PropertySchema(
      id: 8,
      name: r'esBlanca',
      type: IsarType.bool,
    ),
    r'materialesPrincipales': PropertySchema(
      id: 9,
      name: r'materialesPrincipales',
      type: IsarType.objectList,
      target: r'IsarMaterialPrincipal',
    ),
    r'pesoBaseKg': PropertySchema(
      id: 10,
      name: r'pesoBaseKg',
      type: IsarType.double,
    ),
    r'referencia': PropertySchema(
      id: 11,
      name: r'referencia',
      type: IsarType.string,
    )
  },
  estimateSize: _isarFormulaEstimateSize,
  serialize: _isarFormulaSerialize,
  deserialize: _isarFormulaDeserialize,
  deserializeProp: _isarFormulaDeserializeProp,
  idName: r'id',
  indexes: {
    r'referencia': IndexSchema(
      id: -2567224829153491442,
      name: r'referencia',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'referencia',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'IsarMaterialPrincipal': IsarMaterialPrincipalSchema,
    r'IsarAditivo': IsarAditivoSchema
  },
  getId: _isarFormulaGetId,
  getLinks: _isarFormulaGetLinks,
  attach: _isarFormulaAttach,
  version: '3.1.0+1',
);

int _isarFormulaEstimateSize(
  IsarFormula object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.aditivos;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[IsarAditivo]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              IsarAditivoSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.materialesPrincipales;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[IsarMaterialPrincipal]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += IsarMaterialPrincipalSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.referencia;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarFormulaSerialize(
  IsarFormula object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<IsarAditivo>(
    offsets[0],
    allOffsets,
    IsarAditivoSchema.serialize,
    object.aditivos,
  );
  writer.writeDouble(offsets[1], object.arenaBlancaSilo4Kg);
  writer.writeDouble(offsets[2], object.arenaSilo1Kg);
  writer.writeDouble(offsets[3], object.arenaSilo2Kg);
  writer.writeDouble(offsets[4], object.arenaSilo5Kg);
  writer.writeDouble(offsets[5], object.cementoKg);
  writer.writeDouble(offsets[6], object.cementoSilo7Kg);
  writer.writeDouble(offsets[7], object.cementoSilo8Kg);
  writer.writeBool(offsets[8], object.esBlanca);
  writer.writeObjectList<IsarMaterialPrincipal>(
    offsets[9],
    allOffsets,
    IsarMaterialPrincipalSchema.serialize,
    object.materialesPrincipales,
  );
  writer.writeDouble(offsets[10], object.pesoBaseKg);
  writer.writeString(offsets[11], object.referencia);
}

IsarFormula _isarFormulaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarFormula();
  object.aditivos = reader.readObjectList<IsarAditivo>(
    offsets[0],
    IsarAditivoSchema.deserialize,
    allOffsets,
    IsarAditivo(),
  );
  object.arenaBlancaSilo4Kg = reader.readDoubleOrNull(offsets[1]);
  object.arenaSilo1Kg = reader.readDoubleOrNull(offsets[2]);
  object.arenaSilo2Kg = reader.readDoubleOrNull(offsets[3]);
  object.arenaSilo5Kg = reader.readDoubleOrNull(offsets[4]);
  object.cementoKg = reader.readDoubleOrNull(offsets[5]);
  object.cementoSilo7Kg = reader.readDoubleOrNull(offsets[6]);
  object.cementoSilo8Kg = reader.readDoubleOrNull(offsets[7]);
  object.esBlanca = reader.readBoolOrNull(offsets[8]);
  object.id = id;
  object.materialesPrincipales = reader.readObjectList<IsarMaterialPrincipal>(
    offsets[9],
    IsarMaterialPrincipalSchema.deserialize,
    allOffsets,
    IsarMaterialPrincipal(),
  );
  object.pesoBaseKg = reader.readDoubleOrNull(offsets[10]);
  object.referencia = reader.readStringOrNull(offsets[11]);
  return object;
}

P _isarFormulaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<IsarAditivo>(
        offset,
        IsarAditivoSchema.deserialize,
        allOffsets,
        IsarAditivo(),
      )) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset)) as P;
    case 9:
      return (reader.readObjectList<IsarMaterialPrincipal>(
        offset,
        IsarMaterialPrincipalSchema.deserialize,
        allOffsets,
        IsarMaterialPrincipal(),
      )) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarFormulaGetId(IsarFormula object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarFormulaGetLinks(IsarFormula object) {
  return [];
}

void _isarFormulaAttach(
    IsarCollection<dynamic> col, Id id, IsarFormula object) {
  object.id = id;
}

extension IsarFormulaByIndex on IsarCollection<IsarFormula> {
  Future<IsarFormula?> getByReferencia(String? referencia) {
    return getByIndex(r'referencia', [referencia]);
  }

  IsarFormula? getByReferenciaSync(String? referencia) {
    return getByIndexSync(r'referencia', [referencia]);
  }

  Future<bool> deleteByReferencia(String? referencia) {
    return deleteByIndex(r'referencia', [referencia]);
  }

  bool deleteByReferenciaSync(String? referencia) {
    return deleteByIndexSync(r'referencia', [referencia]);
  }

  Future<List<IsarFormula?>> getAllByReferencia(
      List<String?> referenciaValues) {
    final values = referenciaValues.map((e) => [e]).toList();
    return getAllByIndex(r'referencia', values);
  }

  List<IsarFormula?> getAllByReferenciaSync(List<String?> referenciaValues) {
    final values = referenciaValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'referencia', values);
  }

  Future<int> deleteAllByReferencia(List<String?> referenciaValues) {
    final values = referenciaValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'referencia', values);
  }

  int deleteAllByReferenciaSync(List<String?> referenciaValues) {
    final values = referenciaValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'referencia', values);
  }

  Future<Id> putByReferencia(IsarFormula object) {
    return putByIndex(r'referencia', object);
  }

  Id putByReferenciaSync(IsarFormula object, {bool saveLinks = true}) {
    return putByIndexSync(r'referencia', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByReferencia(List<IsarFormula> objects) {
    return putAllByIndex(r'referencia', objects);
  }

  List<Id> putAllByReferenciaSync(List<IsarFormula> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'referencia', objects, saveLinks: saveLinks);
  }
}

extension IsarFormulaQueryWhereSort
    on QueryBuilder<IsarFormula, IsarFormula, QWhere> {
  QueryBuilder<IsarFormula, IsarFormula, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarFormulaQueryWhere
    on QueryBuilder<IsarFormula, IsarFormula, QWhereClause> {
  QueryBuilder<IsarFormula, IsarFormula, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<IsarFormula, IsarFormula, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterWhereClause> idBetween(
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

  QueryBuilder<IsarFormula, IsarFormula, QAfterWhereClause> referenciaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'referencia',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterWhereClause>
      referenciaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'referencia',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterWhereClause> referenciaEqualTo(
      String? referencia) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'referencia',
        value: [referencia],
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterWhereClause>
      referenciaNotEqualTo(String? referencia) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'referencia',
              lower: [],
              upper: [referencia],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'referencia',
              lower: [referencia],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'referencia',
              lower: [referencia],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'referencia',
              lower: [],
              upper: [referencia],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarFormulaQueryFilter
    on QueryBuilder<IsarFormula, IsarFormula, QFilterCondition> {
  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      aditivosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aditivos',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      aditivosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aditivos',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      aditivosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'aditivos',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      aditivosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'aditivos',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      aditivosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'aditivos',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      aditivosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'aditivos',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      aditivosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'aditivos',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      aditivosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'aditivos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaSilo4KgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'arenaBlancaSilo4Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaSilo4KgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'arenaBlancaSilo4Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaSilo4KgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arenaBlancaSilo4Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaSilo4KgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'arenaBlancaSilo4Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaSilo4KgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'arenaBlancaSilo4Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaSilo4KgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'arenaBlancaSilo4Kg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo1KgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'arenaSilo1Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo1KgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'arenaSilo1Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo1KgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arenaSilo1Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo1KgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'arenaSilo1Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo1KgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'arenaSilo1Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo1KgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'arenaSilo1Kg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo2KgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'arenaSilo2Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo2KgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'arenaSilo2Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo2KgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arenaSilo2Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo2KgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'arenaSilo2Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo2KgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'arenaSilo2Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo2KgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'arenaSilo2Kg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo5KgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'arenaSilo5Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo5KgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'arenaSilo5Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo5KgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arenaSilo5Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo5KgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'arenaSilo5Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo5KgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'arenaSilo5Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaSilo5KgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'arenaSilo5Kg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cementoKg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cementoKg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoKgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cementoKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cementoKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cementoKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cementoKg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo7KgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cementoSilo7Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo7KgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cementoSilo7Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo7KgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cementoSilo7Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo7KgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cementoSilo7Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo7KgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cementoSilo7Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo7KgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cementoSilo7Kg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo8KgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cementoSilo8Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo8KgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cementoSilo8Kg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo8KgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cementoSilo8Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo8KgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cementoSilo8Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo8KgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cementoSilo8Kg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      cementoSilo8KgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cementoSilo8Kg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      esBlancaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'esBlanca',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      esBlancaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'esBlanca',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition> esBlancaEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'esBlanca',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      materialesPrincipalesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'materialesPrincipales',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      materialesPrincipalesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'materialesPrincipales',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      materialesPrincipalesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'materialesPrincipales',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      materialesPrincipalesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'materialesPrincipales',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      materialesPrincipalesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'materialesPrincipales',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      materialesPrincipalesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'materialesPrincipales',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      materialesPrincipalesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'materialesPrincipales',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      materialesPrincipalesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'materialesPrincipales',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      pesoBaseKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pesoBaseKg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      pesoBaseKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pesoBaseKg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      pesoBaseKgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pesoBaseKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      pesoBaseKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pesoBaseKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      pesoBaseKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pesoBaseKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      pesoBaseKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pesoBaseKg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'referencia',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'referencia',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'referencia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'referencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'referencia',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referencia',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      referenciaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'referencia',
        value: '',
      ));
    });
  }
}

extension IsarFormulaQueryObject
    on QueryBuilder<IsarFormula, IsarFormula, QFilterCondition> {
  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition> aditivosElement(
      FilterQuery<IsarAditivo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'aditivos');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      materialesPrincipalesElement(FilterQuery<IsarMaterialPrincipal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'materialesPrincipales');
    });
  }
}

extension IsarFormulaQueryLinks
    on QueryBuilder<IsarFormula, IsarFormula, QFilterCondition> {}

extension IsarFormulaQuerySortBy
    on QueryBuilder<IsarFormula, IsarFormula, QSortBy> {
  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      sortByArenaBlancaSilo4Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaBlancaSilo4Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      sortByArenaBlancaSilo4KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaBlancaSilo4Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByArenaSilo1Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo1Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      sortByArenaSilo1KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo1Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByArenaSilo2Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo2Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      sortByArenaSilo2KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo2Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByArenaSilo5Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo5Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      sortByArenaSilo5KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo5Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByCementoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoKg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByCementoKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoKg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByCementoSilo7Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoSilo7Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      sortByCementoSilo7KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoSilo7Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByCementoSilo8Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoSilo8Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      sortByCementoSilo8KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoSilo8Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByEsBlanca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esBlanca', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByEsBlancaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esBlanca', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByPesoBaseKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoBaseKg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByPesoBaseKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoBaseKg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.desc);
    });
  }
}

extension IsarFormulaQuerySortThenBy
    on QueryBuilder<IsarFormula, IsarFormula, QSortThenBy> {
  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      thenByArenaBlancaSilo4Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaBlancaSilo4Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      thenByArenaBlancaSilo4KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaBlancaSilo4Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByArenaSilo1Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo1Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      thenByArenaSilo1KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo1Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByArenaSilo2Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo2Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      thenByArenaSilo2KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo2Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByArenaSilo5Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo5Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      thenByArenaSilo5KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaSilo5Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByCementoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoKg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByCementoKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoKg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByCementoSilo7Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoSilo7Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      thenByCementoSilo7KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoSilo7Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByCementoSilo8Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoSilo8Kg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      thenByCementoSilo8KgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cementoSilo8Kg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByEsBlanca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esBlanca', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByEsBlancaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esBlanca', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByPesoBaseKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoBaseKg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByPesoBaseKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pesoBaseKg', Sort.desc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referencia', Sort.desc);
    });
  }
}

extension IsarFormulaQueryWhereDistinct
    on QueryBuilder<IsarFormula, IsarFormula, QDistinct> {
  QueryBuilder<IsarFormula, IsarFormula, QDistinct>
      distinctByArenaBlancaSilo4Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'arenaBlancaSilo4Kg');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByArenaSilo1Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'arenaSilo1Kg');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByArenaSilo2Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'arenaSilo2Kg');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByArenaSilo5Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'arenaSilo5Kg');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByCementoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cementoKg');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByCementoSilo7Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cementoSilo7Kg');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByCementoSilo8Kg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cementoSilo8Kg');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByEsBlanca() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'esBlanca');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByPesoBaseKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pesoBaseKg');
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByReferencia(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'referencia', caseSensitive: caseSensitive);
    });
  }
}

extension IsarFormulaQueryProperty
    on QueryBuilder<IsarFormula, IsarFormula, QQueryProperty> {
  QueryBuilder<IsarFormula, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarFormula, List<IsarAditivo>?, QQueryOperations>
      aditivosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aditivos');
    });
  }

  QueryBuilder<IsarFormula, double?, QQueryOperations>
      arenaBlancaSilo4KgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'arenaBlancaSilo4Kg');
    });
  }

  QueryBuilder<IsarFormula, double?, QQueryOperations> arenaSilo1KgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'arenaSilo1Kg');
    });
  }

  QueryBuilder<IsarFormula, double?, QQueryOperations> arenaSilo2KgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'arenaSilo2Kg');
    });
  }

  QueryBuilder<IsarFormula, double?, QQueryOperations> arenaSilo5KgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'arenaSilo5Kg');
    });
  }

  QueryBuilder<IsarFormula, double?, QQueryOperations> cementoKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cementoKg');
    });
  }

  QueryBuilder<IsarFormula, double?, QQueryOperations>
      cementoSilo7KgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cementoSilo7Kg');
    });
  }

  QueryBuilder<IsarFormula, double?, QQueryOperations>
      cementoSilo8KgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cementoSilo8Kg');
    });
  }

  QueryBuilder<IsarFormula, bool?, QQueryOperations> esBlancaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'esBlanca');
    });
  }

  QueryBuilder<IsarFormula, List<IsarMaterialPrincipal>?, QQueryOperations>
      materialesPrincipalesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialesPrincipales');
    });
  }

  QueryBuilder<IsarFormula, double?, QQueryOperations> pesoBaseKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pesoBaseKg');
    });
  }

  QueryBuilder<IsarFormula, String?, QQueryOperations> referenciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'referencia');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarMaterialPrincipalSchema = Schema(
  name: r'IsarMaterialPrincipal',
  id: -7762529624386347107,
  properties: {
    r'cantidadKg': PropertySchema(
      id: 0,
      name: r'cantidadKg',
      type: IsarType.double,
    ),
    r'categoria': PropertySchema(
      id: 1,
      name: r'categoria',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(
      id: 2,
      name: r'nombre',
      type: IsarType.string,
    )
  },
  estimateSize: _isarMaterialPrincipalEstimateSize,
  serialize: _isarMaterialPrincipalSerialize,
  deserialize: _isarMaterialPrincipalDeserialize,
  deserializeProp: _isarMaterialPrincipalDeserializeProp,
);

int _isarMaterialPrincipalEstimateSize(
  IsarMaterialPrincipal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.categoria;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarMaterialPrincipalSerialize(
  IsarMaterialPrincipal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cantidadKg);
  writer.writeString(offsets[1], object.categoria);
  writer.writeString(offsets[2], object.nombre);
}

IsarMaterialPrincipal _isarMaterialPrincipalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMaterialPrincipal();
  object.cantidadKg = reader.readDoubleOrNull(offsets[0]);
  object.categoria = reader.readStringOrNull(offsets[1]);
  object.nombre = reader.readStringOrNull(offsets[2]);
  return object;
}

P _isarMaterialPrincipalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarMaterialPrincipalQueryFilter on QueryBuilder<
    IsarMaterialPrincipal, IsarMaterialPrincipal, QFilterCondition> {
  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> cantidadKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cantidadKg',
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> cantidadKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cantidadKg',
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> cantidadKgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> cantidadKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> cantidadKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> cantidadKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadKg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoria',
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoria',
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
          QAfterFilterCondition>
      categoriaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
          QAfterFilterCondition>
      categoriaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoria',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoria',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> categoriaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoria',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreEqualTo(
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

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreGreaterThan(
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

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreLessThan(
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

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreBetween(
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

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreStartsWith(
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

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreEndsWith(
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

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
          QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
          QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMaterialPrincipal, IsarMaterialPrincipal,
      QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }
}

extension IsarMaterialPrincipalQueryObject on QueryBuilder<
    IsarMaterialPrincipal, IsarMaterialPrincipal, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarAditivoSchema = Schema(
  name: r'IsarAditivo',
  id: -7302743107650038454,
  properties: {
    r'cantidadKg': PropertySchema(
      id: 0,
      name: r'cantidadKg',
      type: IsarType.double,
    ),
    r'nombre': PropertySchema(
      id: 1,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'origen': PropertySchema(
      id: 2,
      name: r'origen',
      type: IsarType.string,
    )
  },
  estimateSize: _isarAditivoEstimateSize,
  serialize: _isarAditivoSerialize,
  deserialize: _isarAditivoDeserialize,
  deserializeProp: _isarAditivoDeserializeProp,
);

int _isarAditivoEstimateSize(
  IsarAditivo object,
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

void _isarAditivoSerialize(
  IsarAditivo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cantidadKg);
  writer.writeString(offsets[1], object.nombre);
  writer.writeString(offsets[2], object.origen);
}

IsarAditivo _isarAditivoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarAditivo();
  object.cantidadKg = reader.readDoubleOrNull(offsets[0]);
  object.nombre = reader.readStringOrNull(offsets[1]);
  object.origen = reader.readStringOrNull(offsets[2]);
  return object;
}

P _isarAditivoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarAditivoQueryFilter
    on QueryBuilder<IsarAditivo, IsarAditivo, QFilterCondition> {
  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      cantidadKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cantidadKg',
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      cantidadKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cantidadKg',
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      cantidadKgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      cantidadKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      cantidadKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      cantidadKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadKg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> nombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      nombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nombre',
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> nombreEqualTo(
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> nombreLessThan(
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> nombreBetween(
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> nombreEndsWith(
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> nombreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> nombreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> origenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'origen',
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      origenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'origen',
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> origenEqualTo(
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> origenLessThan(
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> origenBetween(
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> origenEndsWith(
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

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> origenContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'origen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition> origenMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'origen',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      origenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'origen',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAditivo, IsarAditivo, QAfterFilterCondition>
      origenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'origen',
        value: '',
      ));
    });
  }
}

extension IsarAditivoQueryObject
    on QueryBuilder<IsarAditivo, IsarAditivo, QFilterCondition> {}
