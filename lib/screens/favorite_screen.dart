import 'package:flutter/material.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteJobs;
  final Function(String) toggleFavorite;

  FavoriteScreen({required this.favoriteJobs, required this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoriten'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: favoriteJobs.isNotEmpty
          ? ListView.builder(
        itemCount: favoriteJobs.length,
        itemBuilder: (context, index) {
          final job = favoriteJobs[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              title: Text(
                job['title'] ?? 'Titel unbekannt',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${job['company'] ?? 'Firma unbekannt'} - ${job['location'] ?? 'Ort unbekannt'}'),
                  SizedBox(height: 5),
                  Text(job['salary'] ?? 'Gehalt nicht angegeben'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: (job['isFavorite'] as bool) ? Colors.red : Colors.grey,
                ),
                onPressed: () => toggleFavorite(job['title'] ?? ''),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      jobTitle: job['title'] ?? 'Unbekannt',
                      company: job['company'] ?? 'Unbekannt',
                      location: job['location'] ?? 'Unbekannt',
                      description: job['description'] ?? 'Keine Beschreibung',
                      requirements: job['requirements'] ?? 'Keine Anforderungen',
                      salary: job['salary'] ?? 'Keine Angabe',
                      isFavorite: job['isFavorite'] as bool,
                      toggleFavorite: () => toggleFavorite(job['title'] ?? ''),
                    ),
                  ),
                );
              },
            ),
          );
        },
      )
          : Center(
        child: Text('Keine Favoriten hinzugefügt'),
      ),
    );
  }
}
