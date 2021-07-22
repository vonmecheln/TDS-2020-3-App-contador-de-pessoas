import 'package:flutter_test/flutter_test.dart';
import 'package:test_dados/persistence/sqlite_persistence.dart';

void main() {
  String texto = '';

  setUpAll(() {
    texto = 'TEXTO DE TESTE';
  });

  group('SqlitePersistence', () {
    test('Salvar um texto', () async {
      var persist = await SqlitePersistence();
      await persist.save(texto);
    });

    test('Ler um texto', () async {
      var persist = await SqlitePersistence();
      var content = await persist.load();
      assert(content == texto);
    });
  });
}
