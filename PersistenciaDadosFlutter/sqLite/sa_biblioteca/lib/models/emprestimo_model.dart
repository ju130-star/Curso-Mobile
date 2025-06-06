import 'package:intl/intl.dart';

class Emprestimo {
  final int? id;
  final int livroId; // FK para tabela Livro
  final DateTime dataEmprestimo;
  final DateTime previsaoDevolucao;
  final String nomeLocatario;
  final DateTime? dataDevolucao; // se null, ainda não foi devolvido

  Emprestimo({
    this.id,
    required this.livroId,
    required this.dataEmprestimo,
    required this.previsaoDevolucao,
    required this.nomeLocatario,
    this.dataDevolucao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'livro_id': livroId,
      'data_emprestimo': dataEmprestimo.toIso8601String(),
      'previsao_devolucao': previsaoDevolucao.toIso8601String(),
      'nome_locatario': nomeLocatario,
      'data_devolucao': dataDevolucao?.toIso8601String(),
    };
  }

  factory Emprestimo.fromMap(Map<String, dynamic> map) {
    return Emprestimo(
      id: map['id'] as int?,
      livroId: map['livro_id'] as int,
      dataEmprestimo: DateTime.parse(map['data_emprestimo']),
      previsaoDevolucao: DateTime.parse(map['previsao_devolucao']),
      nomeLocatario: map['nome_locatario'] as String,
      dataDevolucao: map['data_devolucao'] != null
          ? DateTime.parse(map['data_devolucao'])
          : null,
    );
  }

  String get status => dataDevolucao == null ? 'Emprestado' : 'Devolvido';

  String get dataEmprestimoFormatada =>
      DateFormat('dd/MM/yyyy').format(dataEmprestimo);

  String get previsaoFormatada =>
      DateFormat('dd/MM/yyyy').format(previsaoDevolucao);

  String get devolucaoFormatada => dataDevolucao != null
      ? DateFormat('dd/MM/yyyy').format(dataDevolucao!)
      : '---';
}
