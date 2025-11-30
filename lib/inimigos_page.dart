import 'package:flutter/material.dart';
import 'imagem_viewer.dart';
import 'services/data_service.dart';

class InimigosPage extends StatelessWidget {
  const InimigosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inimigos = DataService.data["inimigos"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 30, 119),
        title: const Text(
          'TALASSOFOBIA - INIMIGOS',
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
            for (final inimigo in inimigos) ...[
              _buildInimigoBloco(context, inimigo),
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
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInimigoBloco(BuildContext context, Map inimigo) {
    final imagens = (inimigo["imagens"] as List)
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
                  color: const Color.fromARGB(255, 4, 32, 145),
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
                        inimigo["nome"],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('🎯 ', style: TextStyle(fontSize: 18)),
                      Text(
                        inimigo["dificuldade"],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('💥 ', style: TextStyle(fontSize: 18)),
                      Expanded(
                        child: Text(
                          inimigo["habilidades"],
                          style: const TextStyle(fontSize: 18),
                        ),
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
          inimigo["resumo"],
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
          inimigo["curiosidade"],
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
