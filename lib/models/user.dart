class UserModel {
  final int id;
  final String name;
  final String? email;
  final String cpf;
  final String cargo;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.cpf,
    required this.cargo,
  });

  static String _capitalize(String s) {
    return s
        .split(' ')
        .where((ss) => s.isNotEmpty)
        .map((ss) => ss[0].toUpperCase() + ss.substring(1))
        .join(' ');
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String name,
        'email': String? email,
        'cpf': String cpf,
        'cargo': String cargo,
      } =>
        UserModel(
            id: id,
            name: UserModel._capitalize(name),
            email: email,
            cpf: cpf,
            cargo: UserModel._capitalize(cargo)),
      _ => throw const FormatException('Erro ao buscar usuário.'),
    };
  }
}
