class User {
  // Atributos da classe User
  final String cpf;
  final String senha;
  final String setor;

  // Construtor da classe User que requer cpf, senha e setor
  User({required this.cpf, required this.senha, required this.setor});

  // Converte um JSON para um objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // Converte os dados JSON para os atributos da classe
      cpf: json['cpf'],
      senha: json['senha'],
      setor: json['setor'],
    );
  }
}
