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
    r'arenaBlancaKg': PropertySchema(
      id: 1,
      name: r'arenaBlancaKg',
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
    r'cementoKg': PropertySchema(
      id: 4,
      name: r'cementoKg',
      type: IsarType.double,
    ),
    r'esBlanca': PropertySchema(
      id: 5,
      name: r'esBlanca',
      type: IsarType.bool,
    ),
    r'pesoBaseKg': PropertySchema(
      id: 6,
      name: r'pesoBaseKg',
      type: IsarType.double,
    ),
    r'referencia': PropertySchema(
      id: 7,
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
  embeddedSchemas: {r'IsarAditivo': IsarAditivoSchema},
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
  writer.writeDouble(offsets[1], object.arenaBlancaKg);
  writer.writeDouble(offsets[2], object.arenaSilo1Kg);
  writer.writeDouble(offsets[3], object.arenaSilo2Kg);
  writer.writeDouble(offsets[4], object.cementoKg);
  writer.writeBool(offsets[5], object.esBlanca);
  writer.writeDouble(offsets[6], object.pesoBaseKg);
  writer.writeString(offsets[7], object.referencia);
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
  object.arenaBlancaKg = reader.readDoubleOrNull(offsets[1]);
  object.arenaSilo1Kg = reader.readDoubleOrNull(offsets[2]);
  object.arenaSilo2Kg = reader.readDoubleOrNull(offsets[3]);
  object.cementoKg = reader.readDoubleOrNull(offsets[4]);
  object.esBlanca = reader.readBoolOrNull(offsets[5]);
  object.id = id;
  object.pesoBaseKg = reader.readDoubleOrNull(offsets[6]);
  object.referencia = reader.readStringOrNull(offsets[7]);
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
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
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
      arenaBlancaKgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'arenaBlancaKg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaKgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'arenaBlancaKg',
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaKgEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'arenaBlancaKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaKgGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'arenaBlancaKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaKgLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'arenaBlancaKg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterFilterCondition>
      arenaBlancaKgBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'arenaBlancaKg',
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
}

extension IsarFormulaQueryLinks
    on QueryBuilder<IsarFormula, IsarFormula, QFilterCondition> {}

extension IsarFormulaQuerySortBy
    on QueryBuilder<IsarFormula, IsarFormula, QSortBy> {
  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> sortByArenaBlancaKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaBlancaKg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      sortByArenaBlancaKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaBlancaKg', Sort.desc);
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
  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy> thenByArenaBlancaKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaBlancaKg', Sort.asc);
    });
  }

  QueryBuilder<IsarFormula, IsarFormula, QAfterSortBy>
      thenByArenaBlancaKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'arenaBlancaKg', Sort.desc);
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
  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByArenaBlancaKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'arenaBlancaKg');
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

  QueryBuilder<IsarFormula, IsarFormula, QDistinct> distinctByCementoKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cementoKg');
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

  QueryBuilder<IsarFormula, double?, QQueryOperations> arenaBlancaKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'arenaBlancaKg');
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

  QueryBuilder<IsarFormula, double?, QQueryOperations> cementoKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cementoKg');
    });
  }

  QueryBuilder<IsarFormula, bool?, QQueryOperations> esBlancaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'esBlanca');
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
  return bytesCount;
}

void _isarCatalogoAditivoSerialize(
  IsarCatalogoAditivo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.nombre);
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
}

extension IsarCatalogoAditivoQueryWhereDistinct
    on QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QDistinct> {
  QueryBuilder<IsarCatalogoAditivo, IsarCatalogoAditivo, QDistinct>
      distinctByNombre({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
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
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

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
