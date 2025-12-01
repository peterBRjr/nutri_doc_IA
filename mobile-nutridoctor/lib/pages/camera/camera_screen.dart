import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutridoctor/API/api_service.dart';
import 'package:nutridoctor/classes/class.dart';
import 'package:nutridoctor/pages/retorno/retorno.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _imagemSelecionada;
  bool _estaCarregando = false;

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final XFile? fotoTirada = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (fotoTirada != null) {
      setState(() {
        _imagemSelecionada = File(fotoTirada.path);
      });
    }
  }

  Future<void> _analisarFoto() async {
    if (_imagemSelecionada == null) return;

    setState(() {
      _estaCarregando = true;
    });

    try {
      final Map<String, dynamic> resultado =
          await ApiService.analisarRefeicao(_imagemSelecionada!);
      _mostrarResultado(resultado);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _estaCarregando = false;
      });
    }
  }

  void _mostrarResultado(Map<String, dynamic> resultado) {
    const jsonEncoder = JsonEncoder.withIndent('  ');
    final String jsonBonito = jsonEncoder.convert(resultado);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AnalysisResultScreen(
          analysisResult: nutriDoctorAnalysisFromJson(jsonBonito),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutri Doctor IA - Câmera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _imagemSelecionada != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _imagemSelecionada!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Tire uma foto da sua refeição',
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
            const SizedBox(height: 30),
            if (_imagemSelecionada != null && !_estaCarregando)
              ElevatedButton.icon(
                icon: const Icon(Icons.analytics_outlined),
                label: const Text('Analisar Refeição'),
                onPressed: _analisarFoto,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            if (_estaCarregando) const CircularProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _estaCarregando ? null : _tirarFoto,
        tooltip: 'Tirar Foto',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
