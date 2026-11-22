import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: ProfilePage()));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mon Profil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.notifications,
        //       color: Colors.white,
        //     ),
        //     tooltip: 'Notifications',
        //     onPressed: () {
        //       debugPrint('Notifications consultées');
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🔵 Stack en haut de la page : fond bleu clair + avatar centré
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0, 
                      child: Center(
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('assets/images/mon_image.jpeg'),
                        ),
                      ),
                    )
                  ]
                )),
              

              const SizedBox(height: 24), // espace sous le bandeau

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/mon_image.jpeg'),
                    // child: const Icon(Icons.person, color: Colors.blue),
                  ),
                  title: const Text(
                    'RAHEL Othmane',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      ' rahelothmane@gmail.com • Informatique • S5 • 123456789',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      debugPrint('Modifier le profil');
                    },
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                          'Informations personnelles',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              debugPrint('Modifier le profil');
                            },
                            child: Text('Modifier le profil'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              debugPrint('Contactez moi');
                            },
                            child: Text('Contacter'),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.badge, size: 20, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            'Nom : RAHEL Othmane',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Filière
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.school, size: 20, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            'Filière : Informatique',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Niveau
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.layers, size: 20, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            'Niveau : S5',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Email
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.email, size: 20, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            'Email : rahelothmane@gmail.com',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          
                          Icon(Icons.school, size: 20, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            'Année universitaire : 2026–2027',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),

                    

                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
  }
}