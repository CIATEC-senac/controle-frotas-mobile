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
    try {
      return UserModel(
        id: json['id'],
        cnh: json['cnh'],
        name: UserModel._capitalize(json['name']),
        email: json['email'],
        cpf: json['cpf'],
        role: json['role'] != null
            ? switch (json['role']) {
                0 => UserRole.admin,
                1 => UserRole.manager,
                2 => UserRole.driver,
                _ => throw Exception('Role: ${json['role']} desconhecida'),
              }
            : null,
      );
    } catch (e) {
      throw FormatException('Erro ao parsear usuário: ${e.toString()}');
    }
  }
}
