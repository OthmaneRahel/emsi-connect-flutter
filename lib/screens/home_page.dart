import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
    const HomePage({super.key});

    @override
    Widget build(BuildContext context){
        return Scaffold(
        appBar : AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
              'EMSI Connect',  
              style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                    debugPrint('Notification consultees');
                },
            ),
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                    debugPrint('Settings clicked');
                },
            ),
          ],
        ),
            
        body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
            Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Image.asset(
                'assets/images/emsi.webp',
                height: 160,
                fit: BoxFit.cover,
                ),

              const SizedBox(height: 24),

                const Text(
                'Bienvenue sur EMSI Connect',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                ),
                ),

              const SizedBox(height: 8),
              const Text(
                'Apprendre, organiser, réussir — ensemble.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),

                const SizedBox(height: 20),

                const Text(
                'Votre espace universitaire pour accéder à vos cours, '
                'votre planning et vos informations personnelles.',
                textAlign: TextAlign.center,
                ),
  
                const SizedBox(height: 50),                

                Row(
                children: [
                    Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 138, 206, 255),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.blue.shade100,
                        ),
                        ),
                        child: const Column(
                        children: [
                            Icon(Icons.menu_book, size: 40),
                            SizedBox(height: 8),
                            Text(
                            'Mes cours',
                            textAlign: TextAlign.center,
                            ),
                        ],
                        ),
                    ),
                    ),

                    const SizedBox(width: 12),

                    Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 138, 206, 255),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.blue.shade100,
                        ),
                        ),
                        child: const Column(
                        children: [
                            Icon(Icons.calendar_month, size: 40),
                            SizedBox(height: 8),
                            Text(
                            'Planning',
                            textAlign: TextAlign.center,
                            ),
                        ],
                        ),
                    ),
                    ),
                ],
                ),

                const SizedBox(height: 12),

               
                Row(
                children: [
                    Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 138, 206, 255),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.blue.shade100,
                        ),
                        ),
                        child: const Column(
                        children: [
                            Icon(Icons.person, size: 40),
                            SizedBox(height: 8),
                            Text(
                            'Mon profil',
                            textAlign: TextAlign.center,
                            ),
                        ],
                        ),
                    ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 138, 206, 255),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.blue.shade100,
                          ),
                        ),
                        child: const Column(
                        children: [
                            Icon(Icons.task_alt, size: 40),
                            SizedBox(height: 8),
                            Text(
                            'Mes tâches',
                            textAlign: TextAlign.center,
                            ),
                        ],
                        ),
                    ),
                    ),
                ],
                ),

                
            ],
            ),
        ),
        ),
         
         floatingActionButton: FloatingActionButton(
            onPressed: () {
                debugPrint('Fonctionnalité bientôt disponible');
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            tooltip: 'Ajouter',
            child: const Icon(Icons.add),
            ),



        );
        

        
    }

}