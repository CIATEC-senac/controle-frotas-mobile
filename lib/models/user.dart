class UserModel {
  final int id;
  final String name;
  final String? email;
  final String? cpf;
  final String? role;

  const UserModel({
    required this.id,
    required this.name,
    this.email,
    this.cpf,
    this.role,
  });

  // Método estático que capitaliza cada palavra de uma string
  static String _capitalize(String s) {
    return s
        // Separa a string em palavras, usa o espaço como separador
        .split(' ')
        // Garante que strings vazias não sejam processadas
        .where((ss) => s.isNotEmpty)
        // Coloca a primeira letra em maiúscula
        .map((ss) => ss[0].toUpperCase() + ss.substring(1))
        // Junta as palavras em espaços
        .join(' ');
  }

  // Cria uma instância de UserModel a partir de um json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Validação de tipos
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'email': String? email,
        'cpf': String cpf,
        'role': int role,
      } =>
        // Cria e retorna um UserModel com os dados extraídos
        UserModel(
          id: id,
          name: UserModel._capitalize(name),
          email: email,
          cpf: cpf,
          role: switch (role) {
            0 => 'Administrador',
            1 => 'Gestor',
            2 => 'Motorista',
            _ => 'Desconhecido'
          },
        ),
      {
        'id': int id,
        'name': String name,
      } =>
        // Cria e retorna um UserModel com os dados extraídos
        UserModel(
          id: id,
          name: UserModel._capitalize(name),
        ),
      // Gerando uma exceção
      _ => throw const FormatException('Erro ao buscar usuário.'),
    };
  }
}
