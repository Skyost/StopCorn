// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _weeklyLimitMeta = const VerificationMeta(
    'weeklyLimit',
  );
  @override
  late final GeneratedColumn<int> weeklyLimit = GeneratedColumn<int>(
    'weekly_limit',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contextKeysJsonMeta = const VerificationMeta(
    'contextKeysJson',
  );
  @override
  late final GeneratedColumn<String> contextKeysJson = GeneratedColumn<String>(
    'context_keys_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _motivationMeta = const VerificationMeta(
    'motivation',
  );
  @override
  late final GeneratedColumn<String> motivation = GeneratedColumn<String>(
    'motivation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    type,
    isActive,
    weeklyLimit,
    contextKeysJson,
    motivation,
    startedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Goal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('weekly_limit')) {
      context.handle(
        _weeklyLimitMeta,
        weeklyLimit.isAcceptableOrUnknown(
          data['weekly_limit']!,
          _weeklyLimitMeta,
        ),
      );
    }
    if (data.containsKey('context_keys_json')) {
      context.handle(
        _contextKeysJsonMeta,
        contextKeysJson.isAcceptableOrUnknown(
          data['context_keys_json']!,
          _contextKeysJsonMeta,
        ),
      );
    }
    if (data.containsKey('motivation')) {
      context.handle(
        _motivationMeta,
        motivation.isAcceptableOrUnknown(data['motivation']!, _motivationMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      weeklyLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_limit'],
      ),
      contextKeysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_keys_json'],
      ),
      motivation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivation'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  /// Stable UUID of the goal.
  final String id;

  /// UTC creation timestamp.
  final DateTime createdAt;

  /// UTC timestamp of the latest update.
  final DateTime updatedAt;

  /// Persisted [GoalType] name.
  final String type;

  /// Whether this is the single active goal.
  final bool isActive;

  /// Optional maximum events desired per week.
  final int? weeklyLimit;

  /// JSON array of contexts covered by a contextual goal.
  final String? contextKeysJson;

  /// Optional user-written reason for pursuing the goal.
  final String? motivation;

  /// UTC timestamp at which the goal began.
  final DateTime startedAt;

  /// UTC timestamp at which the goal stopped being active.
  final DateTime? endedAt;
  const Goal({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.isActive,
    this.weeklyLimit,
    this.contextKeysJson,
    this.motivation,
    required this.startedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['type'] = Variable<String>(type);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || weeklyLimit != null) {
      map['weekly_limit'] = Variable<int>(weeklyLimit);
    }
    if (!nullToAbsent || contextKeysJson != null) {
      map['context_keys_json'] = Variable<String>(contextKeysJson);
    }
    if (!nullToAbsent || motivation != null) {
      map['motivation'] = Variable<String>(motivation);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      type: Value(type),
      isActive: Value(isActive),
      weeklyLimit: weeklyLimit == null && nullToAbsent ? const Value.absent() : Value(weeklyLimit),
      contextKeysJson: contextKeysJson == null && nullToAbsent ? const Value.absent() : Value(contextKeysJson),
      motivation: motivation == null && nullToAbsent ? const Value.absent() : Value(motivation),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent ? const Value.absent() : Value(endedAt),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      type: serializer.fromJson<String>(json['type']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      weeklyLimit: serializer.fromJson<int?>(json['weeklyLimit']),
      contextKeysJson: serializer.fromJson<String?>(json['contextKeysJson']),
      motivation: serializer.fromJson<String?>(json['motivation']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'type': serializer.toJson<String>(type),
      'isActive': serializer.toJson<bool>(isActive),
      'weeklyLimit': serializer.toJson<int?>(weeklyLimit),
      'contextKeysJson': serializer.toJson<String?>(contextKeysJson),
      'motivation': serializer.toJson<String?>(motivation),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
    };
  }

  Goal copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? type,
    bool? isActive,
    Value<int?> weeklyLimit = const Value.absent(),
    Value<String?> contextKeysJson = const Value.absent(),
    Value<String?> motivation = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
  }) => Goal(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    type: type ?? this.type,
    isActive: isActive ?? this.isActive,
    weeklyLimit: weeklyLimit.present ? weeklyLimit.value : this.weeklyLimit,
    contextKeysJson: contextKeysJson.present ? contextKeysJson.value : this.contextKeysJson,
    motivation: motivation.present ? motivation.value : this.motivation,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      type: data.type.present ? data.type.value : this.type,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      weeklyLimit: data.weeklyLimit.present ? data.weeklyLimit.value : this.weeklyLimit,
      contextKeysJson: data.contextKeysJson.present ? data.contextKeysJson.value : this.contextKeysJson,
      motivation: data.motivation.present ? data.motivation.value : this.motivation,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('type: $type, ')
          ..write('isActive: $isActive, ')
          ..write('weeklyLimit: $weeklyLimit, ')
          ..write('contextKeysJson: $contextKeysJson, ')
          ..write('motivation: $motivation, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    type,
    isActive,
    weeklyLimit,
    contextKeysJson,
    motivation,
    startedAt,
    endedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.type == this.type &&
          other.isActive == this.isActive &&
          other.weeklyLimit == this.weeklyLimit &&
          other.contextKeysJson == this.contextKeysJson &&
          other.motivation == this.motivation &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> type;
  final Value<bool> isActive;
  final Value<int?> weeklyLimit;
  final Value<String?> contextKeysJson;
  final Value<String?> motivation;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.isActive = const Value.absent(),
    this.weeklyLimit = const Value.absent(),
    this.contextKeysJson = const Value.absent(),
    this.motivation = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String type,
    this.isActive = const Value.absent(),
    this.weeklyLimit = const Value.absent(),
    this.contextKeysJson = const Value.absent(),
    this.motivation = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       type = Value(type),
       startedAt = Value(startedAt);
  static Insertable<Goal> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? type,
    Expression<bool>? isActive,
    Expression<int>? weeklyLimit,
    Expression<String>? contextKeysJson,
    Expression<String>? motivation,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (type != null) 'type': type,
      if (isActive != null) 'is_active': isActive,
      if (weeklyLimit != null) 'weekly_limit': weeklyLimit,
      if (contextKeysJson != null) 'context_keys_json': contextKeysJson,
      if (motivation != null) 'motivation': motivation,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? type,
    Value<bool>? isActive,
    Value<int?>? weeklyLimit,
    Value<String?>? contextKeysJson,
    Value<String?>? motivation,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      weeklyLimit: weeklyLimit ?? this.weeklyLimit,
      contextKeysJson: contextKeysJson ?? this.contextKeysJson,
      motivation: motivation ?? this.motivation,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (weeklyLimit.present) {
      map['weekly_limit'] = Variable<int>(weeklyLimit.value);
    }
    if (contextKeysJson.present) {
      map['context_keys_json'] = Variable<String>(contextKeysJson.value);
    }
    if (motivation.present) {
      map['motivation'] = Variable<String>(motivation.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('type: $type, ')
          ..write('isActive: $isActive, ')
          ..write('weeklyLimit: $weeklyLimit, ')
          ..write('contextKeysJson: $contextKeysJson, ')
          ..write('motivation: $motivation, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CopingStrategiesTable extends CopingStrategies with TableInfo<$CopingStrategiesTable, CopingStrategy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CopingStrategiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleKeyMeta = const VerificationMeta(
    'titleKey',
  );
  @override
  late final GeneratedColumn<String> titleKey = GeneratedColumn<String>(
    'title_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionKeyMeta = const VerificationMeta(
    'descriptionKey',
  );
  @override
  late final GeneratedColumn<String> descriptionKey = GeneratedColumn<String>(
    'description_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titleKey,
    descriptionKey,
    kind,
    isBuiltIn,
    isEnabled,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coping_strategies';
  @override
  VerificationContext validateIntegrity(
    Insertable<CopingStrategy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title_key')) {
      context.handle(
        _titleKeyMeta,
        titleKey.isAcceptableOrUnknown(data['title_key']!, _titleKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_titleKeyMeta);
    }
    if (data.containsKey('description_key')) {
      context.handle(
        _descriptionKeyMeta,
        descriptionKey.isAcceptableOrUnknown(
          data['description_key']!,
          _descriptionKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionKeyMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    } else if (isInserting) {
      context.missing(_isBuiltInMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CopingStrategy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CopingStrategy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      titleKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_key'],
      )!,
      descriptionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_key'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CopingStrategiesTable createAlias(String alias) {
    return $CopingStrategiesTable(attachedDatabase, alias);
  }
}

class CopingStrategy extends DataClass implements Insertable<CopingStrategy> {
  /// Stable strategy identifier.
  final String id;

  /// Slang translation key for the strategy title.
  final String titleKey;

  /// Slang translation key for the strategy description.
  final String descriptionKey;

  /// General strategy category used for presentation and ordering.
  final String kind;

  /// Whether the strategy ships with StopCorn.
  final bool isBuiltIn;

  /// Whether the strategy may currently be suggested.
  final bool isEnabled;

  /// UTC timestamp at which the strategy record was created.
  final DateTime createdAt;
  const CopingStrategy({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.kind,
    required this.isBuiltIn,
    required this.isEnabled,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title_key'] = Variable<String>(titleKey);
    map['description_key'] = Variable<String>(descriptionKey);
    map['kind'] = Variable<String>(kind);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CopingStrategiesCompanion toCompanion(bool nullToAbsent) {
    return CopingStrategiesCompanion(
      id: Value(id),
      titleKey: Value(titleKey),
      descriptionKey: Value(descriptionKey),
      kind: Value(kind),
      isBuiltIn: Value(isBuiltIn),
      isEnabled: Value(isEnabled),
      createdAt: Value(createdAt),
    );
  }

  factory CopingStrategy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CopingStrategy(
      id: serializer.fromJson<String>(json['id']),
      titleKey: serializer.fromJson<String>(json['titleKey']),
      descriptionKey: serializer.fromJson<String>(json['descriptionKey']),
      kind: serializer.fromJson<String>(json['kind']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titleKey': serializer.toJson<String>(titleKey),
      'descriptionKey': serializer.toJson<String>(descriptionKey),
      'kind': serializer.toJson<String>(kind),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CopingStrategy copyWith({
    String? id,
    String? titleKey,
    String? descriptionKey,
    String? kind,
    bool? isBuiltIn,
    bool? isEnabled,
    DateTime? createdAt,
  }) => CopingStrategy(
    id: id ?? this.id,
    titleKey: titleKey ?? this.titleKey,
    descriptionKey: descriptionKey ?? this.descriptionKey,
    kind: kind ?? this.kind,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    isEnabled: isEnabled ?? this.isEnabled,
    createdAt: createdAt ?? this.createdAt,
  );
  CopingStrategy copyWithCompanion(CopingStrategiesCompanion data) {
    return CopingStrategy(
      id: data.id.present ? data.id.value : this.id,
      titleKey: data.titleKey.present ? data.titleKey.value : this.titleKey,
      descriptionKey: data.descriptionKey.present ? data.descriptionKey.value : this.descriptionKey,
      kind: data.kind.present ? data.kind.value : this.kind,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CopingStrategy(')
          ..write('id: $id, ')
          ..write('titleKey: $titleKey, ')
          ..write('descriptionKey: $descriptionKey, ')
          ..write('kind: $kind, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    titleKey,
    descriptionKey,
    kind,
    isBuiltIn,
    isEnabled,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CopingStrategy &&
          other.id == this.id &&
          other.titleKey == this.titleKey &&
          other.descriptionKey == this.descriptionKey &&
          other.kind == this.kind &&
          other.isBuiltIn == this.isBuiltIn &&
          other.isEnabled == this.isEnabled &&
          other.createdAt == this.createdAt);
}

class CopingStrategiesCompanion extends UpdateCompanion<CopingStrategy> {
  final Value<String> id;
  final Value<String> titleKey;
  final Value<String> descriptionKey;
  final Value<String> kind;
  final Value<bool> isBuiltIn;
  final Value<bool> isEnabled;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CopingStrategiesCompanion({
    this.id = const Value.absent(),
    this.titleKey = const Value.absent(),
    this.descriptionKey = const Value.absent(),
    this.kind = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CopingStrategiesCompanion.insert({
    required String id,
    required String titleKey,
    required String descriptionKey,
    required String kind,
    required bool isBuiltIn,
    this.isEnabled = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       titleKey = Value(titleKey),
       descriptionKey = Value(descriptionKey),
       kind = Value(kind),
       isBuiltIn = Value(isBuiltIn),
       createdAt = Value(createdAt);
  static Insertable<CopingStrategy> custom({
    Expression<String>? id,
    Expression<String>? titleKey,
    Expression<String>? descriptionKey,
    Expression<String>? kind,
    Expression<bool>? isBuiltIn,
    Expression<bool>? isEnabled,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titleKey != null) 'title_key': titleKey,
      if (descriptionKey != null) 'description_key': descriptionKey,
      if (kind != null) 'kind': kind,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CopingStrategiesCompanion copyWith({
    Value<String>? id,
    Value<String>? titleKey,
    Value<String>? descriptionKey,
    Value<String>? kind,
    Value<bool>? isBuiltIn,
    Value<bool>? isEnabled,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CopingStrategiesCompanion(
      id: id ?? this.id,
      titleKey: titleKey ?? this.titleKey,
      descriptionKey: descriptionKey ?? this.descriptionKey,
      kind: kind ?? this.kind,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titleKey.present) {
      map['title_key'] = Variable<String>(titleKey.value);
    }
    if (descriptionKey.present) {
      map['description_key'] = Variable<String>(descriptionKey.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CopingStrategiesCompanion(')
          ..write('id: $id, ')
          ..write('titleKey: $titleKey, ')
          ..write('descriptionKey: $descriptionKey, ')
          ..write('kind: $kind, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UrgeSessionsTable extends UrgeSessions with TableInfo<$UrgeSessionsTable, UrgeSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UrgeSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _initialIntensityMeta = const VerificationMeta(
    'initialIntensity',
  );
  @override
  late final GeneratedColumn<int> initialIntensity = GeneratedColumn<int>(
    'initial_intensity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finalIntensityMeta = const VerificationMeta(
    'finalIntensity',
  );
  @override
  late final GeneratedColumn<int> finalIntensity = GeneratedColumn<int>(
    'final_intensity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _triggerTypeMeta = const VerificationMeta(
    'triggerType',
  );
  @override
  late final GeneratedColumn<String> triggerType = GeneratedColumn<String>(
    'trigger_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emotionTypeMeta = const VerificationMeta(
    'emotionType',
  );
  @override
  late final GeneratedColumn<String> emotionType = GeneratedColumn<String>(
    'emotion_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _copingStrategyIdMeta = const VerificationMeta(
    'copingStrategyId',
  );
  @override
  late final GeneratedColumn<String> copingStrategyId = GeneratedColumn<String>(
    'coping_strategy_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coping_strategies (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pauseDurationSecondsMeta = const VerificationMeta('pauseDurationSeconds');
  @override
  late final GeneratedColumn<int> pauseDurationSeconds = GeneratedColumn<int>(
    'pause_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    completedAt,
    initialIntensity,
    finalIntensity,
    triggerType,
    emotionType,
    copingStrategyId,
    outcome,
    notes,
    pauseDurationSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'urge_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<UrgeSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('initial_intensity')) {
      context.handle(
        _initialIntensityMeta,
        initialIntensity.isAcceptableOrUnknown(
          data['initial_intensity']!,
          _initialIntensityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initialIntensityMeta);
    }
    if (data.containsKey('final_intensity')) {
      context.handle(
        _finalIntensityMeta,
        finalIntensity.isAcceptableOrUnknown(
          data['final_intensity']!,
          _finalIntensityMeta,
        ),
      );
    }
    if (data.containsKey('trigger_type')) {
      context.handle(
        _triggerTypeMeta,
        triggerType.isAcceptableOrUnknown(
          data['trigger_type']!,
          _triggerTypeMeta,
        ),
      );
    }
    if (data.containsKey('emotion_type')) {
      context.handle(
        _emotionTypeMeta,
        emotionType.isAcceptableOrUnknown(
          data['emotion_type']!,
          _emotionTypeMeta,
        ),
      );
    }
    if (data.containsKey('coping_strategy_id')) {
      context.handle(
        _copingStrategyIdMeta,
        copingStrategyId.isAcceptableOrUnknown(
          data['coping_strategy_id']!,
          _copingStrategyIdMeta,
        ),
      );
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('pause_duration_seconds')) {
      context.handle(
        _pauseDurationSecondsMeta,
        pauseDurationSeconds.isAcceptableOrUnknown(
          data['pause_duration_seconds']!,
          _pauseDurationSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UrgeSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UrgeSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      initialIntensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_intensity'],
      )!,
      finalIntensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}final_intensity'],
      ),
      triggerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger_type'],
      ),
      emotionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emotion_type'],
      ),
      copingStrategyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coping_strategy_id'],
      ),
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      pauseDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pause_duration_seconds'],
      ),
    );
  }

  @override
  $UrgeSessionsTable createAlias(String alias) {
    return $UrgeSessionsTable(attachedDatabase, alias);
  }
}

class UrgeSession extends DataClass implements Insertable<UrgeSession> {
  /// Stable UUID of the session.
  final String id;

  /// UTC timestamp at which support began.
  final DateTime startedAt;

  /// UTC completion timestamp, or `null` for an abandoned session.
  final DateTime? completedAt;

  /// Initial urge intensity on the zero-to-ten scale.
  final int initialIntensity;

  /// Optional intensity recorded at the end of the session.
  final int? finalIntensity;

  /// Optional persisted [TriggerType] name.
  final String? triggerType;

  /// Optional persisted [EmotionType] name.
  final String? emotionType;

  /// Optional strategy selected during the session.
  final String? copingStrategyId;

  /// Optional persisted [UrgeOutcome] name.
  final String? outcome;

  /// Optional free-form reflection entered by the user.
  final String? notes;

  /// Duration of the guided pause when it was completed.
  final int? pauseDurationSeconds;
  const UrgeSession({
    required this.id,
    required this.startedAt,
    this.completedAt,
    required this.initialIntensity,
    this.finalIntensity,
    this.triggerType,
    this.emotionType,
    this.copingStrategyId,
    this.outcome,
    this.notes,
    this.pauseDurationSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['initial_intensity'] = Variable<int>(initialIntensity);
    if (!nullToAbsent || finalIntensity != null) {
      map['final_intensity'] = Variable<int>(finalIntensity);
    }
    if (!nullToAbsent || triggerType != null) {
      map['trigger_type'] = Variable<String>(triggerType);
    }
    if (!nullToAbsent || emotionType != null) {
      map['emotion_type'] = Variable<String>(emotionType);
    }
    if (!nullToAbsent || copingStrategyId != null) {
      map['coping_strategy_id'] = Variable<String>(copingStrategyId);
    }
    if (!nullToAbsent || outcome != null) {
      map['outcome'] = Variable<String>(outcome);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || pauseDurationSeconds != null) {
      map['pause_duration_seconds'] = Variable<int>(pauseDurationSeconds);
    }
    return map;
  }

  UrgeSessionsCompanion toCompanion(bool nullToAbsent) {
    return UrgeSessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent ? const Value.absent() : Value(completedAt),
      initialIntensity: Value(initialIntensity),
      finalIntensity: finalIntensity == null && nullToAbsent ? const Value.absent() : Value(finalIntensity),
      triggerType: triggerType == null && nullToAbsent ? const Value.absent() : Value(triggerType),
      emotionType: emotionType == null && nullToAbsent ? const Value.absent() : Value(emotionType),
      copingStrategyId: copingStrategyId == null && nullToAbsent ? const Value.absent() : Value(copingStrategyId),
      outcome: outcome == null && nullToAbsent ? const Value.absent() : Value(outcome),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      pauseDurationSeconds: pauseDurationSeconds == null && nullToAbsent ? const Value.absent() : Value(pauseDurationSeconds),
    );
  }

  factory UrgeSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UrgeSession(
      id: serializer.fromJson<String>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      initialIntensity: serializer.fromJson<int>(json['initialIntensity']),
      finalIntensity: serializer.fromJson<int?>(json['finalIntensity']),
      triggerType: serializer.fromJson<String?>(json['triggerType']),
      emotionType: serializer.fromJson<String?>(json['emotionType']),
      copingStrategyId: serializer.fromJson<String?>(json['copingStrategyId']),
      outcome: serializer.fromJson<String?>(json['outcome']),
      notes: serializer.fromJson<String?>(json['notes']),
      pauseDurationSeconds: serializer.fromJson<int?>(
        json['pauseDurationSeconds'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'initialIntensity': serializer.toJson<int>(initialIntensity),
      'finalIntensity': serializer.toJson<int?>(finalIntensity),
      'triggerType': serializer.toJson<String?>(triggerType),
      'emotionType': serializer.toJson<String?>(emotionType),
      'copingStrategyId': serializer.toJson<String?>(copingStrategyId),
      'outcome': serializer.toJson<String?>(outcome),
      'notes': serializer.toJson<String?>(notes),
      'pauseDurationSeconds': serializer.toJson<int?>(pauseDurationSeconds),
    };
  }

  UrgeSession copyWith({
    String? id,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    int? initialIntensity,
    Value<int?> finalIntensity = const Value.absent(),
    Value<String?> triggerType = const Value.absent(),
    Value<String?> emotionType = const Value.absent(),
    Value<String?> copingStrategyId = const Value.absent(),
    Value<String?> outcome = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<int?> pauseDurationSeconds = const Value.absent(),
  }) => UrgeSession(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    initialIntensity: initialIntensity ?? this.initialIntensity,
    finalIntensity: finalIntensity.present ? finalIntensity.value : this.finalIntensity,
    triggerType: triggerType.present ? triggerType.value : this.triggerType,
    emotionType: emotionType.present ? emotionType.value : this.emotionType,
    copingStrategyId: copingStrategyId.present ? copingStrategyId.value : this.copingStrategyId,
    outcome: outcome.present ? outcome.value : this.outcome,
    notes: notes.present ? notes.value : this.notes,
    pauseDurationSeconds: pauseDurationSeconds.present ? pauseDurationSeconds.value : this.pauseDurationSeconds,
  );
  UrgeSession copyWithCompanion(UrgeSessionsCompanion data) {
    return UrgeSession(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present ? data.completedAt.value : this.completedAt,
      initialIntensity: data.initialIntensity.present ? data.initialIntensity.value : this.initialIntensity,
      finalIntensity: data.finalIntensity.present ? data.finalIntensity.value : this.finalIntensity,
      triggerType: data.triggerType.present ? data.triggerType.value : this.triggerType,
      emotionType: data.emotionType.present ? data.emotionType.value : this.emotionType,
      copingStrategyId: data.copingStrategyId.present ? data.copingStrategyId.value : this.copingStrategyId,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      notes: data.notes.present ? data.notes.value : this.notes,
      pauseDurationSeconds: data.pauseDurationSeconds.present ? data.pauseDurationSeconds.value : this.pauseDurationSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UrgeSession(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('initialIntensity: $initialIntensity, ')
          ..write('finalIntensity: $finalIntensity, ')
          ..write('triggerType: $triggerType, ')
          ..write('emotionType: $emotionType, ')
          ..write('copingStrategyId: $copingStrategyId, ')
          ..write('outcome: $outcome, ')
          ..write('notes: $notes, ')
          ..write('pauseDurationSeconds: $pauseDurationSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    completedAt,
    initialIntensity,
    finalIntensity,
    triggerType,
    emotionType,
    copingStrategyId,
    outcome,
    notes,
    pauseDurationSeconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UrgeSession &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.initialIntensity == this.initialIntensity &&
          other.finalIntensity == this.finalIntensity &&
          other.triggerType == this.triggerType &&
          other.emotionType == this.emotionType &&
          other.copingStrategyId == this.copingStrategyId &&
          other.outcome == this.outcome &&
          other.notes == this.notes &&
          other.pauseDurationSeconds == this.pauseDurationSeconds);
}

class UrgeSessionsCompanion extends UpdateCompanion<UrgeSession> {
  final Value<String> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> initialIntensity;
  final Value<int?> finalIntensity;
  final Value<String?> triggerType;
  final Value<String?> emotionType;
  final Value<String?> copingStrategyId;
  final Value<String?> outcome;
  final Value<String?> notes;
  final Value<int?> pauseDurationSeconds;
  final Value<int> rowid;
  const UrgeSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.initialIntensity = const Value.absent(),
    this.finalIntensity = const Value.absent(),
    this.triggerType = const Value.absent(),
    this.emotionType = const Value.absent(),
    this.copingStrategyId = const Value.absent(),
    this.outcome = const Value.absent(),
    this.notes = const Value.absent(),
    this.pauseDurationSeconds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UrgeSessionsCompanion.insert({
    required String id,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required int initialIntensity,
    this.finalIntensity = const Value.absent(),
    this.triggerType = const Value.absent(),
    this.emotionType = const Value.absent(),
    this.copingStrategyId = const Value.absent(),
    this.outcome = const Value.absent(),
    this.notes = const Value.absent(),
    this.pauseDurationSeconds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt),
       initialIntensity = Value(initialIntensity);
  static Insertable<UrgeSession> custom({
    Expression<String>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? initialIntensity,
    Expression<int>? finalIntensity,
    Expression<String>? triggerType,
    Expression<String>? emotionType,
    Expression<String>? copingStrategyId,
    Expression<String>? outcome,
    Expression<String>? notes,
    Expression<int>? pauseDurationSeconds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (initialIntensity != null) 'initial_intensity': initialIntensity,
      if (finalIntensity != null) 'final_intensity': finalIntensity,
      if (triggerType != null) 'trigger_type': triggerType,
      if (emotionType != null) 'emotion_type': emotionType,
      if (copingStrategyId != null) 'coping_strategy_id': copingStrategyId,
      if (outcome != null) 'outcome': outcome,
      if (notes != null) 'notes': notes,
      if (pauseDurationSeconds != null) 'pause_duration_seconds': pauseDurationSeconds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UrgeSessionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<int>? initialIntensity,
    Value<int?>? finalIntensity,
    Value<String?>? triggerType,
    Value<String?>? emotionType,
    Value<String?>? copingStrategyId,
    Value<String?>? outcome,
    Value<String?>? notes,
    Value<int?>? pauseDurationSeconds,
    Value<int>? rowid,
  }) {
    return UrgeSessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      initialIntensity: initialIntensity ?? this.initialIntensity,
      finalIntensity: finalIntensity ?? this.finalIntensity,
      triggerType: triggerType ?? this.triggerType,
      emotionType: emotionType ?? this.emotionType,
      copingStrategyId: copingStrategyId ?? this.copingStrategyId,
      outcome: outcome ?? this.outcome,
      notes: notes ?? this.notes,
      pauseDurationSeconds: pauseDurationSeconds ?? this.pauseDurationSeconds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (initialIntensity.present) {
      map['initial_intensity'] = Variable<int>(initialIntensity.value);
    }
    if (finalIntensity.present) {
      map['final_intensity'] = Variable<int>(finalIntensity.value);
    }
    if (triggerType.present) {
      map['trigger_type'] = Variable<String>(triggerType.value);
    }
    if (emotionType.present) {
      map['emotion_type'] = Variable<String>(emotionType.value);
    }
    if (copingStrategyId.present) {
      map['coping_strategy_id'] = Variable<String>(copingStrategyId.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (pauseDurationSeconds.present) {
      map['pause_duration_seconds'] = Variable<int>(pauseDurationSeconds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UrgeSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('initialIntensity: $initialIntensity, ')
          ..write('finalIntensity: $finalIntensity, ')
          ..write('triggerType: $triggerType, ')
          ..write('emotionType: $emotionType, ')
          ..write('copingStrategyId: $copingStrategyId, ')
          ..write('outcome: $outcome, ')
          ..write('notes: $notes, ')
          ..write('pauseDurationSeconds: $pauseDurationSeconds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConsumptionEventsTable extends ConsumptionEvents with TableInfo<$ConsumptionEventsTable, ConsumptionEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsumptionEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggerTypeMeta = const VerificationMeta(
    'triggerType',
  );
  @override
  late final GeneratedColumn<String> triggerType = GeneratedColumn<String>(
    'trigger_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emotionTypeMeta = const VerificationMeta(
    'emotionType',
  );
  @override
  late final GeneratedColumn<String> emotionType = GeneratedColumn<String>(
    'emotion_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contextLabelMeta = const VerificationMeta(
    'contextLabel',
  );
  @override
  late final GeneratedColumn<String> contextLabel = GeneratedColumn<String>(
    'context_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contextKeysJsonMeta = const VerificationMeta(
    'contextKeysJson',
  );
  @override
  late final GeneratedColumn<String> contextKeysJson = GeneratedColumn<String>(
    'context_keys_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _perceivedControlMeta = const VerificationMeta(
    'perceivedControl',
  );
  @override
  late final GeneratedColumn<int> perceivedControl = GeneratedColumn<int>(
    'perceived_control',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urgeSessionIdMeta = const VerificationMeta(
    'urgeSessionId',
  );
  @override
  late final GeneratedColumn<String> urgeSessionId = GeneratedColumn<String>(
    'urge_session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES urge_sessions (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    occurredAt,
    triggerType,
    emotionType,
    contextLabel,
    contextKeysJson,
    perceivedControl,
    notes,
    urgeSessionId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consumption_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConsumptionEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('trigger_type')) {
      context.handle(
        _triggerTypeMeta,
        triggerType.isAcceptableOrUnknown(
          data['trigger_type']!,
          _triggerTypeMeta,
        ),
      );
    }
    if (data.containsKey('emotion_type')) {
      context.handle(
        _emotionTypeMeta,
        emotionType.isAcceptableOrUnknown(
          data['emotion_type']!,
          _emotionTypeMeta,
        ),
      );
    }
    if (data.containsKey('context_label')) {
      context.handle(
        _contextLabelMeta,
        contextLabel.isAcceptableOrUnknown(
          data['context_label']!,
          _contextLabelMeta,
        ),
      );
    }
    if (data.containsKey('context_keys_json')) {
      context.handle(
        _contextKeysJsonMeta,
        contextKeysJson.isAcceptableOrUnknown(
          data['context_keys_json']!,
          _contextKeysJsonMeta,
        ),
      );
    }
    if (data.containsKey('perceived_control')) {
      context.handle(
        _perceivedControlMeta,
        perceivedControl.isAcceptableOrUnknown(
          data['perceived_control']!,
          _perceivedControlMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('urge_session_id')) {
      context.handle(
        _urgeSessionIdMeta,
        urgeSessionId.isAcceptableOrUnknown(
          data['urge_session_id']!,
          _urgeSessionIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConsumptionEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConsumptionEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      triggerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger_type'],
      ),
      emotionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emotion_type'],
      ),
      contextLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_label'],
      ),
      contextKeysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_keys_json'],
      ),
      perceivedControl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}perceived_control'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      urgeSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}urge_session_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ConsumptionEventsTable createAlias(String alias) {
    return $ConsumptionEventsTable(attachedDatabase, alias);
  }
}

class ConsumptionEvent extends DataClass implements Insertable<ConsumptionEvent> {
  /// Stable UUID of the event.
  final String id;

  /// UTC timestamp supplied for the event.
  final DateTime occurredAt;

  /// Optional persisted [TriggerType] name.
  final String? triggerType;

  /// Optional persisted [EmotionType] name.
  final String? emotionType;

  /// Optional general context written by the user.
  final String? contextLabel;

  /// JSON array of stable contextual-goal keys selected for this event.
  final String? contextKeysJson;

  /// Optional perceived-control score from zero to ten.
  final int? perceivedControl;

  /// Optional free-form note.
  final String? notes;

  /// Optional urge session this event was recorded from.
  final String? urgeSessionId;

  /// UTC timestamp at which the record was created.
  final DateTime createdAt;
  const ConsumptionEvent({
    required this.id,
    required this.occurredAt,
    this.triggerType,
    this.emotionType,
    this.contextLabel,
    this.contextKeysJson,
    this.perceivedControl,
    this.notes,
    this.urgeSessionId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || triggerType != null) {
      map['trigger_type'] = Variable<String>(triggerType);
    }
    if (!nullToAbsent || emotionType != null) {
      map['emotion_type'] = Variable<String>(emotionType);
    }
    if (!nullToAbsent || contextLabel != null) {
      map['context_label'] = Variable<String>(contextLabel);
    }
    if (!nullToAbsent || contextKeysJson != null) {
      map['context_keys_json'] = Variable<String>(contextKeysJson);
    }
    if (!nullToAbsent || perceivedControl != null) {
      map['perceived_control'] = Variable<int>(perceivedControl);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || urgeSessionId != null) {
      map['urge_session_id'] = Variable<String>(urgeSessionId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ConsumptionEventsCompanion toCompanion(bool nullToAbsent) {
    return ConsumptionEventsCompanion(
      id: Value(id),
      occurredAt: Value(occurredAt),
      triggerType: triggerType == null && nullToAbsent ? const Value.absent() : Value(triggerType),
      emotionType: emotionType == null && nullToAbsent ? const Value.absent() : Value(emotionType),
      contextLabel: contextLabel == null && nullToAbsent ? const Value.absent() : Value(contextLabel),
      contextKeysJson: contextKeysJson == null && nullToAbsent ? const Value.absent() : Value(contextKeysJson),
      perceivedControl: perceivedControl == null && nullToAbsent ? const Value.absent() : Value(perceivedControl),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      urgeSessionId: urgeSessionId == null && nullToAbsent ? const Value.absent() : Value(urgeSessionId),
      createdAt: Value(createdAt),
    );
  }

  factory ConsumptionEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConsumptionEvent(
      id: serializer.fromJson<String>(json['id']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      triggerType: serializer.fromJson<String?>(json['triggerType']),
      emotionType: serializer.fromJson<String?>(json['emotionType']),
      contextLabel: serializer.fromJson<String?>(json['contextLabel']),
      contextKeysJson: serializer.fromJson<String?>(json['contextKeysJson']),
      perceivedControl: serializer.fromJson<int?>(json['perceivedControl']),
      notes: serializer.fromJson<String?>(json['notes']),
      urgeSessionId: serializer.fromJson<String?>(json['urgeSessionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'triggerType': serializer.toJson<String?>(triggerType),
      'emotionType': serializer.toJson<String?>(emotionType),
      'contextLabel': serializer.toJson<String?>(contextLabel),
      'contextKeysJson': serializer.toJson<String?>(contextKeysJson),
      'perceivedControl': serializer.toJson<int?>(perceivedControl),
      'notes': serializer.toJson<String?>(notes),
      'urgeSessionId': serializer.toJson<String?>(urgeSessionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ConsumptionEvent copyWith({
    String? id,
    DateTime? occurredAt,
    Value<String?> triggerType = const Value.absent(),
    Value<String?> emotionType = const Value.absent(),
    Value<String?> contextLabel = const Value.absent(),
    Value<String?> contextKeysJson = const Value.absent(),
    Value<int?> perceivedControl = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> urgeSessionId = const Value.absent(),
    DateTime? createdAt,
  }) => ConsumptionEvent(
    id: id ?? this.id,
    occurredAt: occurredAt ?? this.occurredAt,
    triggerType: triggerType.present ? triggerType.value : this.triggerType,
    emotionType: emotionType.present ? emotionType.value : this.emotionType,
    contextLabel: contextLabel.present ? contextLabel.value : this.contextLabel,
    contextKeysJson: contextKeysJson.present ? contextKeysJson.value : this.contextKeysJson,
    perceivedControl: perceivedControl.present ? perceivedControl.value : this.perceivedControl,
    notes: notes.present ? notes.value : this.notes,
    urgeSessionId: urgeSessionId.present ? urgeSessionId.value : this.urgeSessionId,
    createdAt: createdAt ?? this.createdAt,
  );
  ConsumptionEvent copyWithCompanion(ConsumptionEventsCompanion data) {
    return ConsumptionEvent(
      id: data.id.present ? data.id.value : this.id,
      occurredAt: data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      triggerType: data.triggerType.present ? data.triggerType.value : this.triggerType,
      emotionType: data.emotionType.present ? data.emotionType.value : this.emotionType,
      contextLabel: data.contextLabel.present ? data.contextLabel.value : this.contextLabel,
      contextKeysJson: data.contextKeysJson.present ? data.contextKeysJson.value : this.contextKeysJson,
      perceivedControl: data.perceivedControl.present ? data.perceivedControl.value : this.perceivedControl,
      notes: data.notes.present ? data.notes.value : this.notes,
      urgeSessionId: data.urgeSessionId.present ? data.urgeSessionId.value : this.urgeSessionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConsumptionEvent(')
          ..write('id: $id, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('triggerType: $triggerType, ')
          ..write('emotionType: $emotionType, ')
          ..write('contextLabel: $contextLabel, ')
          ..write('contextKeysJson: $contextKeysJson, ')
          ..write('perceivedControl: $perceivedControl, ')
          ..write('notes: $notes, ')
          ..write('urgeSessionId: $urgeSessionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    occurredAt,
    triggerType,
    emotionType,
    contextLabel,
    contextKeysJson,
    perceivedControl,
    notes,
    urgeSessionId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConsumptionEvent &&
          other.id == this.id &&
          other.occurredAt == this.occurredAt &&
          other.triggerType == this.triggerType &&
          other.emotionType == this.emotionType &&
          other.contextLabel == this.contextLabel &&
          other.contextKeysJson == this.contextKeysJson &&
          other.perceivedControl == this.perceivedControl &&
          other.notes == this.notes &&
          other.urgeSessionId == this.urgeSessionId &&
          other.createdAt == this.createdAt);
}

class ConsumptionEventsCompanion extends UpdateCompanion<ConsumptionEvent> {
  final Value<String> id;
  final Value<DateTime> occurredAt;
  final Value<String?> triggerType;
  final Value<String?> emotionType;
  final Value<String?> contextLabel;
  final Value<String?> contextKeysJson;
  final Value<int?> perceivedControl;
  final Value<String?> notes;
  final Value<String?> urgeSessionId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ConsumptionEventsCompanion({
    this.id = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.triggerType = const Value.absent(),
    this.emotionType = const Value.absent(),
    this.contextLabel = const Value.absent(),
    this.contextKeysJson = const Value.absent(),
    this.perceivedControl = const Value.absent(),
    this.notes = const Value.absent(),
    this.urgeSessionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConsumptionEventsCompanion.insert({
    required String id,
    required DateTime occurredAt,
    this.triggerType = const Value.absent(),
    this.emotionType = const Value.absent(),
    this.contextLabel = const Value.absent(),
    this.contextKeysJson = const Value.absent(),
    this.perceivedControl = const Value.absent(),
    this.notes = const Value.absent(),
    this.urgeSessionId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       occurredAt = Value(occurredAt),
       createdAt = Value(createdAt);
  static Insertable<ConsumptionEvent> custom({
    Expression<String>? id,
    Expression<DateTime>? occurredAt,
    Expression<String>? triggerType,
    Expression<String>? emotionType,
    Expression<String>? contextLabel,
    Expression<String>? contextKeysJson,
    Expression<int>? perceivedControl,
    Expression<String>? notes,
    Expression<String>? urgeSessionId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (triggerType != null) 'trigger_type': triggerType,
      if (emotionType != null) 'emotion_type': emotionType,
      if (contextLabel != null) 'context_label': contextLabel,
      if (contextKeysJson != null) 'context_keys_json': contextKeysJson,
      if (perceivedControl != null) 'perceived_control': perceivedControl,
      if (notes != null) 'notes': notes,
      if (urgeSessionId != null) 'urge_session_id': urgeSessionId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConsumptionEventsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? occurredAt,
    Value<String?>? triggerType,
    Value<String?>? emotionType,
    Value<String?>? contextLabel,
    Value<String?>? contextKeysJson,
    Value<int?>? perceivedControl,
    Value<String?>? notes,
    Value<String?>? urgeSessionId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ConsumptionEventsCompanion(
      id: id ?? this.id,
      occurredAt: occurredAt ?? this.occurredAt,
      triggerType: triggerType ?? this.triggerType,
      emotionType: emotionType ?? this.emotionType,
      contextLabel: contextLabel ?? this.contextLabel,
      contextKeysJson: contextKeysJson ?? this.contextKeysJson,
      perceivedControl: perceivedControl ?? this.perceivedControl,
      notes: notes ?? this.notes,
      urgeSessionId: urgeSessionId ?? this.urgeSessionId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (triggerType.present) {
      map['trigger_type'] = Variable<String>(triggerType.value);
    }
    if (emotionType.present) {
      map['emotion_type'] = Variable<String>(emotionType.value);
    }
    if (contextLabel.present) {
      map['context_label'] = Variable<String>(contextLabel.value);
    }
    if (contextKeysJson.present) {
      map['context_keys_json'] = Variable<String>(contextKeysJson.value);
    }
    if (perceivedControl.present) {
      map['perceived_control'] = Variable<int>(perceivedControl.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (urgeSessionId.present) {
      map['urge_session_id'] = Variable<String>(urgeSessionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsumptionEventsCompanion(')
          ..write('id: $id, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('triggerType: $triggerType, ')
          ..write('emotionType: $emotionType, ')
          ..write('contextLabel: $contextLabel, ')
          ..write('contextKeysJson: $contextKeysJson, ')
          ..write('perceivedControl: $perceivedControl, ')
          ..write('notes: $notes, ')
          ..write('urgeSessionId: $urgeSessionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyCheckInsTable extends DailyCheckIns with TableInfo<$DailyCheckInsTable, DailyCheckIn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyCheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodScoreMeta = const VerificationMeta(
    'moodScore',
  );
  @override
  late final GeneratedColumn<int> moodScore = GeneratedColumn<int>(
    'mood_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _controlScoreMeta = const VerificationMeta(
    'controlScore',
  );
  @override
  late final GeneratedColumn<int> controlScore = GeneratedColumn<int>(
    'control_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urgeCountEstimateMeta = const VerificationMeta(
    'urgeCountEstimate',
  );
  @override
  late final GeneratedColumn<int> urgeCountEstimate = GeneratedColumn<int>(
    'urge_count_estimate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepQualityMeta = const VerificationMeta(
    'sleepQuality',
  );
  @override
  late final GeneratedColumn<int> sleepQuality = GeneratedColumn<int>(
    'sleep_quality',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localDate,
    createdAt,
    updatedAt,
    moodScore,
    controlScore,
    urgeCountEstimate,
    sleepQuality,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyCheckIn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('mood_score')) {
      context.handle(
        _moodScoreMeta,
        moodScore.isAcceptableOrUnknown(data['mood_score']!, _moodScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_moodScoreMeta);
    }
    if (data.containsKey('control_score')) {
      context.handle(
        _controlScoreMeta,
        controlScore.isAcceptableOrUnknown(
          data['control_score']!,
          _controlScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_controlScoreMeta);
    }
    if (data.containsKey('urge_count_estimate')) {
      context.handle(
        _urgeCountEstimateMeta,
        urgeCountEstimate.isAcceptableOrUnknown(
          data['urge_count_estimate']!,
          _urgeCountEstimateMeta,
        ),
      );
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
        _sleepQualityMeta,
        sleepQuality.isAcceptableOrUnknown(
          data['sleep_quality']!,
          _sleepQualityMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localDate};
  @override
  DailyCheckIn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyCheckIn(
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      moodScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood_score'],
      )!,
      controlScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}control_score'],
      )!,
      urgeCountEstimate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}urge_count_estimate'],
      ),
      sleepQuality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_quality'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $DailyCheckInsTable createAlias(String alias) {
    return $DailyCheckInsTable(attachedDatabase, alias);
  }
}

class DailyCheckIn extends DataClass implements Insertable<DailyCheckIn> {
  /// Local date encoded as `yyyy-MM-dd`.
  final String localDate;

  /// UTC creation timestamp.
  final DateTime createdAt;

  /// UTC timestamp of the latest update.
  final DateTime updatedAt;

  /// Mood score from zero to ten.
  final int moodScore;

  /// Perceived-control score from zero to ten.
  final int controlScore;

  /// Optional approximate number of urges that day.
  final int? urgeCountEstimate;

  /// Optional sleep-quality score from zero to ten.
  final int? sleepQuality;

  /// Optional free-form daily note.
  final String? note;
  const DailyCheckIn({
    required this.localDate,
    required this.createdAt,
    required this.updatedAt,
    required this.moodScore,
    required this.controlScore,
    this.urgeCountEstimate,
    this.sleepQuality,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_date'] = Variable<String>(localDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['mood_score'] = Variable<int>(moodScore);
    map['control_score'] = Variable<int>(controlScore);
    if (!nullToAbsent || urgeCountEstimate != null) {
      map['urge_count_estimate'] = Variable<int>(urgeCountEstimate);
    }
    if (!nullToAbsent || sleepQuality != null) {
      map['sleep_quality'] = Variable<int>(sleepQuality);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  DailyCheckInsCompanion toCompanion(bool nullToAbsent) {
    return DailyCheckInsCompanion(
      localDate: Value(localDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      moodScore: Value(moodScore),
      controlScore: Value(controlScore),
      urgeCountEstimate: urgeCountEstimate == null && nullToAbsent ? const Value.absent() : Value(urgeCountEstimate),
      sleepQuality: sleepQuality == null && nullToAbsent ? const Value.absent() : Value(sleepQuality),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory DailyCheckIn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyCheckIn(
      localDate: serializer.fromJson<String>(json['localDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      moodScore: serializer.fromJson<int>(json['moodScore']),
      controlScore: serializer.fromJson<int>(json['controlScore']),
      urgeCountEstimate: serializer.fromJson<int?>(json['urgeCountEstimate']),
      sleepQuality: serializer.fromJson<int?>(json['sleepQuality']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localDate': serializer.toJson<String>(localDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'moodScore': serializer.toJson<int>(moodScore),
      'controlScore': serializer.toJson<int>(controlScore),
      'urgeCountEstimate': serializer.toJson<int?>(urgeCountEstimate),
      'sleepQuality': serializer.toJson<int?>(sleepQuality),
      'note': serializer.toJson<String?>(note),
    };
  }

  DailyCheckIn copyWith({
    String? localDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? moodScore,
    int? controlScore,
    Value<int?> urgeCountEstimate = const Value.absent(),
    Value<int?> sleepQuality = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => DailyCheckIn(
    localDate: localDate ?? this.localDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    moodScore: moodScore ?? this.moodScore,
    controlScore: controlScore ?? this.controlScore,
    urgeCountEstimate: urgeCountEstimate.present ? urgeCountEstimate.value : this.urgeCountEstimate,
    sleepQuality: sleepQuality.present ? sleepQuality.value : this.sleepQuality,
    note: note.present ? note.value : this.note,
  );
  DailyCheckIn copyWithCompanion(DailyCheckInsCompanion data) {
    return DailyCheckIn(
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      moodScore: data.moodScore.present ? data.moodScore.value : this.moodScore,
      controlScore: data.controlScore.present ? data.controlScore.value : this.controlScore,
      urgeCountEstimate: data.urgeCountEstimate.present ? data.urgeCountEstimate.value : this.urgeCountEstimate,
      sleepQuality: data.sleepQuality.present ? data.sleepQuality.value : this.sleepQuality,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckIn(')
          ..write('localDate: $localDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('moodScore: $moodScore, ')
          ..write('controlScore: $controlScore, ')
          ..write('urgeCountEstimate: $urgeCountEstimate, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localDate,
    createdAt,
    updatedAt,
    moodScore,
    controlScore,
    urgeCountEstimate,
    sleepQuality,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyCheckIn &&
          other.localDate == this.localDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.moodScore == this.moodScore &&
          other.controlScore == this.controlScore &&
          other.urgeCountEstimate == this.urgeCountEstimate &&
          other.sleepQuality == this.sleepQuality &&
          other.note == this.note);
}

class DailyCheckInsCompanion extends UpdateCompanion<DailyCheckIn> {
  final Value<String> localDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> moodScore;
  final Value<int> controlScore;
  final Value<int?> urgeCountEstimate;
  final Value<int?> sleepQuality;
  final Value<String?> note;
  final Value<int> rowid;
  const DailyCheckInsCompanion({
    this.localDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.moodScore = const Value.absent(),
    this.controlScore = const Value.absent(),
    this.urgeCountEstimate = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyCheckInsCompanion.insert({
    required String localDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int moodScore,
    required int controlScore,
    this.urgeCountEstimate = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : localDate = Value(localDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       moodScore = Value(moodScore),
       controlScore = Value(controlScore);
  static Insertable<DailyCheckIn> custom({
    Expression<String>? localDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? moodScore,
    Expression<int>? controlScore,
    Expression<int>? urgeCountEstimate,
    Expression<int>? sleepQuality,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (localDate != null) 'local_date': localDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (moodScore != null) 'mood_score': moodScore,
      if (controlScore != null) 'control_score': controlScore,
      if (urgeCountEstimate != null) 'urge_count_estimate': urgeCountEstimate,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyCheckInsCompanion copyWith({
    Value<String>? localDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? moodScore,
    Value<int>? controlScore,
    Value<int?>? urgeCountEstimate,
    Value<int?>? sleepQuality,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return DailyCheckInsCompanion(
      localDate: localDate ?? this.localDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      moodScore: moodScore ?? this.moodScore,
      controlScore: controlScore ?? this.controlScore,
      urgeCountEstimate: urgeCountEstimate ?? this.urgeCountEstimate,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (moodScore.present) {
      map['mood_score'] = Variable<int>(moodScore.value);
    }
    if (controlScore.present) {
      map['control_score'] = Variable<int>(controlScore.value);
    }
    if (urgeCountEstimate.present) {
      map['urge_count_estimate'] = Variable<int>(urgeCountEstimate.value);
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<int>(sleepQuality.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyCheckInsCompanion(')
          ..write('localDate: $localDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('moodScore: $moodScore, ')
          ..write('controlScore: $controlScore, ')
          ..write('urgeCountEstimate: $urgeCountEstimate, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SelfAssessmentsTable extends SelfAssessments with TableInfo<$SelfAssessmentsTable, SelfAssessment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SelfAssessmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weeklyFrequencyMeta = const VerificationMeta(
    'weeklyFrequency',
  );
  @override
  late final GeneratedColumn<int> weeklyFrequency = GeneratedColumn<int>(
    'weekly_frequency',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _perceivedControlMeta = const VerificationMeta(
    'perceivedControl',
  );
  @override
  late final GeneratedColumn<int> perceivedControl = GeneratedColumn<int>(
    'perceived_control',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _negativeImpactMeta = const VerificationMeta(
    'negativeImpact',
  );
  @override
  late final GeneratedColumn<int> negativeImpact = GeneratedColumn<int>(
    'negative_impact',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceToChangeMeta = const VerificationMeta('confidenceToChange');
  @override
  late final GeneratedColumn<int> confidenceToChange = GeneratedColumn<int>(
    'confidence_to_change',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recordedAt,
    kind,
    weeklyFrequency,
    perceivedControl,
    negativeImpact,
    confidenceToChange,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'self_assessments';
  @override
  VerificationContext validateIntegrity(
    Insertable<SelfAssessment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('weekly_frequency')) {
      context.handle(
        _weeklyFrequencyMeta,
        weeklyFrequency.isAcceptableOrUnknown(
          data['weekly_frequency']!,
          _weeklyFrequencyMeta,
        ),
      );
    }
    if (data.containsKey('perceived_control')) {
      context.handle(
        _perceivedControlMeta,
        perceivedControl.isAcceptableOrUnknown(
          data['perceived_control']!,
          _perceivedControlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_perceivedControlMeta);
    }
    if (data.containsKey('negative_impact')) {
      context.handle(
        _negativeImpactMeta,
        negativeImpact.isAcceptableOrUnknown(
          data['negative_impact']!,
          _negativeImpactMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_negativeImpactMeta);
    }
    if (data.containsKey('confidence_to_change')) {
      context.handle(
        _confidenceToChangeMeta,
        confidenceToChange.isAcceptableOrUnknown(
          data['confidence_to_change']!,
          _confidenceToChangeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_confidenceToChangeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SelfAssessment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SelfAssessment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      weeklyFrequency: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_frequency'],
      ),
      perceivedControl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}perceived_control'],
      )!,
      negativeImpact: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}negative_impact'],
      )!,
      confidenceToChange: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confidence_to_change'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $SelfAssessmentsTable createAlias(String alias) {
    return $SelfAssessmentsTable(attachedDatabase, alias);
  }
}

class SelfAssessment extends DataClass implements Insertable<SelfAssessment> {
  /// Stable UUID of the assessment.
  final String id;

  /// UTC timestamp at which the assessment was recorded.
  final DateTime recordedAt;

  /// Persisted [AssessmentKind] name.
  final String kind;

  /// Optional reported event frequency over seven days.
  final int? weeklyFrequency;

  /// Perceived-control score from zero to ten.
  final int perceivedControl;

  /// Perceived negative-impact score from zero to ten.
  final int negativeImpact;

  /// Confidence-to-change score from zero to ten.
  final int confidenceToChange;

  /// Optional free-form reflection.
  final String? notes;
  const SelfAssessment({
    required this.id,
    required this.recordedAt,
    required this.kind,
    this.weeklyFrequency,
    required this.perceivedControl,
    required this.negativeImpact,
    required this.confidenceToChange,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || weeklyFrequency != null) {
      map['weekly_frequency'] = Variable<int>(weeklyFrequency);
    }
    map['perceived_control'] = Variable<int>(perceivedControl);
    map['negative_impact'] = Variable<int>(negativeImpact);
    map['confidence_to_change'] = Variable<int>(confidenceToChange);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SelfAssessmentsCompanion toCompanion(bool nullToAbsent) {
    return SelfAssessmentsCompanion(
      id: Value(id),
      recordedAt: Value(recordedAt),
      kind: Value(kind),
      weeklyFrequency: weeklyFrequency == null && nullToAbsent ? const Value.absent() : Value(weeklyFrequency),
      perceivedControl: Value(perceivedControl),
      negativeImpact: Value(negativeImpact),
      confidenceToChange: Value(confidenceToChange),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory SelfAssessment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SelfAssessment(
      id: serializer.fromJson<String>(json['id']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      kind: serializer.fromJson<String>(json['kind']),
      weeklyFrequency: serializer.fromJson<int?>(json['weeklyFrequency']),
      perceivedControl: serializer.fromJson<int>(json['perceivedControl']),
      negativeImpact: serializer.fromJson<int>(json['negativeImpact']),
      confidenceToChange: serializer.fromJson<int>(json['confidenceToChange']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'kind': serializer.toJson<String>(kind),
      'weeklyFrequency': serializer.toJson<int?>(weeklyFrequency),
      'perceivedControl': serializer.toJson<int>(perceivedControl),
      'negativeImpact': serializer.toJson<int>(negativeImpact),
      'confidenceToChange': serializer.toJson<int>(confidenceToChange),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  SelfAssessment copyWith({
    String? id,
    DateTime? recordedAt,
    String? kind,
    Value<int?> weeklyFrequency = const Value.absent(),
    int? perceivedControl,
    int? negativeImpact,
    int? confidenceToChange,
    Value<String?> notes = const Value.absent(),
  }) => SelfAssessment(
    id: id ?? this.id,
    recordedAt: recordedAt ?? this.recordedAt,
    kind: kind ?? this.kind,
    weeklyFrequency: weeklyFrequency.present ? weeklyFrequency.value : this.weeklyFrequency,
    perceivedControl: perceivedControl ?? this.perceivedControl,
    negativeImpact: negativeImpact ?? this.negativeImpact,
    confidenceToChange: confidenceToChange ?? this.confidenceToChange,
    notes: notes.present ? notes.value : this.notes,
  );
  SelfAssessment copyWithCompanion(SelfAssessmentsCompanion data) {
    return SelfAssessment(
      id: data.id.present ? data.id.value : this.id,
      recordedAt: data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      kind: data.kind.present ? data.kind.value : this.kind,
      weeklyFrequency: data.weeklyFrequency.present ? data.weeklyFrequency.value : this.weeklyFrequency,
      perceivedControl: data.perceivedControl.present ? data.perceivedControl.value : this.perceivedControl,
      negativeImpact: data.negativeImpact.present ? data.negativeImpact.value : this.negativeImpact,
      confidenceToChange: data.confidenceToChange.present ? data.confidenceToChange.value : this.confidenceToChange,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SelfAssessment(')
          ..write('id: $id, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('kind: $kind, ')
          ..write('weeklyFrequency: $weeklyFrequency, ')
          ..write('perceivedControl: $perceivedControl, ')
          ..write('negativeImpact: $negativeImpact, ')
          ..write('confidenceToChange: $confidenceToChange, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recordedAt,
    kind,
    weeklyFrequency,
    perceivedControl,
    negativeImpact,
    confidenceToChange,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SelfAssessment &&
          other.id == this.id &&
          other.recordedAt == this.recordedAt &&
          other.kind == this.kind &&
          other.weeklyFrequency == this.weeklyFrequency &&
          other.perceivedControl == this.perceivedControl &&
          other.negativeImpact == this.negativeImpact &&
          other.confidenceToChange == this.confidenceToChange &&
          other.notes == this.notes);
}

class SelfAssessmentsCompanion extends UpdateCompanion<SelfAssessment> {
  final Value<String> id;
  final Value<DateTime> recordedAt;
  final Value<String> kind;
  final Value<int?> weeklyFrequency;
  final Value<int> perceivedControl;
  final Value<int> negativeImpact;
  final Value<int> confidenceToChange;
  final Value<String?> notes;
  final Value<int> rowid;
  const SelfAssessmentsCompanion({
    this.id = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.kind = const Value.absent(),
    this.weeklyFrequency = const Value.absent(),
    this.perceivedControl = const Value.absent(),
    this.negativeImpact = const Value.absent(),
    this.confidenceToChange = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SelfAssessmentsCompanion.insert({
    required String id,
    required DateTime recordedAt,
    required String kind,
    this.weeklyFrequency = const Value.absent(),
    required int perceivedControl,
    required int negativeImpact,
    required int confidenceToChange,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recordedAt = Value(recordedAt),
       kind = Value(kind),
       perceivedControl = Value(perceivedControl),
       negativeImpact = Value(negativeImpact),
       confidenceToChange = Value(confidenceToChange);
  static Insertable<SelfAssessment> custom({
    Expression<String>? id,
    Expression<DateTime>? recordedAt,
    Expression<String>? kind,
    Expression<int>? weeklyFrequency,
    Expression<int>? perceivedControl,
    Expression<int>? negativeImpact,
    Expression<int>? confidenceToChange,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (kind != null) 'kind': kind,
      if (weeklyFrequency != null) 'weekly_frequency': weeklyFrequency,
      if (perceivedControl != null) 'perceived_control': perceivedControl,
      if (negativeImpact != null) 'negative_impact': negativeImpact,
      if (confidenceToChange != null) 'confidence_to_change': confidenceToChange,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SelfAssessmentsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? recordedAt,
    Value<String>? kind,
    Value<int?>? weeklyFrequency,
    Value<int>? perceivedControl,
    Value<int>? negativeImpact,
    Value<int>? confidenceToChange,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return SelfAssessmentsCompanion(
      id: id ?? this.id,
      recordedAt: recordedAt ?? this.recordedAt,
      kind: kind ?? this.kind,
      weeklyFrequency: weeklyFrequency ?? this.weeklyFrequency,
      perceivedControl: perceivedControl ?? this.perceivedControl,
      negativeImpact: negativeImpact ?? this.negativeImpact,
      confidenceToChange: confidenceToChange ?? this.confidenceToChange,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (weeklyFrequency.present) {
      map['weekly_frequency'] = Variable<int>(weeklyFrequency.value);
    }
    if (perceivedControl.present) {
      map['perceived_control'] = Variable<int>(perceivedControl.value);
    }
    if (negativeImpact.present) {
      map['negative_impact'] = Variable<int>(negativeImpact.value);
    }
    if (confidenceToChange.present) {
      map['confidence_to_change'] = Variable<int>(confidenceToChange.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SelfAssessmentsCompanion(')
          ..write('id: $id, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('kind: $kind, ')
          ..write('weeklyFrequency: $weeklyFrequency, ')
          ..write('perceivedControl: $perceivedControl, ')
          ..write('negativeImpact: $negativeImpact, ')
          ..write('confidenceToChange: $confidenceToChange, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CopingStrategyUsesTable extends CopingStrategyUses with TableInfo<$CopingStrategyUsesTable, CopingStrategyUse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CopingStrategyUsesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strategyIdMeta = const VerificationMeta(
    'strategyId',
  );
  @override
  late final GeneratedColumn<String> strategyId = GeneratedColumn<String>(
    'strategy_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coping_strategies (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _usedAtMeta = const VerificationMeta('usedAt');
  @override
  late final GeneratedColumn<DateTime> usedAt = GeneratedColumn<DateTime>(
    'used_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urgeSessionIdMeta = const VerificationMeta(
    'urgeSessionId',
  );
  @override
  late final GeneratedColumn<String> urgeSessionId = GeneratedColumn<String>(
    'urge_session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES urge_sessions (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _perceivedEffectMeta = const VerificationMeta(
    'perceivedEffect',
  );
  @override
  late final GeneratedColumn<int> perceivedEffect = GeneratedColumn<int>(
    'perceived_effect',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    strategyId,
    usedAt,
    urgeSessionId,
    perceivedEffect,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coping_strategy_uses';
  @override
  VerificationContext validateIntegrity(
    Insertable<CopingStrategyUse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('strategy_id')) {
      context.handle(
        _strategyIdMeta,
        strategyId.isAcceptableOrUnknown(data['strategy_id']!, _strategyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_strategyIdMeta);
    }
    if (data.containsKey('used_at')) {
      context.handle(
        _usedAtMeta,
        usedAt.isAcceptableOrUnknown(data['used_at']!, _usedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_usedAtMeta);
    }
    if (data.containsKey('urge_session_id')) {
      context.handle(
        _urgeSessionIdMeta,
        urgeSessionId.isAcceptableOrUnknown(
          data['urge_session_id']!,
          _urgeSessionIdMeta,
        ),
      );
    }
    if (data.containsKey('perceived_effect')) {
      context.handle(
        _perceivedEffectMeta,
        perceivedEffect.isAcceptableOrUnknown(
          data['perceived_effect']!,
          _perceivedEffectMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CopingStrategyUse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CopingStrategyUse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      strategyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}strategy_id'],
      )!,
      usedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}used_at'],
      )!,
      urgeSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}urge_session_id'],
      ),
      perceivedEffect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}perceived_effect'],
      ),
    );
  }

  @override
  $CopingStrategyUsesTable createAlias(String alias) {
    return $CopingStrategyUsesTable(attachedDatabase, alias);
  }
}

class CopingStrategyUse extends DataClass implements Insertable<CopingStrategyUse> {
  /// Stable UUID of the use record.
  final String id;

  /// Strategy that was used.
  final String strategyId;

  /// UTC timestamp at which the strategy was tried.
  final DateTime usedAt;

  /// Optional urge session during which the strategy was used.
  final String? urgeSessionId;

  /// Optional perceived effect on the minus-five-to-five scale.
  final int? perceivedEffect;
  const CopingStrategyUse({
    required this.id,
    required this.strategyId,
    required this.usedAt,
    this.urgeSessionId,
    this.perceivedEffect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['strategy_id'] = Variable<String>(strategyId);
    map['used_at'] = Variable<DateTime>(usedAt);
    if (!nullToAbsent || urgeSessionId != null) {
      map['urge_session_id'] = Variable<String>(urgeSessionId);
    }
    if (!nullToAbsent || perceivedEffect != null) {
      map['perceived_effect'] = Variable<int>(perceivedEffect);
    }
    return map;
  }

  CopingStrategyUsesCompanion toCompanion(bool nullToAbsent) {
    return CopingStrategyUsesCompanion(
      id: Value(id),
      strategyId: Value(strategyId),
      usedAt: Value(usedAt),
      urgeSessionId: urgeSessionId == null && nullToAbsent ? const Value.absent() : Value(urgeSessionId),
      perceivedEffect: perceivedEffect == null && nullToAbsent ? const Value.absent() : Value(perceivedEffect),
    );
  }

  factory CopingStrategyUse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CopingStrategyUse(
      id: serializer.fromJson<String>(json['id']),
      strategyId: serializer.fromJson<String>(json['strategyId']),
      usedAt: serializer.fromJson<DateTime>(json['usedAt']),
      urgeSessionId: serializer.fromJson<String?>(json['urgeSessionId']),
      perceivedEffect: serializer.fromJson<int?>(json['perceivedEffect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'strategyId': serializer.toJson<String>(strategyId),
      'usedAt': serializer.toJson<DateTime>(usedAt),
      'urgeSessionId': serializer.toJson<String?>(urgeSessionId),
      'perceivedEffect': serializer.toJson<int?>(perceivedEffect),
    };
  }

  CopingStrategyUse copyWith({
    String? id,
    String? strategyId,
    DateTime? usedAt,
    Value<String?> urgeSessionId = const Value.absent(),
    Value<int?> perceivedEffect = const Value.absent(),
  }) => CopingStrategyUse(
    id: id ?? this.id,
    strategyId: strategyId ?? this.strategyId,
    usedAt: usedAt ?? this.usedAt,
    urgeSessionId: urgeSessionId.present ? urgeSessionId.value : this.urgeSessionId,
    perceivedEffect: perceivedEffect.present ? perceivedEffect.value : this.perceivedEffect,
  );
  CopingStrategyUse copyWithCompanion(CopingStrategyUsesCompanion data) {
    return CopingStrategyUse(
      id: data.id.present ? data.id.value : this.id,
      strategyId: data.strategyId.present ? data.strategyId.value : this.strategyId,
      usedAt: data.usedAt.present ? data.usedAt.value : this.usedAt,
      urgeSessionId: data.urgeSessionId.present ? data.urgeSessionId.value : this.urgeSessionId,
      perceivedEffect: data.perceivedEffect.present ? data.perceivedEffect.value : this.perceivedEffect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CopingStrategyUse(')
          ..write('id: $id, ')
          ..write('strategyId: $strategyId, ')
          ..write('usedAt: $usedAt, ')
          ..write('urgeSessionId: $urgeSessionId, ')
          ..write('perceivedEffect: $perceivedEffect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, strategyId, usedAt, urgeSessionId, perceivedEffect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CopingStrategyUse &&
          other.id == this.id &&
          other.strategyId == this.strategyId &&
          other.usedAt == this.usedAt &&
          other.urgeSessionId == this.urgeSessionId &&
          other.perceivedEffect == this.perceivedEffect);
}

class CopingStrategyUsesCompanion extends UpdateCompanion<CopingStrategyUse> {
  final Value<String> id;
  final Value<String> strategyId;
  final Value<DateTime> usedAt;
  final Value<String?> urgeSessionId;
  final Value<int?> perceivedEffect;
  final Value<int> rowid;
  const CopingStrategyUsesCompanion({
    this.id = const Value.absent(),
    this.strategyId = const Value.absent(),
    this.usedAt = const Value.absent(),
    this.urgeSessionId = const Value.absent(),
    this.perceivedEffect = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CopingStrategyUsesCompanion.insert({
    required String id,
    required String strategyId,
    required DateTime usedAt,
    this.urgeSessionId = const Value.absent(),
    this.perceivedEffect = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       strategyId = Value(strategyId),
       usedAt = Value(usedAt);
  static Insertable<CopingStrategyUse> custom({
    Expression<String>? id,
    Expression<String>? strategyId,
    Expression<DateTime>? usedAt,
    Expression<String>? urgeSessionId,
    Expression<int>? perceivedEffect,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (strategyId != null) 'strategy_id': strategyId,
      if (usedAt != null) 'used_at': usedAt,
      if (urgeSessionId != null) 'urge_session_id': urgeSessionId,
      if (perceivedEffect != null) 'perceived_effect': perceivedEffect,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CopingStrategyUsesCompanion copyWith({
    Value<String>? id,
    Value<String>? strategyId,
    Value<DateTime>? usedAt,
    Value<String?>? urgeSessionId,
    Value<int?>? perceivedEffect,
    Value<int>? rowid,
  }) {
    return CopingStrategyUsesCompanion(
      id: id ?? this.id,
      strategyId: strategyId ?? this.strategyId,
      usedAt: usedAt ?? this.usedAt,
      urgeSessionId: urgeSessionId ?? this.urgeSessionId,
      perceivedEffect: perceivedEffect ?? this.perceivedEffect,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (strategyId.present) {
      map['strategy_id'] = Variable<String>(strategyId.value);
    }
    if (usedAt.present) {
      map['used_at'] = Variable<DateTime>(usedAt.value);
    }
    if (urgeSessionId.present) {
      map['urge_session_id'] = Variable<String>(urgeSessionId.value);
    }
    if (perceivedEffect.present) {
      map['perceived_effect'] = Variable<int>(perceivedEffect.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CopingStrategyUsesCompanion(')
          ..write('id: $id, ')
          ..write('strategyId: $strategyId, ')
          ..write('usedAt: $usedAt, ')
          ..write('urgeSessionId: $urgeSessionId, ')
          ..write('perceivedEffect: $perceivedEffect, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ModuleProgressTable extends ModuleProgress with TableInfo<$ModuleProgressTable, ModuleProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModuleProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _moduleIdMeta = const VerificationMeta(
    'moduleId',
  );
  @override
  late final GeneratedColumn<String> moduleId = GeneratedColumn<String>(
    'module_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSectionIndexMeta = const VerificationMeta(
    'lastSectionIndex',
  );
  @override
  late final GeneratedColumn<int> lastSectionIndex = GeneratedColumn<int>(
    'last_section_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isReviewingMeta = const VerificationMeta(
    'isReviewing',
  );
  @override
  late final GeneratedColumn<bool> isReviewing = GeneratedColumn<bool>(
    'is_reviewing',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_reviewing" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reflectionTextMeta = const VerificationMeta(
    'reflectionText',
  );
  @override
  late final GeneratedColumn<String> reflectionText = GeneratedColumn<String>(
    'reflection_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    moduleId,
    startedAt,
    completedAt,
    lastSectionIndex,
    isReviewing,
    reflectionText,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'module_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ModuleProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('module_id')) {
      context.handle(
        _moduleIdMeta,
        moduleId.isAcceptableOrUnknown(data['module_id']!, _moduleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moduleIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_section_index')) {
      context.handle(
        _lastSectionIndexMeta,
        lastSectionIndex.isAcceptableOrUnknown(
          data['last_section_index']!,
          _lastSectionIndexMeta,
        ),
      );
    }
    if (data.containsKey('is_reviewing')) {
      context.handle(
        _isReviewingMeta,
        isReviewing.isAcceptableOrUnknown(
          data['is_reviewing']!,
          _isReviewingMeta,
        ),
      );
    }
    if (data.containsKey('reflection_text')) {
      context.handle(
        _reflectionTextMeta,
        reflectionText.isAcceptableOrUnknown(
          data['reflection_text']!,
          _reflectionTextMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {moduleId};
  @override
  ModuleProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModuleProgressData(
      moduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}module_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      lastSectionIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_section_index'],
      )!,
      isReviewing: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_reviewing'],
      )!,
      reflectionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reflection_text'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ModuleProgressTable createAlias(String alias) {
    return $ModuleProgressTable(attachedDatabase, alias);
  }
}

class ModuleProgressData extends DataClass implements Insertable<ModuleProgressData> {
  /// Identifier matching a module in the bundled learning catalog.
  final String moduleId;

  /// UTC timestamp at which the module was first opened.
  final DateTime? startedAt;

  /// UTC timestamp at which the module was completed.
  final DateTime? completedAt;

  /// Zero-based last section reached by the user.
  final int lastSectionIndex;

  /// Whether a completed module is currently being read again.
  final bool isReviewing;

  /// Optional private reflection saved for the module.
  final String? reflectionText;

  /// UTC timestamp of the latest progress update.
  final DateTime updatedAt;
  const ModuleProgressData({
    required this.moduleId,
    this.startedAt,
    this.completedAt,
    required this.lastSectionIndex,
    required this.isReviewing,
    this.reflectionText,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['module_id'] = Variable<String>(moduleId);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['last_section_index'] = Variable<int>(lastSectionIndex);
    map['is_reviewing'] = Variable<bool>(isReviewing);
    if (!nullToAbsent || reflectionText != null) {
      map['reflection_text'] = Variable<String>(reflectionText);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ModuleProgressCompanion toCompanion(bool nullToAbsent) {
    return ModuleProgressCompanion(
      moduleId: Value(moduleId),
      startedAt: startedAt == null && nullToAbsent ? const Value.absent() : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent ? const Value.absent() : Value(completedAt),
      lastSectionIndex: Value(lastSectionIndex),
      isReviewing: Value(isReviewing),
      reflectionText: reflectionText == null && nullToAbsent ? const Value.absent() : Value(reflectionText),
      updatedAt: Value(updatedAt),
    );
  }

  factory ModuleProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModuleProgressData(
      moduleId: serializer.fromJson<String>(json['moduleId']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      lastSectionIndex: serializer.fromJson<int>(json['lastSectionIndex']),
      isReviewing: serializer.fromJson<bool>(json['isReviewing']),
      reflectionText: serializer.fromJson<String?>(json['reflectionText']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'moduleId': serializer.toJson<String>(moduleId),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'lastSectionIndex': serializer.toJson<int>(lastSectionIndex),
      'isReviewing': serializer.toJson<bool>(isReviewing),
      'reflectionText': serializer.toJson<String?>(reflectionText),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ModuleProgressData copyWith({
    String? moduleId,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    int? lastSectionIndex,
    bool? isReviewing,
    Value<String?> reflectionText = const Value.absent(),
    DateTime? updatedAt,
  }) => ModuleProgressData(
    moduleId: moduleId ?? this.moduleId,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    lastSectionIndex: lastSectionIndex ?? this.lastSectionIndex,
    isReviewing: isReviewing ?? this.isReviewing,
    reflectionText: reflectionText.present ? reflectionText.value : this.reflectionText,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ModuleProgressData copyWithCompanion(ModuleProgressCompanion data) {
    return ModuleProgressData(
      moduleId: data.moduleId.present ? data.moduleId.value : this.moduleId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present ? data.completedAt.value : this.completedAt,
      lastSectionIndex: data.lastSectionIndex.present ? data.lastSectionIndex.value : this.lastSectionIndex,
      isReviewing: data.isReviewing.present ? data.isReviewing.value : this.isReviewing,
      reflectionText: data.reflectionText.present ? data.reflectionText.value : this.reflectionText,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ModuleProgressData(')
          ..write('moduleId: $moduleId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('lastSectionIndex: $lastSectionIndex, ')
          ..write('isReviewing: $isReviewing, ')
          ..write('reflectionText: $reflectionText, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    moduleId,
    startedAt,
    completedAt,
    lastSectionIndex,
    isReviewing,
    reflectionText,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModuleProgressData &&
          other.moduleId == this.moduleId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.lastSectionIndex == this.lastSectionIndex &&
          other.isReviewing == this.isReviewing &&
          other.reflectionText == this.reflectionText &&
          other.updatedAt == this.updatedAt);
}

class ModuleProgressCompanion extends UpdateCompanion<ModuleProgressData> {
  final Value<String> moduleId;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> lastSectionIndex;
  final Value<bool> isReviewing;
  final Value<String?> reflectionText;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ModuleProgressCompanion({
    this.moduleId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.lastSectionIndex = const Value.absent(),
    this.isReviewing = const Value.absent(),
    this.reflectionText = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ModuleProgressCompanion.insert({
    required String moduleId,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.lastSectionIndex = const Value.absent(),
    this.isReviewing = const Value.absent(),
    this.reflectionText = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : moduleId = Value(moduleId),
       updatedAt = Value(updatedAt);
  static Insertable<ModuleProgressData> custom({
    Expression<String>? moduleId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? lastSectionIndex,
    Expression<bool>? isReviewing,
    Expression<String>? reflectionText,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (moduleId != null) 'module_id': moduleId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (lastSectionIndex != null) 'last_section_index': lastSectionIndex,
      if (isReviewing != null) 'is_reviewing': isReviewing,
      if (reflectionText != null) 'reflection_text': reflectionText,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ModuleProgressCompanion copyWith({
    Value<String>? moduleId,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<int>? lastSectionIndex,
    Value<bool>? isReviewing,
    Value<String?>? reflectionText,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ModuleProgressCompanion(
      moduleId: moduleId ?? this.moduleId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      lastSectionIndex: lastSectionIndex ?? this.lastSectionIndex,
      isReviewing: isReviewing ?? this.isReviewing,
      reflectionText: reflectionText ?? this.reflectionText,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (moduleId.present) {
      map['module_id'] = Variable<String>(moduleId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (lastSectionIndex.present) {
      map['last_section_index'] = Variable<int>(lastSectionIndex.value);
    }
    if (isReviewing.present) {
      map['is_reviewing'] = Variable<bool>(isReviewing.value);
    }
    if (reflectionText.present) {
      map['reflection_text'] = Variable<String>(reflectionText.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModuleProgressCompanion(')
          ..write('moduleId: $moduleId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('lastSectionIndex: $lastSectionIndex, ')
          ..write('isReviewing: $isReviewing, ')
          ..write('reflectionText: $reflectionText, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OnboardingDraftsTable extends OnboardingDrafts with TableInfo<$OnboardingDraftsTable, OnboardingDraftRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OnboardingDraftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assessmentIdMeta = const VerificationMeta(
    'assessmentId',
  );
  @override
  late final GeneratedColumn<String> assessmentId = GeneratedColumn<String>(
    'assessment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentStepMeta = const VerificationMeta(
    'currentStep',
  );
  @override
  late final GeneratedColumn<int> currentStep = GeneratedColumn<int>(
    'current_step',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goalTypeMeta = const VerificationMeta(
    'goalType',
  );
  @override
  late final GeneratedColumn<String> goalType = GeneratedColumn<String>(
    'goal_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weeklyLimitMeta = const VerificationMeta(
    'weeklyLimit',
  );
  @override
  late final GeneratedColumn<int> weeklyLimit = GeneratedColumn<int>(
    'weekly_limit',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contextKeysJsonMeta = const VerificationMeta(
    'contextKeysJson',
  );
  @override
  late final GeneratedColumn<String> contextKeysJson = GeneratedColumn<String>(
    'context_keys_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _motivationMeta = const VerificationMeta(
    'motivation',
  );
  @override
  late final GeneratedColumn<String> motivation = GeneratedColumn<String>(
    'motivation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _baselineFrequencyMeta = const VerificationMeta(
    'baselineFrequency',
  );
  @override
  late final GeneratedColumn<int> baselineFrequency = GeneratedColumn<int>(
    'baseline_frequency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _perceivedControlMeta = const VerificationMeta(
    'perceivedControl',
  );
  @override
  late final GeneratedColumn<int> perceivedControl = GeneratedColumn<int>(
    'perceived_control',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _negativeImpactMeta = const VerificationMeta(
    'negativeImpact',
  );
  @override
  late final GeneratedColumn<int> negativeImpact = GeneratedColumn<int>(
    'negative_impact',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _confidenceToChangeMeta = const VerificationMeta('confidenceToChange');
  @override
  late final GeneratedColumn<int> confidenceToChange = GeneratedColumn<int>(
    'confidence_to_change',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _strategyIdsJsonMeta = const VerificationMeta(
    'strategyIdsJson',
  );
  @override
  late final GeneratedColumn<String> strategyIdsJson = GeneratedColumn<String>(
    'strategy_ids_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyCheckInReminderEnabledMeta = const VerificationMeta('dailyCheckInReminderEnabled');
  @override
  late final GeneratedColumn<bool> dailyCheckInReminderEnabled = GeneratedColumn<bool>(
    'daily_check_in_reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("daily_check_in_reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    goalId,
    assessmentId,
    currentStep,
    goalType,
    weeklyLimit,
    contextKeysJson,
    motivation,
    baselineFrequency,
    perceivedControl,
    negativeImpact,
    confidenceToChange,
    strategyIdsJson,
    dailyCheckInReminderEnabled,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'onboarding_drafts';
  @override
  VerificationContext validateIntegrity(
    Insertable<OnboardingDraftRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('assessment_id')) {
      context.handle(
        _assessmentIdMeta,
        assessmentId.isAcceptableOrUnknown(
          data['assessment_id']!,
          _assessmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_assessmentIdMeta);
    }
    if (data.containsKey('current_step')) {
      context.handle(
        _currentStepMeta,
        currentStep.isAcceptableOrUnknown(
          data['current_step']!,
          _currentStepMeta,
        ),
      );
    }
    if (data.containsKey('goal_type')) {
      context.handle(
        _goalTypeMeta,
        goalType.isAcceptableOrUnknown(data['goal_type']!, _goalTypeMeta),
      );
    }
    if (data.containsKey('weekly_limit')) {
      context.handle(
        _weeklyLimitMeta,
        weeklyLimit.isAcceptableOrUnknown(
          data['weekly_limit']!,
          _weeklyLimitMeta,
        ),
      );
    }
    if (data.containsKey('context_keys_json')) {
      context.handle(
        _contextKeysJsonMeta,
        contextKeysJson.isAcceptableOrUnknown(
          data['context_keys_json']!,
          _contextKeysJsonMeta,
        ),
      );
    }
    if (data.containsKey('motivation')) {
      context.handle(
        _motivationMeta,
        motivation.isAcceptableOrUnknown(data['motivation']!, _motivationMeta),
      );
    }
    if (data.containsKey('baseline_frequency')) {
      context.handle(
        _baselineFrequencyMeta,
        baselineFrequency.isAcceptableOrUnknown(
          data['baseline_frequency']!,
          _baselineFrequencyMeta,
        ),
      );
    }
    if (data.containsKey('perceived_control')) {
      context.handle(
        _perceivedControlMeta,
        perceivedControl.isAcceptableOrUnknown(
          data['perceived_control']!,
          _perceivedControlMeta,
        ),
      );
    }
    if (data.containsKey('negative_impact')) {
      context.handle(
        _negativeImpactMeta,
        negativeImpact.isAcceptableOrUnknown(
          data['negative_impact']!,
          _negativeImpactMeta,
        ),
      );
    }
    if (data.containsKey('confidence_to_change')) {
      context.handle(
        _confidenceToChangeMeta,
        confidenceToChange.isAcceptableOrUnknown(
          data['confidence_to_change']!,
          _confidenceToChangeMeta,
        ),
      );
    }
    if (data.containsKey('strategy_ids_json')) {
      context.handle(
        _strategyIdsJsonMeta,
        strategyIdsJson.isAcceptableOrUnknown(
          data['strategy_ids_json']!,
          _strategyIdsJsonMeta,
        ),
      );
    }
    if (data.containsKey('daily_check_in_reminder_enabled')) {
      context.handle(
        _dailyCheckInReminderEnabledMeta,
        dailyCheckInReminderEnabled.isAcceptableOrUnknown(
          data['daily_check_in_reminder_enabled']!,
          _dailyCheckInReminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OnboardingDraftRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OnboardingDraftRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      )!,
      assessmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assessment_id'],
      )!,
      currentStep: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_step'],
      )!,
      goalType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_type'],
      ),
      weeklyLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_limit'],
      ),
      contextKeysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_keys_json'],
      ),
      motivation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivation'],
      ),
      baselineFrequency: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baseline_frequency'],
      )!,
      perceivedControl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}perceived_control'],
      )!,
      negativeImpact: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}negative_impact'],
      )!,
      confidenceToChange: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confidence_to_change'],
      )!,
      strategyIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}strategy_ids_json'],
      ),
      dailyCheckInReminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}daily_check_in_reminder_enabled'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OnboardingDraftsTable createAlias(String alias) {
    return $OnboardingDraftsTable(attachedDatabase, alias);
  }
}

class OnboardingDraftRecord extends DataClass implements Insertable<OnboardingDraftRecord> {
  /// Singleton draft identifier.
  final String id;

  /// UUID reserved for the goal created on completion.
  final String goalId;

  /// UUID reserved for the baseline assessment.
  final String assessmentId;

  /// Zero-based onboarding step last persisted.
  final int currentStep;

  /// Optional persisted [GoalType] name.
  final String? goalType;

  /// Optional weekly limit for a reduction goal.
  final int? weeklyLimit;

  /// JSON array of selected contextual-goal keys.
  final String? contextKeysJson;

  /// Optional user-written motivation.
  final String? motivation;

  /// Approximate baseline frequency over seven days.
  final int baselineFrequency;

  /// Baseline perceived-control score.
  final int perceivedControl;

  /// Baseline negative-impact score.
  final int negativeImpact;

  /// Baseline confidence-to-change score.
  final int confidenceToChange;

  /// JSON array of selected coping-strategy identifiers.
  final String? strategyIdsJson;

  /// Whether the user opted into the local daily check-in reminder.
  final bool dailyCheckInReminderEnabled;

  /// UTC timestamp of the latest draft update.
  final DateTime updatedAt;
  const OnboardingDraftRecord({
    required this.id,
    required this.goalId,
    required this.assessmentId,
    required this.currentStep,
    this.goalType,
    this.weeklyLimit,
    this.contextKeysJson,
    this.motivation,
    required this.baselineFrequency,
    required this.perceivedControl,
    required this.negativeImpact,
    required this.confidenceToChange,
    this.strategyIdsJson,
    required this.dailyCheckInReminderEnabled,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['goal_id'] = Variable<String>(goalId);
    map['assessment_id'] = Variable<String>(assessmentId);
    map['current_step'] = Variable<int>(currentStep);
    if (!nullToAbsent || goalType != null) {
      map['goal_type'] = Variable<String>(goalType);
    }
    if (!nullToAbsent || weeklyLimit != null) {
      map['weekly_limit'] = Variable<int>(weeklyLimit);
    }
    if (!nullToAbsent || contextKeysJson != null) {
      map['context_keys_json'] = Variable<String>(contextKeysJson);
    }
    if (!nullToAbsent || motivation != null) {
      map['motivation'] = Variable<String>(motivation);
    }
    map['baseline_frequency'] = Variable<int>(baselineFrequency);
    map['perceived_control'] = Variable<int>(perceivedControl);
    map['negative_impact'] = Variable<int>(negativeImpact);
    map['confidence_to_change'] = Variable<int>(confidenceToChange);
    if (!nullToAbsent || strategyIdsJson != null) {
      map['strategy_ids_json'] = Variable<String>(strategyIdsJson);
    }
    map['daily_check_in_reminder_enabled'] = Variable<bool>(
      dailyCheckInReminderEnabled,
    );
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OnboardingDraftsCompanion toCompanion(bool nullToAbsent) {
    return OnboardingDraftsCompanion(
      id: Value(id),
      goalId: Value(goalId),
      assessmentId: Value(assessmentId),
      currentStep: Value(currentStep),
      goalType: goalType == null && nullToAbsent ? const Value.absent() : Value(goalType),
      weeklyLimit: weeklyLimit == null && nullToAbsent ? const Value.absent() : Value(weeklyLimit),
      contextKeysJson: contextKeysJson == null && nullToAbsent ? const Value.absent() : Value(contextKeysJson),
      motivation: motivation == null && nullToAbsent ? const Value.absent() : Value(motivation),
      baselineFrequency: Value(baselineFrequency),
      perceivedControl: Value(perceivedControl),
      negativeImpact: Value(negativeImpact),
      confidenceToChange: Value(confidenceToChange),
      strategyIdsJson: strategyIdsJson == null && nullToAbsent ? const Value.absent() : Value(strategyIdsJson),
      dailyCheckInReminderEnabled: Value(dailyCheckInReminderEnabled),
      updatedAt: Value(updatedAt),
    );
  }

  factory OnboardingDraftRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OnboardingDraftRecord(
      id: serializer.fromJson<String>(json['id']),
      goalId: serializer.fromJson<String>(json['goalId']),
      assessmentId: serializer.fromJson<String>(json['assessmentId']),
      currentStep: serializer.fromJson<int>(json['currentStep']),
      goalType: serializer.fromJson<String?>(json['goalType']),
      weeklyLimit: serializer.fromJson<int?>(json['weeklyLimit']),
      contextKeysJson: serializer.fromJson<String?>(json['contextKeysJson']),
      motivation: serializer.fromJson<String?>(json['motivation']),
      baselineFrequency: serializer.fromJson<int>(json['baselineFrequency']),
      perceivedControl: serializer.fromJson<int>(json['perceivedControl']),
      negativeImpact: serializer.fromJson<int>(json['negativeImpact']),
      confidenceToChange: serializer.fromJson<int>(json['confidenceToChange']),
      strategyIdsJson: serializer.fromJson<String?>(json['strategyIdsJson']),
      dailyCheckInReminderEnabled: serializer.fromJson<bool>(
        json['dailyCheckInReminderEnabled'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'goalId': serializer.toJson<String>(goalId),
      'assessmentId': serializer.toJson<String>(assessmentId),
      'currentStep': serializer.toJson<int>(currentStep),
      'goalType': serializer.toJson<String?>(goalType),
      'weeklyLimit': serializer.toJson<int?>(weeklyLimit),
      'contextKeysJson': serializer.toJson<String?>(contextKeysJson),
      'motivation': serializer.toJson<String?>(motivation),
      'baselineFrequency': serializer.toJson<int>(baselineFrequency),
      'perceivedControl': serializer.toJson<int>(perceivedControl),
      'negativeImpact': serializer.toJson<int>(negativeImpact),
      'confidenceToChange': serializer.toJson<int>(confidenceToChange),
      'strategyIdsJson': serializer.toJson<String?>(strategyIdsJson),
      'dailyCheckInReminderEnabled': serializer.toJson<bool>(
        dailyCheckInReminderEnabled,
      ),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OnboardingDraftRecord copyWith({
    String? id,
    String? goalId,
    String? assessmentId,
    int? currentStep,
    Value<String?> goalType = const Value.absent(),
    Value<int?> weeklyLimit = const Value.absent(),
    Value<String?> contextKeysJson = const Value.absent(),
    Value<String?> motivation = const Value.absent(),
    int? baselineFrequency,
    int? perceivedControl,
    int? negativeImpact,
    int? confidenceToChange,
    Value<String?> strategyIdsJson = const Value.absent(),
    bool? dailyCheckInReminderEnabled,
    DateTime? updatedAt,
  }) => OnboardingDraftRecord(
    id: id ?? this.id,
    goalId: goalId ?? this.goalId,
    assessmentId: assessmentId ?? this.assessmentId,
    currentStep: currentStep ?? this.currentStep,
    goalType: goalType.present ? goalType.value : this.goalType,
    weeklyLimit: weeklyLimit.present ? weeklyLimit.value : this.weeklyLimit,
    contextKeysJson: contextKeysJson.present ? contextKeysJson.value : this.contextKeysJson,
    motivation: motivation.present ? motivation.value : this.motivation,
    baselineFrequency: baselineFrequency ?? this.baselineFrequency,
    perceivedControl: perceivedControl ?? this.perceivedControl,
    negativeImpact: negativeImpact ?? this.negativeImpact,
    confidenceToChange: confidenceToChange ?? this.confidenceToChange,
    strategyIdsJson: strategyIdsJson.present ? strategyIdsJson.value : this.strategyIdsJson,
    dailyCheckInReminderEnabled: dailyCheckInReminderEnabled ?? this.dailyCheckInReminderEnabled,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  OnboardingDraftRecord copyWithCompanion(OnboardingDraftsCompanion data) {
    return OnboardingDraftRecord(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      assessmentId: data.assessmentId.present ? data.assessmentId.value : this.assessmentId,
      currentStep: data.currentStep.present ? data.currentStep.value : this.currentStep,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      weeklyLimit: data.weeklyLimit.present ? data.weeklyLimit.value : this.weeklyLimit,
      contextKeysJson: data.contextKeysJson.present ? data.contextKeysJson.value : this.contextKeysJson,
      motivation: data.motivation.present ? data.motivation.value : this.motivation,
      baselineFrequency: data.baselineFrequency.present ? data.baselineFrequency.value : this.baselineFrequency,
      perceivedControl: data.perceivedControl.present ? data.perceivedControl.value : this.perceivedControl,
      negativeImpact: data.negativeImpact.present ? data.negativeImpact.value : this.negativeImpact,
      confidenceToChange: data.confidenceToChange.present ? data.confidenceToChange.value : this.confidenceToChange,
      strategyIdsJson: data.strategyIdsJson.present ? data.strategyIdsJson.value : this.strategyIdsJson,
      dailyCheckInReminderEnabled: data.dailyCheckInReminderEnabled.present ? data.dailyCheckInReminderEnabled.value : this.dailyCheckInReminderEnabled,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OnboardingDraftRecord(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('assessmentId: $assessmentId, ')
          ..write('currentStep: $currentStep, ')
          ..write('goalType: $goalType, ')
          ..write('weeklyLimit: $weeklyLimit, ')
          ..write('contextKeysJson: $contextKeysJson, ')
          ..write('motivation: $motivation, ')
          ..write('baselineFrequency: $baselineFrequency, ')
          ..write('perceivedControl: $perceivedControl, ')
          ..write('negativeImpact: $negativeImpact, ')
          ..write('confidenceToChange: $confidenceToChange, ')
          ..write('strategyIdsJson: $strategyIdsJson, ')
          ..write('dailyCheckInReminderEnabled: $dailyCheckInReminderEnabled, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    goalId,
    assessmentId,
    currentStep,
    goalType,
    weeklyLimit,
    contextKeysJson,
    motivation,
    baselineFrequency,
    perceivedControl,
    negativeImpact,
    confidenceToChange,
    strategyIdsJson,
    dailyCheckInReminderEnabled,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OnboardingDraftRecord &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.assessmentId == this.assessmentId &&
          other.currentStep == this.currentStep &&
          other.goalType == this.goalType &&
          other.weeklyLimit == this.weeklyLimit &&
          other.contextKeysJson == this.contextKeysJson &&
          other.motivation == this.motivation &&
          other.baselineFrequency == this.baselineFrequency &&
          other.perceivedControl == this.perceivedControl &&
          other.negativeImpact == this.negativeImpact &&
          other.confidenceToChange == this.confidenceToChange &&
          other.strategyIdsJson == this.strategyIdsJson &&
          other.dailyCheckInReminderEnabled == this.dailyCheckInReminderEnabled &&
          other.updatedAt == this.updatedAt);
}

class OnboardingDraftsCompanion extends UpdateCompanion<OnboardingDraftRecord> {
  final Value<String> id;
  final Value<String> goalId;
  final Value<String> assessmentId;
  final Value<int> currentStep;
  final Value<String?> goalType;
  final Value<int?> weeklyLimit;
  final Value<String?> contextKeysJson;
  final Value<String?> motivation;
  final Value<int> baselineFrequency;
  final Value<int> perceivedControl;
  final Value<int> negativeImpact;
  final Value<int> confidenceToChange;
  final Value<String?> strategyIdsJson;
  final Value<bool> dailyCheckInReminderEnabled;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const OnboardingDraftsCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.assessmentId = const Value.absent(),
    this.currentStep = const Value.absent(),
    this.goalType = const Value.absent(),
    this.weeklyLimit = const Value.absent(),
    this.contextKeysJson = const Value.absent(),
    this.motivation = const Value.absent(),
    this.baselineFrequency = const Value.absent(),
    this.perceivedControl = const Value.absent(),
    this.negativeImpact = const Value.absent(),
    this.confidenceToChange = const Value.absent(),
    this.strategyIdsJson = const Value.absent(),
    this.dailyCheckInReminderEnabled = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OnboardingDraftsCompanion.insert({
    required String id,
    required String goalId,
    required String assessmentId,
    this.currentStep = const Value.absent(),
    this.goalType = const Value.absent(),
    this.weeklyLimit = const Value.absent(),
    this.contextKeysJson = const Value.absent(),
    this.motivation = const Value.absent(),
    this.baselineFrequency = const Value.absent(),
    this.perceivedControl = const Value.absent(),
    this.negativeImpact = const Value.absent(),
    this.confidenceToChange = const Value.absent(),
    this.strategyIdsJson = const Value.absent(),
    this.dailyCheckInReminderEnabled = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       goalId = Value(goalId),
       assessmentId = Value(assessmentId),
       updatedAt = Value(updatedAt);
  static Insertable<OnboardingDraftRecord> custom({
    Expression<String>? id,
    Expression<String>? goalId,
    Expression<String>? assessmentId,
    Expression<int>? currentStep,
    Expression<String>? goalType,
    Expression<int>? weeklyLimit,
    Expression<String>? contextKeysJson,
    Expression<String>? motivation,
    Expression<int>? baselineFrequency,
    Expression<int>? perceivedControl,
    Expression<int>? negativeImpact,
    Expression<int>? confidenceToChange,
    Expression<String>? strategyIdsJson,
    Expression<bool>? dailyCheckInReminderEnabled,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (assessmentId != null) 'assessment_id': assessmentId,
      if (currentStep != null) 'current_step': currentStep,
      if (goalType != null) 'goal_type': goalType,
      if (weeklyLimit != null) 'weekly_limit': weeklyLimit,
      if (contextKeysJson != null) 'context_keys_json': contextKeysJson,
      if (motivation != null) 'motivation': motivation,
      if (baselineFrequency != null) 'baseline_frequency': baselineFrequency,
      if (perceivedControl != null) 'perceived_control': perceivedControl,
      if (negativeImpact != null) 'negative_impact': negativeImpact,
      if (confidenceToChange != null) 'confidence_to_change': confidenceToChange,
      if (strategyIdsJson != null) 'strategy_ids_json': strategyIdsJson,
      if (dailyCheckInReminderEnabled != null) 'daily_check_in_reminder_enabled': dailyCheckInReminderEnabled,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OnboardingDraftsCompanion copyWith({
    Value<String>? id,
    Value<String>? goalId,
    Value<String>? assessmentId,
    Value<int>? currentStep,
    Value<String?>? goalType,
    Value<int?>? weeklyLimit,
    Value<String?>? contextKeysJson,
    Value<String?>? motivation,
    Value<int>? baselineFrequency,
    Value<int>? perceivedControl,
    Value<int>? negativeImpact,
    Value<int>? confidenceToChange,
    Value<String?>? strategyIdsJson,
    Value<bool>? dailyCheckInReminderEnabled,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return OnboardingDraftsCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      assessmentId: assessmentId ?? this.assessmentId,
      currentStep: currentStep ?? this.currentStep,
      goalType: goalType ?? this.goalType,
      weeklyLimit: weeklyLimit ?? this.weeklyLimit,
      contextKeysJson: contextKeysJson ?? this.contextKeysJson,
      motivation: motivation ?? this.motivation,
      baselineFrequency: baselineFrequency ?? this.baselineFrequency,
      perceivedControl: perceivedControl ?? this.perceivedControl,
      negativeImpact: negativeImpact ?? this.negativeImpact,
      confidenceToChange: confidenceToChange ?? this.confidenceToChange,
      strategyIdsJson: strategyIdsJson ?? this.strategyIdsJson,
      dailyCheckInReminderEnabled: dailyCheckInReminderEnabled ?? this.dailyCheckInReminderEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (assessmentId.present) {
      map['assessment_id'] = Variable<String>(assessmentId.value);
    }
    if (currentStep.present) {
      map['current_step'] = Variable<int>(currentStep.value);
    }
    if (goalType.present) {
      map['goal_type'] = Variable<String>(goalType.value);
    }
    if (weeklyLimit.present) {
      map['weekly_limit'] = Variable<int>(weeklyLimit.value);
    }
    if (contextKeysJson.present) {
      map['context_keys_json'] = Variable<String>(contextKeysJson.value);
    }
    if (motivation.present) {
      map['motivation'] = Variable<String>(motivation.value);
    }
    if (baselineFrequency.present) {
      map['baseline_frequency'] = Variable<int>(baselineFrequency.value);
    }
    if (perceivedControl.present) {
      map['perceived_control'] = Variable<int>(perceivedControl.value);
    }
    if (negativeImpact.present) {
      map['negative_impact'] = Variable<int>(negativeImpact.value);
    }
    if (confidenceToChange.present) {
      map['confidence_to_change'] = Variable<int>(confidenceToChange.value);
    }
    if (strategyIdsJson.present) {
      map['strategy_ids_json'] = Variable<String>(strategyIdsJson.value);
    }
    if (dailyCheckInReminderEnabled.present) {
      map['daily_check_in_reminder_enabled'] = Variable<bool>(
        dailyCheckInReminderEnabled.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OnboardingDraftsCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('assessmentId: $assessmentId, ')
          ..write('currentStep: $currentStep, ')
          ..write('goalType: $goalType, ')
          ..write('weeklyLimit: $weeklyLimit, ')
          ..write('contextKeysJson: $contextKeysJson, ')
          ..write('motivation: $motivation, ')
          ..write('baselineFrequency: $baselineFrequency, ')
          ..write('perceivedControl: $perceivedControl, ')
          ..write('negativeImpact: $negativeImpact, ')
          ..write('confidenceToChange: $confidenceToChange, ')
          ..write('strategyIdsJson: $strategyIdsJson, ')
          ..write('dailyCheckInReminderEnabled: $dailyCheckInReminderEnabled, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $CopingStrategiesTable copingStrategies = $CopingStrategiesTable(
    this,
  );
  late final $UrgeSessionsTable urgeSessions = $UrgeSessionsTable(this);
  late final $ConsumptionEventsTable consumptionEvents = $ConsumptionEventsTable(this);
  late final $DailyCheckInsTable dailyCheckIns = $DailyCheckInsTable(this);
  late final $SelfAssessmentsTable selfAssessments = $SelfAssessmentsTable(
    this,
  );
  late final $CopingStrategyUsesTable copingStrategyUses = $CopingStrategyUsesTable(this);
  late final $ModuleProgressTable moduleProgress = $ModuleProgressTable(this);
  late final $OnboardingDraftsTable onboardingDrafts = $OnboardingDraftsTable(
    this,
  );
  late final Index urgeSessionsStartedAt = Index(
    'urge_sessions_started_at',
    'CREATE INDEX urge_sessions_started_at ON urge_sessions (started_at)',
  );
  late final Index consumptionEventsOccurredAt = Index(
    'consumption_events_occurred_at',
    'CREATE INDEX consumption_events_occurred_at ON consumption_events (occurred_at)',
  );
  late final Index selfAssessmentsRecordedAt = Index(
    'self_assessments_recorded_at',
    'CREATE INDEX self_assessments_recorded_at ON self_assessments (recorded_at)',
  );
  late final Index copingStrategyUsesStrategyId = Index(
    'coping_strategy_uses_strategy_id',
    'CREATE INDEX coping_strategy_uses_strategy_id ON coping_strategy_uses (strategy_id)',
  );
  late final Index copingStrategyUsesUsedAt = Index(
    'coping_strategy_uses_used_at',
    'CREATE INDEX coping_strategy_uses_used_at ON coping_strategy_uses (used_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    goals,
    copingStrategies,
    urgeSessions,
    consumptionEvents,
    dailyCheckIns,
    selfAssessments,
    copingStrategyUses,
    moduleProgress,
    onboardingDrafts,
    urgeSessionsStartedAt,
    consumptionEventsOccurredAt,
    selfAssessmentsRecordedAt,
    copingStrategyUsesStrategyId,
    copingStrategyUsesUsedAt,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coping_strategies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('urge_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'urge_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('consumption_events', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coping_strategies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coping_strategy_uses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'urge_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coping_strategy_uses', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$GoalsTableCreateCompanionBuilder =
    GoalsCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String type,
      Value<bool> isActive,
      Value<int?> weeklyLimit,
      Value<String?> contextKeysJson,
      Value<String?> motivation,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<int> rowid,
    });
typedef $$GoalsTableUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> type,
      Value<bool> isActive,
      Value<int?> weeklyLimit,
      Value<String?> contextKeysJson,
      Value<String?> motivation,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> rowid,
    });

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyLimit => $composableBuilder(
    column: $table.weeklyLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextKeysJson => $composableBuilder(
    column: $table.contextKeysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivation => $composableBuilder(
    column: $table.motivation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalsTableOrderingComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyLimit => $composableBuilder(
    column: $table.weeklyLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextKeysJson => $composableBuilder(
    column: $table.contextKeysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivation => $composableBuilder(
    column: $table.motivation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get type => $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isActive => $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get weeklyLimit => $composableBuilder(
    column: $table.weeklyLimit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contextKeysJson => $composableBuilder(
    column: $table.contextKeysJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get motivation => $composableBuilder(
    column: $table.motivation,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt => $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt => $composableBuilder(column: $table.endedAt, builder: (column) => column);
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          Goal,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
          Goal,
          PrefetchHooks Function()
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> weeklyLimit = const Value.absent(),
                Value<String?> contextKeysJson = const Value.absent(),
                Value<String?> motivation = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                type: type,
                isActive: isActive,
                weeklyLimit: weeklyLimit,
                contextKeysJson: contextKeysJson,
                motivation: motivation,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                required String type,
                Value<bool> isActive = const Value.absent(),
                Value<int?> weeklyLimit = const Value.absent(),
                Value<String?> contextKeysJson = const Value.absent(),
                Value<String?> motivation = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                type: type,
                isActive: isActive,
                weeklyLimit: weeklyLimit,
                contextKeysJson: contextKeysJson,
                motivation: motivation,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      Goal,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
      Goal,
      PrefetchHooks Function()
    >;
typedef $$CopingStrategiesTableCreateCompanionBuilder =
    CopingStrategiesCompanion Function({
      required String id,
      required String titleKey,
      required String descriptionKey,
      required String kind,
      required bool isBuiltIn,
      Value<bool> isEnabled,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CopingStrategiesTableUpdateCompanionBuilder =
    CopingStrategiesCompanion Function({
      Value<String> id,
      Value<String> titleKey,
      Value<String> descriptionKey,
      Value<String> kind,
      Value<bool> isBuiltIn,
      Value<bool> isEnabled,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$CopingStrategiesTableReferences extends BaseReferences<_$AppDatabase, $CopingStrategiesTable, CopingStrategy> {
  $$CopingStrategiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$UrgeSessionsTable, List<UrgeSession>> _urgeSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.urgeSessions,
    aliasName: 'coping_strategies__id__urge_sessions__coping_strategy_id',
  );

  $$UrgeSessionsTableProcessedTableManager get urgeSessionsRefs {
    final manager = $$UrgeSessionsTableTableManager($_db, $_db.urgeSessions).filter(
      (f) => f.copingStrategyId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_urgeSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CopingStrategyUsesTable, List<CopingStrategyUse>> _copingStrategyUsesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.copingStrategyUses,
    aliasName: 'coping_strategies__id__coping_strategy_uses__strategy_id',
  );

  $$CopingStrategyUsesTableProcessedTableManager get copingStrategyUsesRefs {
    final manager = $$CopingStrategyUsesTableTableManager(
      $_db,
      $_db.copingStrategyUses,
    ).filter((f) => f.strategyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _copingStrategyUsesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CopingStrategiesTableFilterComposer extends Composer<_$AppDatabase, $CopingStrategiesTable> {
  $$CopingStrategiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionKey => $composableBuilder(
    column: $table.descriptionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> urgeSessionsRefs(
    Expression<bool> Function($$UrgeSessionsTableFilterComposer f) f,
  ) {
    final $$UrgeSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.urgeSessions,
      getReferencedColumn: (t) => t.copingStrategyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UrgeSessionsTableFilterComposer(
            $db: $db,
            $table: $db.urgeSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> copingStrategyUsesRefs(
    Expression<bool> Function($$CopingStrategyUsesTableFilterComposer f) f,
  ) {
    final $$CopingStrategyUsesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.copingStrategyUses,
      getReferencedColumn: (t) => t.strategyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategyUsesTableFilterComposer(
            $db: $db,
            $table: $db.copingStrategyUses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CopingStrategiesTableOrderingComposer extends Composer<_$AppDatabase, $CopingStrategiesTable> {
  $$CopingStrategiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionKey => $composableBuilder(
    column: $table.descriptionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CopingStrategiesTableAnnotationComposer extends Composer<_$AppDatabase, $CopingStrategiesTable> {
  $$CopingStrategiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleKey => $composableBuilder(column: $table.titleKey, builder: (column) => column);

  GeneratedColumn<String> get descriptionKey => $composableBuilder(
    column: $table.descriptionKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind => $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn => $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled => $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> urgeSessionsRefs<T extends Object>(
    Expression<T> Function($$UrgeSessionsTableAnnotationComposer a) f,
  ) {
    final $$UrgeSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.urgeSessions,
      getReferencedColumn: (t) => t.copingStrategyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UrgeSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.urgeSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> copingStrategyUsesRefs<T extends Object>(
    Expression<T> Function($$CopingStrategyUsesTableAnnotationComposer a) f,
  ) {
    final $$CopingStrategyUsesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.copingStrategyUses,
      getReferencedColumn: (t) => t.strategyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategyUsesTableAnnotationComposer(
            $db: $db,
            $table: $db.copingStrategyUses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CopingStrategiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CopingStrategiesTable,
          CopingStrategy,
          $$CopingStrategiesTableFilterComposer,
          $$CopingStrategiesTableOrderingComposer,
          $$CopingStrategiesTableAnnotationComposer,
          $$CopingStrategiesTableCreateCompanionBuilder,
          $$CopingStrategiesTableUpdateCompanionBuilder,
          (CopingStrategy, $$CopingStrategiesTableReferences),
          CopingStrategy,
          PrefetchHooks Function({
            bool urgeSessionsRefs,
            bool copingStrategyUsesRefs,
          })
        > {
  $$CopingStrategiesTableTableManager(
    _$AppDatabase db,
    $CopingStrategiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CopingStrategiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CopingStrategiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CopingStrategiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> titleKey = const Value.absent(),
                Value<String> descriptionKey = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CopingStrategiesCompanion(
                id: id,
                titleKey: titleKey,
                descriptionKey: descriptionKey,
                kind: kind,
                isBuiltIn: isBuiltIn,
                isEnabled: isEnabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String titleKey,
                required String descriptionKey,
                required String kind,
                required bool isBuiltIn,
                Value<bool> isEnabled = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CopingStrategiesCompanion.insert(
                id: id,
                titleKey: titleKey,
                descriptionKey: descriptionKey,
                kind: kind,
                isBuiltIn: isBuiltIn,
                isEnabled: isEnabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CopingStrategiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({urgeSessionsRefs = false, copingStrategyUsesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (urgeSessionsRefs) db.urgeSessions,
                if (copingStrategyUsesRefs) db.copingStrategyUses,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (urgeSessionsRefs)
                    await $_getPrefetchedData<CopingStrategy, $CopingStrategiesTable, UrgeSession>(
                      currentTable: table,
                      referencedTable: $$CopingStrategiesTableReferences._urgeSessionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$CopingStrategiesTableReferences(
                        db,
                        table,
                        p0,
                      ).urgeSessionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where(
                        (e) => e.copingStrategyId == item.id,
                      ),
                      typedResults: items,
                    ),
                  if (copingStrategyUsesRefs)
                    await $_getPrefetchedData<CopingStrategy, $CopingStrategiesTable, CopingStrategyUse>(
                      currentTable: table,
                      referencedTable: $$CopingStrategiesTableReferences._copingStrategyUsesRefsTable(db),
                      managerFromTypedResult: (p0) => $$CopingStrategiesTableReferences(
                        db,
                        table,
                        p0,
                      ).copingStrategyUsesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where(
                        (e) => e.strategyId == item.id,
                      ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CopingStrategiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CopingStrategiesTable,
      CopingStrategy,
      $$CopingStrategiesTableFilterComposer,
      $$CopingStrategiesTableOrderingComposer,
      $$CopingStrategiesTableAnnotationComposer,
      $$CopingStrategiesTableCreateCompanionBuilder,
      $$CopingStrategiesTableUpdateCompanionBuilder,
      (CopingStrategy, $$CopingStrategiesTableReferences),
      CopingStrategy,
      PrefetchHooks Function({
        bool urgeSessionsRefs,
        bool copingStrategyUsesRefs,
      })
    >;
typedef $$UrgeSessionsTableCreateCompanionBuilder =
    UrgeSessionsCompanion Function({
      required String id,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required int initialIntensity,
      Value<int?> finalIntensity,
      Value<String?> triggerType,
      Value<String?> emotionType,
      Value<String?> copingStrategyId,
      Value<String?> outcome,
      Value<String?> notes,
      Value<int?> pauseDurationSeconds,
      Value<int> rowid,
    });
typedef $$UrgeSessionsTableUpdateCompanionBuilder =
    UrgeSessionsCompanion Function({
      Value<String> id,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<int> initialIntensity,
      Value<int?> finalIntensity,
      Value<String?> triggerType,
      Value<String?> emotionType,
      Value<String?> copingStrategyId,
      Value<String?> outcome,
      Value<String?> notes,
      Value<int?> pauseDurationSeconds,
      Value<int> rowid,
    });

final class $$UrgeSessionsTableReferences extends BaseReferences<_$AppDatabase, $UrgeSessionsTable, UrgeSession> {
  $$UrgeSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CopingStrategiesTable _copingStrategyIdTable(_$AppDatabase db) => db.copingStrategies.createAlias('urge_sessions__coping_strategy_id__coping_strategies__id');

  $$CopingStrategiesTableProcessedTableManager? get copingStrategyId {
    final $_column = $_itemColumn<String>('coping_strategy_id');
    if ($_column == null) return null;
    final manager = $$CopingStrategiesTableTableManager(
      $_db,
      $_db.copingStrategies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_copingStrategyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ConsumptionEventsTable, List<ConsumptionEvent>> _consumptionEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.consumptionEvents,
    aliasName: 'urge_sessions__id__consumption_events__urge_session_id',
  );

  $$ConsumptionEventsTableProcessedTableManager get consumptionEventsRefs {
    final manager = $$ConsumptionEventsTableTableManager(
      $_db,
      $_db.consumptionEvents,
    ).filter((f) => f.urgeSessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _consumptionEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CopingStrategyUsesTable, List<CopingStrategyUse>> _copingStrategyUsesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.copingStrategyUses,
    aliasName: 'urge_sessions__id__coping_strategy_uses__urge_session_id',
  );

  $$CopingStrategyUsesTableProcessedTableManager get copingStrategyUsesRefs {
    final manager = $$CopingStrategyUsesTableTableManager(
      $_db,
      $_db.copingStrategyUses,
    ).filter((f) => f.urgeSessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _copingStrategyUsesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UrgeSessionsTableFilterComposer extends Composer<_$AppDatabase, $UrgeSessionsTable> {
  $$UrgeSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initialIntensity => $composableBuilder(
    column: $table.initialIntensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get finalIntensity => $composableBuilder(
    column: $table.finalIntensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emotionType => $composableBuilder(
    column: $table.emotionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pauseDurationSeconds => $composableBuilder(
    column: $table.pauseDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  $$CopingStrategiesTableFilterComposer get copingStrategyId {
    final $$CopingStrategiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.copingStrategyId,
      referencedTable: $db.copingStrategies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategiesTableFilterComposer(
            $db: $db,
            $table: $db.copingStrategies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> consumptionEventsRefs(
    Expression<bool> Function($$ConsumptionEventsTableFilterComposer f) f,
  ) {
    final $$ConsumptionEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.consumptionEvents,
      getReferencedColumn: (t) => t.urgeSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumptionEventsTableFilterComposer(
            $db: $db,
            $table: $db.consumptionEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> copingStrategyUsesRefs(
    Expression<bool> Function($$CopingStrategyUsesTableFilterComposer f) f,
  ) {
    final $$CopingStrategyUsesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.copingStrategyUses,
      getReferencedColumn: (t) => t.urgeSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategyUsesTableFilterComposer(
            $db: $db,
            $table: $db.copingStrategyUses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UrgeSessionsTableOrderingComposer extends Composer<_$AppDatabase, $UrgeSessionsTable> {
  $$UrgeSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initialIntensity => $composableBuilder(
    column: $table.initialIntensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get finalIntensity => $composableBuilder(
    column: $table.finalIntensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emotionType => $composableBuilder(
    column: $table.emotionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pauseDurationSeconds => $composableBuilder(
    column: $table.pauseDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  $$CopingStrategiesTableOrderingComposer get copingStrategyId {
    final $$CopingStrategiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.copingStrategyId,
      referencedTable: $db.copingStrategies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategiesTableOrderingComposer(
            $db: $db,
            $table: $db.copingStrategies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UrgeSessionsTableAnnotationComposer extends Composer<_$AppDatabase, $UrgeSessionsTable> {
  $$UrgeSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt => $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get initialIntensity => $composableBuilder(
    column: $table.initialIntensity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get finalIntensity => $composableBuilder(
    column: $table.finalIntensity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emotionType => $composableBuilder(
    column: $table.emotionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outcome => $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get pauseDurationSeconds => $composableBuilder(
    column: $table.pauseDurationSeconds,
    builder: (column) => column,
  );

  $$CopingStrategiesTableAnnotationComposer get copingStrategyId {
    final $$CopingStrategiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.copingStrategyId,
      referencedTable: $db.copingStrategies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategiesTableAnnotationComposer(
            $db: $db,
            $table: $db.copingStrategies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> consumptionEventsRefs<T extends Object>(
    Expression<T> Function($$ConsumptionEventsTableAnnotationComposer a) f,
  ) {
    final $$ConsumptionEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.consumptionEvents,
      getReferencedColumn: (t) => t.urgeSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumptionEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.consumptionEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> copingStrategyUsesRefs<T extends Object>(
    Expression<T> Function($$CopingStrategyUsesTableAnnotationComposer a) f,
  ) {
    final $$CopingStrategyUsesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.copingStrategyUses,
      getReferencedColumn: (t) => t.urgeSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategyUsesTableAnnotationComposer(
            $db: $db,
            $table: $db.copingStrategyUses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UrgeSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UrgeSessionsTable,
          UrgeSession,
          $$UrgeSessionsTableFilterComposer,
          $$UrgeSessionsTableOrderingComposer,
          $$UrgeSessionsTableAnnotationComposer,
          $$UrgeSessionsTableCreateCompanionBuilder,
          $$UrgeSessionsTableUpdateCompanionBuilder,
          (UrgeSession, $$UrgeSessionsTableReferences),
          UrgeSession,
          PrefetchHooks Function({
            bool copingStrategyId,
            bool consumptionEventsRefs,
            bool copingStrategyUsesRefs,
          })
        > {
  $$UrgeSessionsTableTableManager(_$AppDatabase db, $UrgeSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$UrgeSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$UrgeSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$UrgeSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> initialIntensity = const Value.absent(),
                Value<int?> finalIntensity = const Value.absent(),
                Value<String?> triggerType = const Value.absent(),
                Value<String?> emotionType = const Value.absent(),
                Value<String?> copingStrategyId = const Value.absent(),
                Value<String?> outcome = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> pauseDurationSeconds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UrgeSessionsCompanion(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                initialIntensity: initialIntensity,
                finalIntensity: finalIntensity,
                triggerType: triggerType,
                emotionType: emotionType,
                copingStrategyId: copingStrategyId,
                outcome: outcome,
                notes: notes,
                pauseDurationSeconds: pauseDurationSeconds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required int initialIntensity,
                Value<int?> finalIntensity = const Value.absent(),
                Value<String?> triggerType = const Value.absent(),
                Value<String?> emotionType = const Value.absent(),
                Value<String?> copingStrategyId = const Value.absent(),
                Value<String?> outcome = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> pauseDurationSeconds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UrgeSessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                initialIntensity: initialIntensity,
                finalIntensity: finalIntensity,
                triggerType: triggerType,
                emotionType: emotionType,
                copingStrategyId: copingStrategyId,
                outcome: outcome,
                notes: notes,
                pauseDurationSeconds: pauseDurationSeconds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UrgeSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                copingStrategyId = false,
                consumptionEventsRefs = false,
                copingStrategyUsesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (consumptionEventsRefs) db.consumptionEvents,
                    if (copingStrategyUsesRefs) db.copingStrategyUses,
                  ],
                  addJoins: <T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic>>(state) {
                    if (copingStrategyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.copingStrategyId,
                                referencedTable: $$UrgeSessionsTableReferences._copingStrategyIdTable(db),
                                referencedColumn: $$UrgeSessionsTableReferences._copingStrategyIdTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (consumptionEventsRefs)
                        await $_getPrefetchedData<UrgeSession, $UrgeSessionsTable, ConsumptionEvent>(
                          currentTable: table,
                          referencedTable: $$UrgeSessionsTableReferences._consumptionEventsRefsTable(db),
                          managerFromTypedResult: (p0) => $$UrgeSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).consumptionEventsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where(
                            (e) => e.urgeSessionId == item.id,
                          ),
                          typedResults: items,
                        ),
                      if (copingStrategyUsesRefs)
                        await $_getPrefetchedData<UrgeSession, $UrgeSessionsTable, CopingStrategyUse>(
                          currentTable: table,
                          referencedTable: $$UrgeSessionsTableReferences._copingStrategyUsesRefsTable(db),
                          managerFromTypedResult: (p0) => $$UrgeSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).copingStrategyUsesRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where(
                            (e) => e.urgeSessionId == item.id,
                          ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UrgeSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UrgeSessionsTable,
      UrgeSession,
      $$UrgeSessionsTableFilterComposer,
      $$UrgeSessionsTableOrderingComposer,
      $$UrgeSessionsTableAnnotationComposer,
      $$UrgeSessionsTableCreateCompanionBuilder,
      $$UrgeSessionsTableUpdateCompanionBuilder,
      (UrgeSession, $$UrgeSessionsTableReferences),
      UrgeSession,
      PrefetchHooks Function({
        bool copingStrategyId,
        bool consumptionEventsRefs,
        bool copingStrategyUsesRefs,
      })
    >;
typedef $$ConsumptionEventsTableCreateCompanionBuilder =
    ConsumptionEventsCompanion Function({
      required String id,
      required DateTime occurredAt,
      Value<String?> triggerType,
      Value<String?> emotionType,
      Value<String?> contextLabel,
      Value<String?> contextKeysJson,
      Value<int?> perceivedControl,
      Value<String?> notes,
      Value<String?> urgeSessionId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ConsumptionEventsTableUpdateCompanionBuilder =
    ConsumptionEventsCompanion Function({
      Value<String> id,
      Value<DateTime> occurredAt,
      Value<String?> triggerType,
      Value<String?> emotionType,
      Value<String?> contextLabel,
      Value<String?> contextKeysJson,
      Value<int?> perceivedControl,
      Value<String?> notes,
      Value<String?> urgeSessionId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ConsumptionEventsTableReferences extends BaseReferences<_$AppDatabase, $ConsumptionEventsTable, ConsumptionEvent> {
  $$ConsumptionEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UrgeSessionsTable _urgeSessionIdTable(_$AppDatabase db) => db.urgeSessions.createAlias('consumption_events__urge_session_id__urge_sessions__id');

  $$UrgeSessionsTableProcessedTableManager? get urgeSessionId {
    final $_column = $_itemColumn<String>('urge_session_id');
    if ($_column == null) return null;
    final manager = $$UrgeSessionsTableTableManager(
      $_db,
      $_db.urgeSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_urgeSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConsumptionEventsTableFilterComposer extends Composer<_$AppDatabase, $ConsumptionEventsTable> {
  $$ConsumptionEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emotionType => $composableBuilder(
    column: $table.emotionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextLabel => $composableBuilder(
    column: $table.contextLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextKeysJson => $composableBuilder(
    column: $table.contextKeysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get perceivedControl => $composableBuilder(
    column: $table.perceivedControl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UrgeSessionsTableFilterComposer get urgeSessionId {
    final $$UrgeSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.urgeSessionId,
      referencedTable: $db.urgeSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UrgeSessionsTableFilterComposer(
            $db: $db,
            $table: $db.urgeSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsumptionEventsTableOrderingComposer extends Composer<_$AppDatabase, $ConsumptionEventsTable> {
  $$ConsumptionEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emotionType => $composableBuilder(
    column: $table.emotionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextLabel => $composableBuilder(
    column: $table.contextLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextKeysJson => $composableBuilder(
    column: $table.contextKeysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get perceivedControl => $composableBuilder(
    column: $table.perceivedControl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UrgeSessionsTableOrderingComposer get urgeSessionId {
    final $$UrgeSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.urgeSessionId,
      referencedTable: $db.urgeSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UrgeSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.urgeSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsumptionEventsTableAnnotationComposer extends Composer<_$AppDatabase, $ConsumptionEventsTable> {
  $$ConsumptionEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emotionType => $composableBuilder(
    column: $table.emotionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contextLabel => $composableBuilder(
    column: $table.contextLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contextKeysJson => $composableBuilder(
    column: $table.contextKeysJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get perceivedControl => $composableBuilder(
    column: $table.perceivedControl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UrgeSessionsTableAnnotationComposer get urgeSessionId {
    final $$UrgeSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.urgeSessionId,
      referencedTable: $db.urgeSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UrgeSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.urgeSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsumptionEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConsumptionEventsTable,
          ConsumptionEvent,
          $$ConsumptionEventsTableFilterComposer,
          $$ConsumptionEventsTableOrderingComposer,
          $$ConsumptionEventsTableAnnotationComposer,
          $$ConsumptionEventsTableCreateCompanionBuilder,
          $$ConsumptionEventsTableUpdateCompanionBuilder,
          (ConsumptionEvent, $$ConsumptionEventsTableReferences),
          ConsumptionEvent,
          PrefetchHooks Function({bool urgeSessionId})
        > {
  $$ConsumptionEventsTableTableManager(
    _$AppDatabase db,
    $ConsumptionEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ConsumptionEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ConsumptionEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ConsumptionEventsTableAnnotationComposer(
            $db: db,
            $table: table,
          ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> triggerType = const Value.absent(),
                Value<String?> emotionType = const Value.absent(),
                Value<String?> contextLabel = const Value.absent(),
                Value<String?> contextKeysJson = const Value.absent(),
                Value<int?> perceivedControl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> urgeSessionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConsumptionEventsCompanion(
                id: id,
                occurredAt: occurredAt,
                triggerType: triggerType,
                emotionType: emotionType,
                contextLabel: contextLabel,
                contextKeysJson: contextKeysJson,
                perceivedControl: perceivedControl,
                notes: notes,
                urgeSessionId: urgeSessionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime occurredAt,
                Value<String?> triggerType = const Value.absent(),
                Value<String?> emotionType = const Value.absent(),
                Value<String?> contextLabel = const Value.absent(),
                Value<String?> contextKeysJson = const Value.absent(),
                Value<int?> perceivedControl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> urgeSessionId = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ConsumptionEventsCompanion.insert(
                id: id,
                occurredAt: occurredAt,
                triggerType: triggerType,
                emotionType: emotionType,
                contextLabel: contextLabel,
                contextKeysJson: contextKeysJson,
                perceivedControl: perceivedControl,
                notes: notes,
                urgeSessionId: urgeSessionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConsumptionEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({urgeSessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic>>(state) {
                if (urgeSessionId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.urgeSessionId,
                            referencedTable: $$ConsumptionEventsTableReferences._urgeSessionIdTable(db),
                            referencedColumn: $$ConsumptionEventsTableReferences._urgeSessionIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ConsumptionEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConsumptionEventsTable,
      ConsumptionEvent,
      $$ConsumptionEventsTableFilterComposer,
      $$ConsumptionEventsTableOrderingComposer,
      $$ConsumptionEventsTableAnnotationComposer,
      $$ConsumptionEventsTableCreateCompanionBuilder,
      $$ConsumptionEventsTableUpdateCompanionBuilder,
      (ConsumptionEvent, $$ConsumptionEventsTableReferences),
      ConsumptionEvent,
      PrefetchHooks Function({bool urgeSessionId})
    >;
typedef $$DailyCheckInsTableCreateCompanionBuilder =
    DailyCheckInsCompanion Function({
      required String localDate,
      required DateTime createdAt,
      required DateTime updatedAt,
      required int moodScore,
      required int controlScore,
      Value<int?> urgeCountEstimate,
      Value<int?> sleepQuality,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$DailyCheckInsTableUpdateCompanionBuilder =
    DailyCheckInsCompanion Function({
      Value<String> localDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> moodScore,
      Value<int> controlScore,
      Value<int?> urgeCountEstimate,
      Value<int?> sleepQuality,
      Value<String?> note,
      Value<int> rowid,
    });

class $$DailyCheckInsTableFilterComposer extends Composer<_$AppDatabase, $DailyCheckInsTable> {
  $$DailyCheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get controlScore => $composableBuilder(
    column: $table.controlScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get urgeCountEstimate => $composableBuilder(
    column: $table.urgeCountEstimate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyCheckInsTableOrderingComposer extends Composer<_$AppDatabase, $DailyCheckInsTable> {
  $$DailyCheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get controlScore => $composableBuilder(
    column: $table.controlScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get urgeCountEstimate => $composableBuilder(
    column: $table.urgeCountEstimate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyCheckInsTableAnnotationComposer extends Composer<_$AppDatabase, $DailyCheckInsTable> {
  $$DailyCheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get localDate => $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get moodScore => $composableBuilder(column: $table.moodScore, builder: (column) => column);

  GeneratedColumn<int> get controlScore => $composableBuilder(
    column: $table.controlScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get urgeCountEstimate => $composableBuilder(
    column: $table.urgeCountEstimate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$DailyCheckInsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyCheckInsTable,
          DailyCheckIn,
          $$DailyCheckInsTableFilterComposer,
          $$DailyCheckInsTableOrderingComposer,
          $$DailyCheckInsTableAnnotationComposer,
          $$DailyCheckInsTableCreateCompanionBuilder,
          $$DailyCheckInsTableUpdateCompanionBuilder,
          (
            DailyCheckIn,
            BaseReferences<_$AppDatabase, $DailyCheckInsTable, DailyCheckIn>,
          ),
          DailyCheckIn,
          PrefetchHooks Function()
        > {
  $$DailyCheckInsTableTableManager(_$AppDatabase db, $DailyCheckInsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$DailyCheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$DailyCheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$DailyCheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> localDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> moodScore = const Value.absent(),
                Value<int> controlScore = const Value.absent(),
                Value<int?> urgeCountEstimate = const Value.absent(),
                Value<int?> sleepQuality = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckInsCompanion(
                localDate: localDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                moodScore: moodScore,
                controlScore: controlScore,
                urgeCountEstimate: urgeCountEstimate,
                sleepQuality: sleepQuality,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String localDate,
                required DateTime createdAt,
                required DateTime updatedAt,
                required int moodScore,
                required int controlScore,
                Value<int?> urgeCountEstimate = const Value.absent(),
                Value<int?> sleepQuality = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCheckInsCompanion.insert(
                localDate: localDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                moodScore: moodScore,
                controlScore: controlScore,
                urgeCountEstimate: urgeCountEstimate,
                sleepQuality: sleepQuality,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyCheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyCheckInsTable,
      DailyCheckIn,
      $$DailyCheckInsTableFilterComposer,
      $$DailyCheckInsTableOrderingComposer,
      $$DailyCheckInsTableAnnotationComposer,
      $$DailyCheckInsTableCreateCompanionBuilder,
      $$DailyCheckInsTableUpdateCompanionBuilder,
      (
        DailyCheckIn,
        BaseReferences<_$AppDatabase, $DailyCheckInsTable, DailyCheckIn>,
      ),
      DailyCheckIn,
      PrefetchHooks Function()
    >;
typedef $$SelfAssessmentsTableCreateCompanionBuilder =
    SelfAssessmentsCompanion Function({
      required String id,
      required DateTime recordedAt,
      required String kind,
      Value<int?> weeklyFrequency,
      required int perceivedControl,
      required int negativeImpact,
      required int confidenceToChange,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$SelfAssessmentsTableUpdateCompanionBuilder =
    SelfAssessmentsCompanion Function({
      Value<String> id,
      Value<DateTime> recordedAt,
      Value<String> kind,
      Value<int?> weeklyFrequency,
      Value<int> perceivedControl,
      Value<int> negativeImpact,
      Value<int> confidenceToChange,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$SelfAssessmentsTableFilterComposer extends Composer<_$AppDatabase, $SelfAssessmentsTable> {
  $$SelfAssessmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyFrequency => $composableBuilder(
    column: $table.weeklyFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get perceivedControl => $composableBuilder(
    column: $table.perceivedControl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get negativeImpact => $composableBuilder(
    column: $table.negativeImpact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confidenceToChange => $composableBuilder(
    column: $table.confidenceToChange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SelfAssessmentsTableOrderingComposer extends Composer<_$AppDatabase, $SelfAssessmentsTable> {
  $$SelfAssessmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyFrequency => $composableBuilder(
    column: $table.weeklyFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get perceivedControl => $composableBuilder(
    column: $table.perceivedControl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get negativeImpact => $composableBuilder(
    column: $table.negativeImpact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confidenceToChange => $composableBuilder(
    column: $table.confidenceToChange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SelfAssessmentsTableAnnotationComposer extends Composer<_$AppDatabase, $SelfAssessmentsTable> {
  $$SelfAssessmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind => $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get weeklyFrequency => $composableBuilder(
    column: $table.weeklyFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<int> get perceivedControl => $composableBuilder(
    column: $table.perceivedControl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get negativeImpact => $composableBuilder(
    column: $table.negativeImpact,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confidenceToChange => $composableBuilder(
    column: $table.confidenceToChange,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$SelfAssessmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SelfAssessmentsTable,
          SelfAssessment,
          $$SelfAssessmentsTableFilterComposer,
          $$SelfAssessmentsTableOrderingComposer,
          $$SelfAssessmentsTableAnnotationComposer,
          $$SelfAssessmentsTableCreateCompanionBuilder,
          $$SelfAssessmentsTableUpdateCompanionBuilder,
          (
            SelfAssessment,
            BaseReferences<_$AppDatabase, $SelfAssessmentsTable, SelfAssessment>,
          ),
          SelfAssessment,
          PrefetchHooks Function()
        > {
  $$SelfAssessmentsTableTableManager(
    _$AppDatabase db,
    $SelfAssessmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SelfAssessmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SelfAssessmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SelfAssessmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int?> weeklyFrequency = const Value.absent(),
                Value<int> perceivedControl = const Value.absent(),
                Value<int> negativeImpact = const Value.absent(),
                Value<int> confidenceToChange = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SelfAssessmentsCompanion(
                id: id,
                recordedAt: recordedAt,
                kind: kind,
                weeklyFrequency: weeklyFrequency,
                perceivedControl: perceivedControl,
                negativeImpact: negativeImpact,
                confidenceToChange: confidenceToChange,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime recordedAt,
                required String kind,
                Value<int?> weeklyFrequency = const Value.absent(),
                required int perceivedControl,
                required int negativeImpact,
                required int confidenceToChange,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SelfAssessmentsCompanion.insert(
                id: id,
                recordedAt: recordedAt,
                kind: kind,
                weeklyFrequency: weeklyFrequency,
                perceivedControl: perceivedControl,
                negativeImpact: negativeImpact,
                confidenceToChange: confidenceToChange,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SelfAssessmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SelfAssessmentsTable,
      SelfAssessment,
      $$SelfAssessmentsTableFilterComposer,
      $$SelfAssessmentsTableOrderingComposer,
      $$SelfAssessmentsTableAnnotationComposer,
      $$SelfAssessmentsTableCreateCompanionBuilder,
      $$SelfAssessmentsTableUpdateCompanionBuilder,
      (
        SelfAssessment,
        BaseReferences<_$AppDatabase, $SelfAssessmentsTable, SelfAssessment>,
      ),
      SelfAssessment,
      PrefetchHooks Function()
    >;
typedef $$CopingStrategyUsesTableCreateCompanionBuilder =
    CopingStrategyUsesCompanion Function({
      required String id,
      required String strategyId,
      required DateTime usedAt,
      Value<String?> urgeSessionId,
      Value<int?> perceivedEffect,
      Value<int> rowid,
    });
typedef $$CopingStrategyUsesTableUpdateCompanionBuilder =
    CopingStrategyUsesCompanion Function({
      Value<String> id,
      Value<String> strategyId,
      Value<DateTime> usedAt,
      Value<String?> urgeSessionId,
      Value<int?> perceivedEffect,
      Value<int> rowid,
    });

final class $$CopingStrategyUsesTableReferences extends BaseReferences<_$AppDatabase, $CopingStrategyUsesTable, CopingStrategyUse> {
  $$CopingStrategyUsesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CopingStrategiesTable _strategyIdTable(_$AppDatabase db) => db.copingStrategies.createAlias('coping_strategy_uses__strategy_id__coping_strategies__id');

  $$CopingStrategiesTableProcessedTableManager get strategyId {
    final $_column = $_itemColumn<String>('strategy_id')!;

    final manager = $$CopingStrategiesTableTableManager(
      $_db,
      $_db.copingStrategies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_strategyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UrgeSessionsTable _urgeSessionIdTable(_$AppDatabase db) => db.urgeSessions.createAlias('coping_strategy_uses__urge_session_id__urge_sessions__id');

  $$UrgeSessionsTableProcessedTableManager? get urgeSessionId {
    final $_column = $_itemColumn<String>('urge_session_id');
    if ($_column == null) return null;
    final manager = $$UrgeSessionsTableTableManager(
      $_db,
      $_db.urgeSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_urgeSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CopingStrategyUsesTableFilterComposer extends Composer<_$AppDatabase, $CopingStrategyUsesTable> {
  $$CopingStrategyUsesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get perceivedEffect => $composableBuilder(
    column: $table.perceivedEffect,
    builder: (column) => ColumnFilters(column),
  );

  $$CopingStrategiesTableFilterComposer get strategyId {
    final $$CopingStrategiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.strategyId,
      referencedTable: $db.copingStrategies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategiesTableFilterComposer(
            $db: $db,
            $table: $db.copingStrategies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UrgeSessionsTableFilterComposer get urgeSessionId {
    final $$UrgeSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.urgeSessionId,
      referencedTable: $db.urgeSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UrgeSessionsTableFilterComposer(
            $db: $db,
            $table: $db.urgeSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CopingStrategyUsesTableOrderingComposer extends Composer<_$AppDatabase, $CopingStrategyUsesTable> {
  $$CopingStrategyUsesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get usedAt => $composableBuilder(
    column: $table.usedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get perceivedEffect => $composableBuilder(
    column: $table.perceivedEffect,
    builder: (column) => ColumnOrderings(column),
  );

  $$CopingStrategiesTableOrderingComposer get strategyId {
    final $$CopingStrategiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.strategyId,
      referencedTable: $db.copingStrategies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategiesTableOrderingComposer(
            $db: $db,
            $table: $db.copingStrategies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UrgeSessionsTableOrderingComposer get urgeSessionId {
    final $$UrgeSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.urgeSessionId,
      referencedTable: $db.urgeSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UrgeSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.urgeSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CopingStrategyUsesTableAnnotationComposer extends Composer<_$AppDatabase, $CopingStrategyUsesTable> {
  $$CopingStrategyUsesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get usedAt => $composableBuilder(column: $table.usedAt, builder: (column) => column);

  GeneratedColumn<int> get perceivedEffect => $composableBuilder(
    column: $table.perceivedEffect,
    builder: (column) => column,
  );

  $$CopingStrategiesTableAnnotationComposer get strategyId {
    final $$CopingStrategiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.strategyId,
      referencedTable: $db.copingStrategies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CopingStrategiesTableAnnotationComposer(
            $db: $db,
            $table: $db.copingStrategies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UrgeSessionsTableAnnotationComposer get urgeSessionId {
    final $$UrgeSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.urgeSessionId,
      referencedTable: $db.urgeSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UrgeSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.urgeSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CopingStrategyUsesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CopingStrategyUsesTable,
          CopingStrategyUse,
          $$CopingStrategyUsesTableFilterComposer,
          $$CopingStrategyUsesTableOrderingComposer,
          $$CopingStrategyUsesTableAnnotationComposer,
          $$CopingStrategyUsesTableCreateCompanionBuilder,
          $$CopingStrategyUsesTableUpdateCompanionBuilder,
          (CopingStrategyUse, $$CopingStrategyUsesTableReferences),
          CopingStrategyUse,
          PrefetchHooks Function({bool strategyId, bool urgeSessionId})
        > {
  $$CopingStrategyUsesTableTableManager(
    _$AppDatabase db,
    $CopingStrategyUsesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CopingStrategyUsesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CopingStrategyUsesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CopingStrategyUsesTableAnnotationComposer(
            $db: db,
            $table: table,
          ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> strategyId = const Value.absent(),
                Value<DateTime> usedAt = const Value.absent(),
                Value<String?> urgeSessionId = const Value.absent(),
                Value<int?> perceivedEffect = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CopingStrategyUsesCompanion(
                id: id,
                strategyId: strategyId,
                usedAt: usedAt,
                urgeSessionId: urgeSessionId,
                perceivedEffect: perceivedEffect,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String strategyId,
                required DateTime usedAt,
                Value<String?> urgeSessionId = const Value.absent(),
                Value<int?> perceivedEffect = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CopingStrategyUsesCompanion.insert(
                id: id,
                strategyId: strategyId,
                usedAt: usedAt,
                urgeSessionId: urgeSessionId,
                perceivedEffect: perceivedEffect,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CopingStrategyUsesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({strategyId = false, urgeSessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic>>(state) {
                if (strategyId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.strategyId,
                            referencedTable: $$CopingStrategyUsesTableReferences._strategyIdTable(db),
                            referencedColumn: $$CopingStrategyUsesTableReferences._strategyIdTable(db).id,
                          )
                          as T;
                }
                if (urgeSessionId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.urgeSessionId,
                            referencedTable: $$CopingStrategyUsesTableReferences._urgeSessionIdTable(db),
                            referencedColumn: $$CopingStrategyUsesTableReferences._urgeSessionIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CopingStrategyUsesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CopingStrategyUsesTable,
      CopingStrategyUse,
      $$CopingStrategyUsesTableFilterComposer,
      $$CopingStrategyUsesTableOrderingComposer,
      $$CopingStrategyUsesTableAnnotationComposer,
      $$CopingStrategyUsesTableCreateCompanionBuilder,
      $$CopingStrategyUsesTableUpdateCompanionBuilder,
      (CopingStrategyUse, $$CopingStrategyUsesTableReferences),
      CopingStrategyUse,
      PrefetchHooks Function({bool strategyId, bool urgeSessionId})
    >;
typedef $$ModuleProgressTableCreateCompanionBuilder =
    ModuleProgressCompanion Function({
      required String moduleId,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<int> lastSectionIndex,
      Value<bool> isReviewing,
      Value<String?> reflectionText,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ModuleProgressTableUpdateCompanionBuilder =
    ModuleProgressCompanion Function({
      Value<String> moduleId,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<int> lastSectionIndex,
      Value<bool> isReviewing,
      Value<String?> reflectionText,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ModuleProgressTableFilterComposer extends Composer<_$AppDatabase, $ModuleProgressTable> {
  $$ModuleProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSectionIndex => $composableBuilder(
    column: $table.lastSectionIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isReviewing => $composableBuilder(
    column: $table.isReviewing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reflectionText => $composableBuilder(
    column: $table.reflectionText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ModuleProgressTableOrderingComposer extends Composer<_$AppDatabase, $ModuleProgressTable> {
  $$ModuleProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSectionIndex => $composableBuilder(
    column: $table.lastSectionIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isReviewing => $composableBuilder(
    column: $table.isReviewing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reflectionText => $composableBuilder(
    column: $table.reflectionText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ModuleProgressTableAnnotationComposer extends Composer<_$AppDatabase, $ModuleProgressTable> {
  $$ModuleProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get moduleId => $composableBuilder(column: $table.moduleId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt => $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSectionIndex => $composableBuilder(
    column: $table.lastSectionIndex,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isReviewing => $composableBuilder(
    column: $table.isReviewing,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reflectionText => $composableBuilder(
    column: $table.reflectionText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ModuleProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ModuleProgressTable,
          ModuleProgressData,
          $$ModuleProgressTableFilterComposer,
          $$ModuleProgressTableOrderingComposer,
          $$ModuleProgressTableAnnotationComposer,
          $$ModuleProgressTableCreateCompanionBuilder,
          $$ModuleProgressTableUpdateCompanionBuilder,
          (
            ModuleProgressData,
            BaseReferences<_$AppDatabase, $ModuleProgressTable, ModuleProgressData>,
          ),
          ModuleProgressData,
          PrefetchHooks Function()
        > {
  $$ModuleProgressTableTableManager(
    _$AppDatabase db,
    $ModuleProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ModuleProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ModuleProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ModuleProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> moduleId = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> lastSectionIndex = const Value.absent(),
                Value<bool> isReviewing = const Value.absent(),
                Value<String?> reflectionText = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ModuleProgressCompanion(
                moduleId: moduleId,
                startedAt: startedAt,
                completedAt: completedAt,
                lastSectionIndex: lastSectionIndex,
                isReviewing: isReviewing,
                reflectionText: reflectionText,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String moduleId,
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> lastSectionIndex = const Value.absent(),
                Value<bool> isReviewing = const Value.absent(),
                Value<String?> reflectionText = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ModuleProgressCompanion.insert(
                moduleId: moduleId,
                startedAt: startedAt,
                completedAt: completedAt,
                lastSectionIndex: lastSectionIndex,
                isReviewing: isReviewing,
                reflectionText: reflectionText,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ModuleProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ModuleProgressTable,
      ModuleProgressData,
      $$ModuleProgressTableFilterComposer,
      $$ModuleProgressTableOrderingComposer,
      $$ModuleProgressTableAnnotationComposer,
      $$ModuleProgressTableCreateCompanionBuilder,
      $$ModuleProgressTableUpdateCompanionBuilder,
      (
        ModuleProgressData,
        BaseReferences<_$AppDatabase, $ModuleProgressTable, ModuleProgressData>,
      ),
      ModuleProgressData,
      PrefetchHooks Function()
    >;
typedef $$OnboardingDraftsTableCreateCompanionBuilder =
    OnboardingDraftsCompanion Function({
      required String id,
      required String goalId,
      required String assessmentId,
      Value<int> currentStep,
      Value<String?> goalType,
      Value<int?> weeklyLimit,
      Value<String?> contextKeysJson,
      Value<String?> motivation,
      Value<int> baselineFrequency,
      Value<int> perceivedControl,
      Value<int> negativeImpact,
      Value<int> confidenceToChange,
      Value<String?> strategyIdsJson,
      Value<bool> dailyCheckInReminderEnabled,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$OnboardingDraftsTableUpdateCompanionBuilder =
    OnboardingDraftsCompanion Function({
      Value<String> id,
      Value<String> goalId,
      Value<String> assessmentId,
      Value<int> currentStep,
      Value<String?> goalType,
      Value<int?> weeklyLimit,
      Value<String?> contextKeysJson,
      Value<String?> motivation,
      Value<int> baselineFrequency,
      Value<int> perceivedControl,
      Value<int> negativeImpact,
      Value<int> confidenceToChange,
      Value<String?> strategyIdsJson,
      Value<bool> dailyCheckInReminderEnabled,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$OnboardingDraftsTableFilterComposer extends Composer<_$AppDatabase, $OnboardingDraftsTable> {
  $$OnboardingDraftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assessmentId => $composableBuilder(
    column: $table.assessmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStep => $composableBuilder(
    column: $table.currentStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyLimit => $composableBuilder(
    column: $table.weeklyLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextKeysJson => $composableBuilder(
    column: $table.contextKeysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivation => $composableBuilder(
    column: $table.motivation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baselineFrequency => $composableBuilder(
    column: $table.baselineFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get perceivedControl => $composableBuilder(
    column: $table.perceivedControl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get negativeImpact => $composableBuilder(
    column: $table.negativeImpact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confidenceToChange => $composableBuilder(
    column: $table.confidenceToChange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strategyIdsJson => $composableBuilder(
    column: $table.strategyIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dailyCheckInReminderEnabled => $composableBuilder(
    column: $table.dailyCheckInReminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OnboardingDraftsTableOrderingComposer extends Composer<_$AppDatabase, $OnboardingDraftsTable> {
  $$OnboardingDraftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assessmentId => $composableBuilder(
    column: $table.assessmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStep => $composableBuilder(
    column: $table.currentStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyLimit => $composableBuilder(
    column: $table.weeklyLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextKeysJson => $composableBuilder(
    column: $table.contextKeysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivation => $composableBuilder(
    column: $table.motivation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baselineFrequency => $composableBuilder(
    column: $table.baselineFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get perceivedControl => $composableBuilder(
    column: $table.perceivedControl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get negativeImpact => $composableBuilder(
    column: $table.negativeImpact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confidenceToChange => $composableBuilder(
    column: $table.confidenceToChange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strategyIdsJson => $composableBuilder(
    column: $table.strategyIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dailyCheckInReminderEnabled => $composableBuilder(
    column: $table.dailyCheckInReminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OnboardingDraftsTableAnnotationComposer extends Composer<_$AppDatabase, $OnboardingDraftsTable> {
  $$OnboardingDraftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get goalId => $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get assessmentId => $composableBuilder(
    column: $table.assessmentId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentStep => $composableBuilder(
    column: $table.currentStep,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalType => $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<int> get weeklyLimit => $composableBuilder(
    column: $table.weeklyLimit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contextKeysJson => $composableBuilder(
    column: $table.contextKeysJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get motivation => $composableBuilder(
    column: $table.motivation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get baselineFrequency => $composableBuilder(
    column: $table.baselineFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<int> get perceivedControl => $composableBuilder(
    column: $table.perceivedControl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get negativeImpact => $composableBuilder(
    column: $table.negativeImpact,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confidenceToChange => $composableBuilder(
    column: $table.confidenceToChange,
    builder: (column) => column,
  );

  GeneratedColumn<String> get strategyIdsJson => $composableBuilder(
    column: $table.strategyIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get dailyCheckInReminderEnabled => $composableBuilder(
    column: $table.dailyCheckInReminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OnboardingDraftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OnboardingDraftsTable,
          OnboardingDraftRecord,
          $$OnboardingDraftsTableFilterComposer,
          $$OnboardingDraftsTableOrderingComposer,
          $$OnboardingDraftsTableAnnotationComposer,
          $$OnboardingDraftsTableCreateCompanionBuilder,
          $$OnboardingDraftsTableUpdateCompanionBuilder,
          (
            OnboardingDraftRecord,
            BaseReferences<_$AppDatabase, $OnboardingDraftsTable, OnboardingDraftRecord>,
          ),
          OnboardingDraftRecord,
          PrefetchHooks Function()
        > {
  $$OnboardingDraftsTableTableManager(
    _$AppDatabase db,
    $OnboardingDraftsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$OnboardingDraftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$OnboardingDraftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$OnboardingDraftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> goalId = const Value.absent(),
                Value<String> assessmentId = const Value.absent(),
                Value<int> currentStep = const Value.absent(),
                Value<String?> goalType = const Value.absent(),
                Value<int?> weeklyLimit = const Value.absent(),
                Value<String?> contextKeysJson = const Value.absent(),
                Value<String?> motivation = const Value.absent(),
                Value<int> baselineFrequency = const Value.absent(),
                Value<int> perceivedControl = const Value.absent(),
                Value<int> negativeImpact = const Value.absent(),
                Value<int> confidenceToChange = const Value.absent(),
                Value<String?> strategyIdsJson = const Value.absent(),
                Value<bool> dailyCheckInReminderEnabled = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OnboardingDraftsCompanion(
                id: id,
                goalId: goalId,
                assessmentId: assessmentId,
                currentStep: currentStep,
                goalType: goalType,
                weeklyLimit: weeklyLimit,
                contextKeysJson: contextKeysJson,
                motivation: motivation,
                baselineFrequency: baselineFrequency,
                perceivedControl: perceivedControl,
                negativeImpact: negativeImpact,
                confidenceToChange: confidenceToChange,
                strategyIdsJson: strategyIdsJson,
                dailyCheckInReminderEnabled: dailyCheckInReminderEnabled,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String goalId,
                required String assessmentId,
                Value<int> currentStep = const Value.absent(),
                Value<String?> goalType = const Value.absent(),
                Value<int?> weeklyLimit = const Value.absent(),
                Value<String?> contextKeysJson = const Value.absent(),
                Value<String?> motivation = const Value.absent(),
                Value<int> baselineFrequency = const Value.absent(),
                Value<int> perceivedControl = const Value.absent(),
                Value<int> negativeImpact = const Value.absent(),
                Value<int> confidenceToChange = const Value.absent(),
                Value<String?> strategyIdsJson = const Value.absent(),
                Value<bool> dailyCheckInReminderEnabled = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => OnboardingDraftsCompanion.insert(
                id: id,
                goalId: goalId,
                assessmentId: assessmentId,
                currentStep: currentStep,
                goalType: goalType,
                weeklyLimit: weeklyLimit,
                contextKeysJson: contextKeysJson,
                motivation: motivation,
                baselineFrequency: baselineFrequency,
                perceivedControl: perceivedControl,
                negativeImpact: negativeImpact,
                confidenceToChange: confidenceToChange,
                strategyIdsJson: strategyIdsJson,
                dailyCheckInReminderEnabled: dailyCheckInReminderEnabled,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OnboardingDraftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OnboardingDraftsTable,
      OnboardingDraftRecord,
      $$OnboardingDraftsTableFilterComposer,
      $$OnboardingDraftsTableOrderingComposer,
      $$OnboardingDraftsTableAnnotationComposer,
      $$OnboardingDraftsTableCreateCompanionBuilder,
      $$OnboardingDraftsTableUpdateCompanionBuilder,
      (
        OnboardingDraftRecord,
        BaseReferences<_$AppDatabase, $OnboardingDraftsTable, OnboardingDraftRecord>,
      ),
      OnboardingDraftRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GoalsTableTableManager get goals => $$GoalsTableTableManager(_db, _db.goals);
  $$CopingStrategiesTableTableManager get copingStrategies => $$CopingStrategiesTableTableManager(_db, _db.copingStrategies);
  $$UrgeSessionsTableTableManager get urgeSessions => $$UrgeSessionsTableTableManager(_db, _db.urgeSessions);
  $$ConsumptionEventsTableTableManager get consumptionEvents => $$ConsumptionEventsTableTableManager(_db, _db.consumptionEvents);
  $$DailyCheckInsTableTableManager get dailyCheckIns => $$DailyCheckInsTableTableManager(_db, _db.dailyCheckIns);
  $$SelfAssessmentsTableTableManager get selfAssessments => $$SelfAssessmentsTableTableManager(_db, _db.selfAssessments);
  $$CopingStrategyUsesTableTableManager get copingStrategyUses => $$CopingStrategyUsesTableTableManager(_db, _db.copingStrategyUses);
  $$ModuleProgressTableTableManager get moduleProgress => $$ModuleProgressTableTableManager(_db, _db.moduleProgress);
  $$OnboardingDraftsTableTableManager get onboardingDrafts => $$OnboardingDraftsTableTableManager(_db, _db.onboardingDrafts);
}
