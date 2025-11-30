import 'package:flutter/material.dart';
import 'imagem_viewer.dart';
import 'services/data_service.dart';

class CenariosPage extends StatelessWidget {
  const CenariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cenarios = DataService.data["cenarios"] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 14, 40, 141),
        title: const Text(
          'TALASSOFOBIA - CENÁRIOS',
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
            for (final cenario in cenarios) ...[
              _buildCenarioBloco(context, cenario),
              const SizedBox(height: 20),
              _divider(),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
  Widget _divider() {
    return Center(
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
    );
  }

  Widget _buildCenarioBloco(BuildContext context, Map cenario) {
    final imagens = [
      "assets/imagens/${cenario["imagem"]}"
    ];

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
                      Expanded(
                        child: Text(
                          cenario["nome"] ?? "Sem nome",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          cenario["descricao"] ?? "Sem descrição",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16),
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
          cenario["descricao"] ?? "Sem descrição",
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 15),
        ),

        const SizedBox(height: 20),

        if (cenario["curiosidade"] != null) ...[
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
            cenario["curiosidade"]!,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ],
    );
  }
}
