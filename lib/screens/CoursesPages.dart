import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final modules = [
    //   'Développement Multi-Plateforme',
    //   'Bases de données avancées',
    //   'Réseaux informatiques',
    //   'Intelligence artificielle',
    //   'Cybersécurité',
    //   'Gestion de projet',
    // ];
    final modules = [
      {'nom': 'Flutter', 'enseignant': 'Mme Aouraghe', 'heures': 32},
      {'nom': 'Réseaux', 'enseignant': 'M. Exemple', 'heures': 24},
    ]; // Aide
    return Scaffold(
      appBar: AppBar(title: const Text('Mes cours')),

      // body: ListView(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   children: [
      //     Text('Développement Multi-Plateforme'),
      //     SizedBox(height: 12),
      //     Text('Bases de données avancées'),
      //     SizedBox(height: 12),
      //     Text('Développement Web'),
      //     SizedBox(height: 12),
      //     Text('Génie logiciel'),
      //     SizedBox(height: 12),

      //     Card(
      //       elevation: 10,
      //       margin: const EdgeInsets.only(bottom: 20),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(50),
      //       ),
      //       child: const Padding(
      //         padding: EdgeInsets.all(16),
      //         child: Text('Développement Multi-Plateforme'),
      //       ),
      //     ),

      //     Card(
      //       child: ListTile(
      //         leading: const Icon(Icons.menu_book),
      //         title: const Text('Développement Multi-Plateforme'),
      //         subtitle: const Text('Enseignant : Mme Aouraghe'),
      //         trailing: const Icon(Icons.chevron_right),
      //         // onTap: () => {
      //         //   print("test test"),
      //         // },

      //         onTap: () {
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(content: Text('Module sélectionné')),
      //           );
      //         },
      //       ),
      //     ),

      //   ],
      // ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 20,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                      modules[index]['nom'].toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),     
              subtitle: Text(
                '${modules[index]['enseignant']}'
                ' • ${modules[index]['heures']} heures',
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Module sélectionné : ${modules[index]}'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}