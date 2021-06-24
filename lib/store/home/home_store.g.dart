// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$successAtom = Atom(name: '_HomeStore.success');

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

  final _$loadingAtom = Atom(name: '_HomeStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$controllerAtom = Atom(name: '_HomeStore.controller');

  @override
  ScrollController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(ScrollController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  final _$fabIsVisibleAtom = Atom(name: '_HomeStore.fabIsVisible');

  @override
  bool get fabIsVisible {
    _$fabIsVisibleAtom.reportRead();
    return super.fabIsVisible;
  }

  @override
  set fabIsVisible(bool value) {
    _$fabIsVisibleAtom.reportWrite(value, super.fabIsVisible, () {
      super.fabIsVisible = value;
    });
  }

  final _$socialLinkAgentAtom = Atom(name: '_HomeStore.socialLinkAgent');

  @override
  List<String> get socialLinkAgent {
    _$socialLinkAgentAtom.reportRead();
    return super.socialLinkAgent;
  }

  @override
  set socialLinkAgent(List<String> value) {
    _$socialLinkAgentAtom.reportWrite(value, super.socialLinkAgent, () {
      super.socialLinkAgent = value;
    });
  }

  final _$logoutAsyncAction = AsyncAction('_HomeStore.logout');

  @override
  Future logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void updateScrolling() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.updateScrolling');
    try {
      return super.updateScrolling();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disposeController() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.disposeController');
    try {
      return super.disposeController();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
loading: ${loading},
controller: ${controller},
fabIsVisible: ${fabIsVisible},
socialLinkAgent: ${socialLinkAgent}
    ''';
  }
}
