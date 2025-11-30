import 'package:flutter/material.dart';
import 'imagem_viewer.dart';
import 'services/data_service.dart';

class ArmasPage extends StatelessWidget {
  const ArmasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final armas = DataService.data["armas"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 32, 133),
        title: const Text(
          'TALASSOFOBIA - ARMAS',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (final arma in armas) ...[
              _buildArmaBloco(context, arma),
              const SizedBox(height: 20),

              Center(
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.white.withOpacity(0.5),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    const Text('⭐'),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.white.withOpacity(0.5),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildArmaBloco(BuildContext context, Map arma) {
    final imagens = (arma["imagens"] as List)
        .map((img) => "assets/imagens/$img")
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImagemViewerPage(
                      imagens: imagens,
                      initialIndex: 0,
                    ),
                  ),
                );
              },
              child: Container(
                height: 170,
                width: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFF4C6FFF),
                  image: DecorationImage(
                    image: AssetImage(imagens[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('🐚 ', style: TextStyle(fontSize: 18)),
                      Text(
                        arma["nome"],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('🎯 ', style: TextStyle(fontSize: 18)),
                      Text(
                        arma["tipo"],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text('💥 ', style: TextStyle(fontSize: 18)),
                      Text(
                        'Sem habilidade específica',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),
        Text(
          arma["resumo"],
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3AF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'Curiosidade',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          arma["curiosidades"] ?? "",
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
