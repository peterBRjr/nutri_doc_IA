import 'dart:convert';

NutriDoctorAnalysis nutriDoctorAnalysisFromJson(String str) =>
    NutriDoctorAnalysis.fromJson(json.decode(str));

String nutriDoctorAnalysisToJson(NutriDoctorAnalysis data) =>
    json.encode(data.toJson());

class NutriDoctorAnalysis {
  final String criticaGourmet;
  final List<Ingrediente> ingredientes;

  NutriDoctorAnalysis({
    required this.criticaGourmet,
    required this.ingredientes,
  });

  factory NutriDoctorAnalysis.fromJson(Map<String, dynamic> json) {
    var ingredientesList = json['ingredientes'] as List;

    List<Ingrediente> ingredientesConvertidos = ingredientesList
        .map((item) => Ingrediente.fromJson(item as Map<String, dynamic>))
        .toList();

    return NutriDoctorAnalysis(
      criticaGourmet: json['criticaGourmet'] as String,
      ingredientes: ingredientesConvertidos,
    );
  }

  Map<String, dynamic> toJson() => {
        'criticaGourmet': criticaGourmet,
        'ingredientes': List<dynamic>.from(ingredientes.map((x) => x.toJson())),
      };
}

class Ingrediente {
  final String nome;
  final String beneficios;

  Ingrediente({
    required this.nome,
    required this.beneficios,
  });

  factory Ingrediente.fromJson(Map<String, dynamic> json) => Ingrediente(
        nome: json['nome'] as String,
        beneficios: json['beneficios'] as String,
      );

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'beneficios': beneficios,
      };
}
