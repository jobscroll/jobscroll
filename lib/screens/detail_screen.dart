import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String location;
  final String description;
  final String requirements;
  final String salary;
  final bool isFavorite;
  final VoidCallback toggleFavorite;

  DetailScreen({
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.description,
    required this.requirements,
    required this.salary,
    required this.isFavorite,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(jobTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("$company - $location"),
            SizedBox(height: 10),
            Text("Beschreibung:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(description),
            SizedBox(height: 10),
            Text("Anforderungen:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(requirements),
            SizedBox(height: 10),
            Text("Gehalt: $salary"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: toggleFavorite,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for applying to the job
                  },
                  child: Text("Jetzt Bewerben"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
