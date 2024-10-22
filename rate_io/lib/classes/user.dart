class UserSystem {
  String? id;
  String nome;
  String email;
  String telefone;
  DateTime dataNascimento; // Use um formato de data apropriado
  String faculdade;
  String curso;
  String sexo;

  UserSystem({
    this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.dataNascimento,
    required this.faculdade,
    required this.curso,
    required this.sexo,
  });
  // essa esta com os valores certinhos por que já estamos usando ela no projeto enzo :)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'dataNascimento': dataNascimento,
      'faculdade': faculdade,
      'curso': curso,
      'sexo': sexo,
    };
  }

  factory UserSystem.fromMap(Map<String, dynamic> map) {
    return UserSystem(
        id: map['id'],
        nome: map['nome'],
        email: map['email'],
        telefone: map['telefone'],
        dataNascimento: map['dataNascimento'],
        faculdade: map['faculdade'],
        curso: map['curso'],
        sexo: map['sexo']
    );
  }
}
