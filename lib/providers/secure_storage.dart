import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'secure_storage.g.dart';

enum SecureStorageKeys {
  authToken,
}

@riverpod
class SecureStorage extends _$SecureStorage {
  final _storage = const FlutterSecureStorage();

  @override
  FutureOr<Map<SecureStorageKeys, String?>> build() async {
    Map<SecureStorageKeys, String?> values = {};
    for (final key in SecureStorageKeys.values) {
      values[key] = await _storage.read(key: _keyName(key));
    }
    state = AsyncValue.data(values);
    return values;
  }

  /// Use this when you want to guarantee access to a specific
  /// key and need to `await` on said process.
  Future<String?> read(SecureStorageKeys key) async {
    final value = await _storage.read(key: _keyName(key));

    // FIXME: Revisit this later. We may possibly need to set
    // the data value in the state itself here, if it is possible
    // to do so.

    return value;
  }

  Future<void> setStorageValue(SecureStorageKeys key, String? value) async {
    if (value != null) {
      await _storage.write(key: _keyName(key), value: value);
    } else {
      await _storage.delete(key: _keyName(key));
    }

    var stateCopy = state.requireValue;
    stateCopy[key] = value;
    state = AsyncValue.data(stateCopy);
  }

  String _keyName(SecureStorageKeys key) {
    switch (key) {
      case SecureStorageKeys.authToken:
        return 'authToken';
    }
  }
}
