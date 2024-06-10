// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authHash() => r'a01e3fcf8d5af54fac03c4979b4327371a93a181';

/// See also [auth].
@ProviderFor(auth)
final authProvider = AutoDisposeProvider<FirebaseAuth>.internal(
  auth,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRef = AutoDisposeProviderRef<FirebaseAuth>;
String _$dbHash() => r'5d14ebf8bc1822c1b584463768b4145c9036f984';

/// See also [db].
@ProviderFor(db)
final dbProvider = AutoDisposeProvider<FirebaseFirestore>.internal(
  db,
  name: r'dbProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dbHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DbRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$aiHash() => r'76c4c2129665c9f21193f19422df44385669029c';

/// See also [ai].
@ProviderFor(ai)
final aiProvider = AutoDisposeProvider<GenerativeModel>.internal(
  ai,
  name: r'aiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$aiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AiRef = AutoDisposeProviderRef<GenerativeModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
