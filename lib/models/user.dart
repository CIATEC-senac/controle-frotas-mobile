enum UserRole { admin, manager, driver }

class UserModel {
  final int id;
  final String name;
  final String? email;
  final String? cpf;
  final UserRole? role;
  final String cnh;

  const UserModel({
    required this.id,
    required this.name,
    this.email,
    this.cpf,
    this.role,
    required this.cnh,
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

  String getStringRole() {
    return switch (role) {
      UserRole.admin => 'Administrador',
      UserRole.manager => 'Gestor',
      UserRole.driver => 'Motorista',
      _ => 'Desconhecido'
    };
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'role': getStringRole()};
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
        'cnh': String cnh,
      } =>
        // Cria e retorna um UserModel com os dados extraídos
        UserModel(
          id: id,
          cnh: cnh,
          name: UserModel._capitalize(name),
          email: email,
          cpf: cpf,
          role: switch (role) {
            0 => UserRole.admin,
            1 => UserRole.manager,
            2 => UserRole.driver,
            _ => throw Exception('Role: ${role} desconhecida'),
          },
        ),
      {
        'id': int id,
        'name': String name,
        'cnh': String cnh,
        'cpf': String cpf,
      } =>
        // Cria e retorna um UserModel com os dados extraídos
        UserModel(
          id: id,
          name: UserModel._capitalize(name),
          cnh: cnh,
          cpf: cpf,
        ),
      // Gerando uma exceção
      _ => throw const FormatException('Erro ao buscar usuário.'),
    };
  }
}
