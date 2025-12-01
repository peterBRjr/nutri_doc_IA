import 'package:flutter/material.dart';
import 'package:nutridoctor/classes/class.dart';

class AnalysisResultScreen extends StatelessWidget {
  final NutriDoctorAnalysis analysisResult;

  const AnalysisResultScreen({Key? key, required this.analysisResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise da Refeição'),
        backgroundColor: Color(0xFF285EA7),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crítica do NutriDoctor:',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                analysisResult.criticaGourmet,
                style: const TextStyle(
                    fontSize: 16.0, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Ingredientes Detalhados:',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 12.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: analysisResult.ingredientes.length,
              itemBuilder: (context, index) {
                final ingrediente = analysisResult.ingredientes[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ingrediente.nome,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          ingrediente.beneficios,
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
