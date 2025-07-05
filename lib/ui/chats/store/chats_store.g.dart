// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatsStore on _ChatsStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_ChatsStore.isLoading'))
      .value;

  late final _$successAtom =
      Atom(name: '_ChatsStore.success', context: context);

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

  late final _$chatsFutureAtom =
      Atom(name: '_ChatsStore.chatsFuture', context: context);

  @override
  ObservableFuture<List<Chat>> get chatsFuture {
    _$chatsFutureAtom.reportRead();
    return super.chatsFuture;
  }

  @override
  set chatsFuture(ObservableFuture<List<Chat>> value) {
    _$chatsFutureAtom.reportWrite(value, super.chatsFuture, () {
      super.chatsFuture = value;
    });
  }

  late final _$fetchChatsAsyncAction =
      AsyncAction('_ChatsStore.fetchChats', context: context);

  @override
  Future<List<Chat>> fetchChats() {
    return _$fetchChatsAsyncAction.run(() => super.fetchChats());
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('_ChatsStore.sendMessage', context: context);

  @override
  Future<bool> sendMessage(String chatId, String message) {
    return _$sendMessageAsyncAction
        .run(() => super.sendMessage(chatId, message));
  }

  late final _$_ChatsStoreActionController =
      ActionController(name: '_ChatsStore', context: context);

  @override
  void setSuccess(bool value) {
    final _$actionInfo = _$_ChatsStoreActionController.startAction(
        name: '_ChatsStore.setSuccess');
    try {
      return super.setSuccess(value);
    } finally {
      _$_ChatsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
chatsFuture: ${chatsFuture},
isLoading: ${isLoading}
    ''';
  }
}
