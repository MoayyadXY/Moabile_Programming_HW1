import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets.dart';

// About section
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Made by Moayad Moatamed Aboulila & Haitham M M Shehada'),
    );
  }
}

// People section
class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  final List<Map<String, String>> instructors = const [
    {
      'name': 'Dr. Öğr. Üyesi Murat ÖZTÜRK',
      'phone': '05054128736',
      'email': 'ozturev@sektehr.edu.sz',
      'id': 'CMM 0002: 92 92 93',
    },
    {
      'name': 'Doç. Dr. Emre KARAHAN',
      'phone': '05316248925',
      'email': 'kazinav@sektehr.edu.sz',
      'id': 'CMM 0002: 94 92 95',
    },
    {
      'name': 'Dr. Öğr. Üyesi Hakan YILDIZ',
      'phone': '05412976382',
      'email': 'hyildiz@sektehr.edu.sz',
      'id': 'CMM 0002: 96 92 97',
    },
  ];

  Future<void> _askToCall(
    BuildContext context,
    String name,
    String phone,
  ) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Dial a Number'),
        content: Text('Would you like to call $name?\n$phone'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              final url = Uri(scheme: 'tel', path: phone);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: instructors.map((p) {
        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.person, size: 40, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p['email']!,
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p['id']!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      FullWidthButton(
                        onPressed: () =>
                            _askToCall(context, p['name']!, p['phone']!),
                        text: 'CALL',
                        color: Colors.grey[300]!,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// iNfrastructure section
class InfrastructurePage extends StatelessWidget {
  const InfrastructurePage({super.key});

  final List<Map<String, dynamic>> classes = const [
    {
      'name': 'Derslik-B1',
      'capacity': 36,
      'image':
          'https://www.teachhub.com/wp-content/uploads/2020/05/Classroom-Management-for-an-Effective-Learning-Environment-768x512.jpg',
    },
    {
      'name': 'Derslik-B2',
      'capacity': 15,
      'image':
          'https://www.teachhub.com/wp-content/uploads/2020/05/Classroom-Management-for-an-Effective-Learning-Environment-768x512.jpg',
    },
    {
      'name': 'Derslik-B3',
      'capacity': 18,
      'image':
          'https://www.teachhub.com/wp-content/uploads/2020/05/Classroom-Management-for-an-Effective-Learning-Environment-768x512.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (context, i) {
        final c = classes[i];
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              '${c['name']}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text('Kapasite: ${c['capacity']}'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImagePage(imageUrl: c['image'] as String),
              ),
            ),
          ),
        );
      },
    );
  }
}

// iMAGE
class ImagePage extends StatelessWidget {
  final String imageUrl;
  const ImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Classroom Image'),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          boundaryMargin: const EdgeInsets.all(20),
          minScale: 0.5,
          maxScale: 3.0,
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
