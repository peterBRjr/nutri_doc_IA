class CadastroUsuario {
  final String nome;
  final String dataNascimento;
  final String cpf;
  final String senha;

  CadastroUsuario({
    required this.nome,
    required this.dataNascimento,
    required this.cpf,
    required this.senha,
  });

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'dataNascimento': dataNascimento,
        'cpf': cpf,
        'senha': senha,
      };

  factory CadastroUsuario.fromJson(Map<String, dynamic> json) =>
      CadastroUsuario(
        nome: json['nome'] as String,
        dataNascimento: json['dataNascimento'] as String,
        cpf: json['cpf'] as String,
        senha: json['senha'] as String,
      );
}
