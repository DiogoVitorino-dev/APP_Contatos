import 'package:contatos_app/models/DatabaseContatoModel.dart';
import 'package:contatos_app/repository/database/InterfaceDatabaseRepository.dart';
import 'package:contatos_app/services/api/database/CustomDioDatabase.dart';

class DatabaseRepository implements InterfaceDatabaseRepository {
  @override
  Future<List<ContatoModel>> get({String? nome}) async {
    var dio = CustomDioDatabase().getInstance;
    var url = "/contatos";

    if (nome != null && nome.isNotEmpty) url += '?where={"nome":"$nome"}';

    var response = await dio.get(url);

    var data = DatabaseContatoModel.fromJson(response.data);
    return data.results;
  }

  @override
  Future<void> create(ContatoModel contato) async {
    var dio = CustomDioDatabase().getInstance;
    var url = "/contatos";

    await dio.post(url, data: contato.toJsonEndpoint());
  }

  @override
  Future<void> update(ContatoModel contato) async {
    var dio = CustomDioDatabase().getInstance;
    var url = "/contatos/${contato.objectId}";

    await dio.put(url, data: contato.toJsonEndpoint());
  }

  @override
  Future<void> delete(String id) async {
    var dio = CustomDioDatabase().getInstance;
    var url = "/contatos/$id";

    await dio.delete(url);
  }
}
