// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetCachedDataCollection on Isar {
  IsarCollection<CachedData> get cachedDatas => this.collection();
}

const CachedDataSchema = CollectionSchema(
  name: r'CachedData',
  id: -3844448151837634569,
  properties: {
    r'bytes': PropertySchema(
      id: 0,
      name: r'bytes',
      type: IsarType.byteList,
    ),
    r'cacheCreated': PropertySchema(
      id: 1,
      name: r'cacheCreated',
      type: IsarType.dateTime,
    ),
    r'cacheExpires': PropertySchema(
      id: 2,
      name: r'cacheExpires',
      type: IsarType.dateTime,
    ),
    r'storageRefFullPath': PropertySchema(
      id: 3,
      name: r'storageRefFullPath',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedDataEstimateSize,
  serialize: _cachedDataSerialize,
  deserialize: _cachedDataDeserialize,
  deserializeProp: _cachedDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _cachedDataGetId,
  getLinks: _cachedDataGetLinks,
  attach: _cachedDataAttach,
  version: '3.0.5',
);

int _cachedDataEstimateSize(
  CachedData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bytes.length;
  bytesCount += 3 + object.storageRefFullPath.length * 3;
  return bytesCount;
}

void _cachedDataSerialize(
  CachedData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(offsets[0], object.bytes);
  writer.writeDateTime(offsets[1], object.cacheCreated);
  writer.writeDateTime(offsets[2], object.cacheExpires);
  writer.writeString(offsets[3], object.storageRefFullPath);
}

CachedData _cachedDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedData(
    reader.readString(offsets[3]),
    reader.readByteList(offsets[0]) ?? [],
    reader.readDateTime(offsets[1]),
    reader.readDateTime(offsets[2]),
  );
  return object;
}

P _cachedDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readByteList(offset) ?? []) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedDataGetId(CachedData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedDataGetLinks(CachedData object) {
  return [];
}

void _cachedDataAttach(IsarCollection<dynamic> col, Id id, CachedData object) {}

extension CachedDataQueryWhereSort
    on QueryBuilder<CachedData, CachedData, QWhere> {
  QueryBuilder<CachedData, CachedData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedDataQueryWhere
    on QueryBuilder<CachedData, CachedData, QWhereClause> {
  QueryBuilder<CachedData, CachedData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<CachedData, CachedData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterWhereClause> idBetween(
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
}

extension CachedDataQueryFilter
    on QueryBuilder<CachedData, CachedData, QFilterCondition> {
  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      bytesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bytes',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      bytesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bytes',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      bytesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bytes',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      bytesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bytes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      bytesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bytes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition> bytesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bytes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      bytesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bytes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      bytesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bytes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      bytesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bytes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      bytesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bytes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      cacheCreatedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cacheCreated',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      cacheCreatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cacheCreated',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      cacheCreatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cacheCreated',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      cacheCreatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cacheCreated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      cacheExpiresEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cacheExpires',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      cacheExpiresGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cacheExpires',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      cacheExpiresLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cacheExpires',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      cacheExpiresBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cacheExpires',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storageRefFullPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'storageRefFullPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'storageRefFullPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'storageRefFullPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'storageRefFullPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'storageRefFullPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'storageRefFullPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'storageRefFullPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storageRefFullPath',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterFilterCondition>
      storageRefFullPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'storageRefFullPath',
        value: '',
      ));
    });
  }
}

extension CachedDataQueryObject
    on QueryBuilder<CachedData, CachedData, QFilterCondition> {}

extension CachedDataQueryLinks
    on QueryBuilder<CachedData, CachedData, QFilterCondition> {}

extension CachedDataQuerySortBy
    on QueryBuilder<CachedData, CachedData, QSortBy> {
  QueryBuilder<CachedData, CachedData, QAfterSortBy> sortByCacheCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheCreated', Sort.asc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy> sortByCacheCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheCreated', Sort.desc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy> sortByCacheExpires() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpires', Sort.asc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy> sortByCacheExpiresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpires', Sort.desc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy>
      sortByStorageRefFullPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageRefFullPath', Sort.asc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy>
      sortByStorageRefFullPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageRefFullPath', Sort.desc);
    });
  }
}

extension CachedDataQuerySortThenBy
    on QueryBuilder<CachedData, CachedData, QSortThenBy> {
  QueryBuilder<CachedData, CachedData, QAfterSortBy> thenByCacheCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheCreated', Sort.asc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy> thenByCacheCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheCreated', Sort.desc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy> thenByCacheExpires() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpires', Sort.asc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy> thenByCacheExpiresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpires', Sort.desc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy>
      thenByStorageRefFullPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageRefFullPath', Sort.asc);
    });
  }

  QueryBuilder<CachedData, CachedData, QAfterSortBy>
      thenByStorageRefFullPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageRefFullPath', Sort.desc);
    });
  }
}

extension CachedDataQueryWhereDistinct
    on QueryBuilder<CachedData, CachedData, QDistinct> {
  QueryBuilder<CachedData, CachedData, QDistinct> distinctByBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bytes');
    });
  }

  QueryBuilder<CachedData, CachedData, QDistinct> distinctByCacheCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cacheCreated');
    });
  }

  QueryBuilder<CachedData, CachedData, QDistinct> distinctByCacheExpires() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cacheExpires');
    });
  }

  QueryBuilder<CachedData, CachedData, QDistinct> distinctByStorageRefFullPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storageRefFullPath',
          caseSensitive: caseSensitive);
    });
  }
}

extension CachedDataQueryProperty
    on QueryBuilder<CachedData, CachedData, QQueryProperty> {
  QueryBuilder<CachedData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedData, List<int>, QQueryOperations> bytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bytes');
    });
  }

  QueryBuilder<CachedData, DateTime, QQueryOperations> cacheCreatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cacheCreated');
    });
  }

  QueryBuilder<CachedData, DateTime, QQueryOperations> cacheExpiresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cacheExpires');
    });
  }

  QueryBuilder<CachedData, String, QQueryOperations>
      storageRefFullPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storageRefFullPath');
    });
  }
}
