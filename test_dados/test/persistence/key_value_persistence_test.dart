import 'package:flutter_test/flutter_test.dart';
import 'package:test_dados/persistence/key_value_persistence.dart';

void main() {
  String texto = '';

  setUpAll(() {
    texto = 'TEXTO DE TESTE';
  });

  group('KeyValuePersistence', () {
    test('Salvar um texto', () async {
      var persist = KeyValuePersistence();
      await persist.save(texto);
    });

    test('Ler um texto', () async {
      var persist = KeyValuePersistence();
      var content = await persist.load();
      assert(content == texto);
    });
  });
}
