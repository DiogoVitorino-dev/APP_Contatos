class DatabaseContatoModel {
  List<ContatoModel> results = [];

  DatabaseContatoModel(this.results);

  DatabaseContatoModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ContatoModel>[];
      json['results'].forEach((v) {
        results.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
      return data;
  }
}

class ContatoModel {
  String objectId = "";
  String createdAt = "";
  String updatedAt = "";
  late String nome;
  late int telefone;
  late String email;
  late String profilePath;

  ContatoModel(this.objectId, this.nome, this.telefone, this.email,
      this.profilePath, this.createdAt, this.updatedAt);

  ContatoModel.create(
    this.nome,
    this.telefone,
    this.email,
    this.profilePath,
  );

  ContatoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nome = json['nome'];
    telefone = json['telefone'];
    email = json['email'];
    profilePath = json['profilePath'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  ContatoModel.fromJsonEndpoint(Map<String, dynamic> json) {
    nome = json['nome'];
    telefone = json['telefone'];
    email = json['email'];
    profilePath = json['profilePath'];
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['email'] = email;
    data['profilePath'] = profilePath;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['email'] = email;
    data['profilePath'] = profilePath;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
