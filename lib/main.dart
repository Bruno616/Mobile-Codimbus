import 'package:flutter/material.dart';
import 'services/data_service.dart';
import 'armas_page.dart';
import 'inimigos_page.dart';
import 'cenarios_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataService.loadData();
  runApp(const TalassofobiaApp());
}

class TalassofobiaApp extends StatelessWidget {
  const TalassofobiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talassofobia',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 189, 189, 189),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 6, 32, 133),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = DataService.data["telaInicial"];
    final historia = data["historia"];
    final dicas = data["dicas"];

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(
          'TALASSOFOBIA',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 6, 32, 133),
                image: DecorationImage(
                  image: AssetImage("assets/${historia["imagemCapa"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              historia["texto"],
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            Text(
              data["comoJogarTitulo"],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            for (var i = 0; i < dicas.length; i++) ...[
              _buildDica(dicas[i], invert: i == 1),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDica(Map dica, {bool invert = false}) {
    final img = Container(
      height: 180,
      width: 200,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 6, 32, 133),
        image: dica["imagem"] != null
            ? DecorationImage(
                image: AssetImage("assets/${dica["imagem"]}"),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );

    final txt = Expanded(
      child: Text(
        dica["texto"],
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: invert
          ? [txt, const SizedBox(width: 16), img]
          : [img, const SizedBox(width: 16), txt],
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 189, 189, 189),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 6, 32, 133)),
            child: const Center(
              child: Text(
                'MENU',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.construction, color: Colors.black),
            title: const Text('ARMAS'),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ArmasPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.pool, color: Colors.black),
            title: const Text('INIMIGOS'),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => const InimigosPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.landscape, color: Colors.black),
            title: const Text('CENÁRIO'),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CenariosPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title.toUpperCase(),
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Center(
        child: Text(
          '$title em desenvolvimento...',
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
