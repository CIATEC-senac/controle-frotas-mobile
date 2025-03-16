class User {
  // Atributos da classe User
  final String cpf;
  final String nome;
  final String cargo;

  // Construtor da classe User que requer cpf, senha e setor
  User({required this.cpf, required this.nome, required this.cargo});

  // Converte um JSON para um objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'cpf': String cpf, 'nome': String nome, 'cargo': String cargo} =>
        User(cpf: cpf, nome: nome, cargo: cargo),
      _ => throw const FormatException('Não foi possível buscar usuário.'),
    };
  }
}
