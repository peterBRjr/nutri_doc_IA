import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {
  static const String _apiUrl = 'http://10.0.2.2:3000/api/analise';

  static Future<Map<String, dynamic>> analisarRefeicao(File imagem) async {
    final dio = Dio();

    String fileName = imagem.path.split('/').last;
    FormData formData = FormData.fromMap({
      'imagem': await MultipartFile.fromFile(
        imagem.path,
        filename: fileName,
      ),
    });

    try {
      final response = await dio.post(
        _apiUrl,
        data: formData,
        onSendProgress: (int sent, int total) {
          print('Progresso do upload: $sent / $total');
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Falha ao conectar com o servidor.');
      }
    } on DioException catch (e) {
      print('Erro de Dio: ${e.message}');
      throw Exception('Erro de rede: Não foi possível conectar ao servidor.');
    } catch (e) {
      print('Erro desconhecido: $e');
      throw Exception('Ocorreu um erro inesperado.');
    }
  }
}
