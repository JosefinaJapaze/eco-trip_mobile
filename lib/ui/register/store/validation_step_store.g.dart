// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_step_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ValidationStepStore on _ValidationStepStore, Store {
  late final _$successAtom =
      Atom(name: '_ValidationStepStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  @override
  String toString() {
    return '''
success: ${success}
    ''';
  }
}
