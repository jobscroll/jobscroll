import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'favorite_screen.dart';

class JobListScreen extends StatefulWidget {
  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final List<Map<String, dynamic>> jobs = [
    {
      'title': 'Softwareentwickler',
      'company': 'Tech Corp',
      'location': 'Berlin',
      'description': 'Entwicklung und Wartung von Softwarelösungen.',
      'requirements': 'Erfahrung in Java und Flutter erforderlich.',
      'salary': '60.000€ - 80.000€',
      'isFavorite': false,
    },
    {
      'title': 'Projektmanager',
      'company': 'Innovate Ltd',
      'location': 'Hamburg',
      'description': 'Leitung und Koordination von Projekten.',
      'requirements': 'Erfahrung im Projektmanagement, bevorzugt in IT.',
      'salary': '50.000€ - 70.000€',
      'isFavorite': false,
    },
    {
      'title': 'Data Scientist',
      'company': 'DataWorks',
      'location': 'München',
      'description': 'Datenanalyse und Machine Learning Projekte.',
      'requirements': 'Kenntnisse in Python und Data Science Tools.',
      'salary': '70.000€ - 90.000€',
      'isFavorite': false,
    },
  ];

  List<Map<String, dynamic>> filteredJobs = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredJobs = List.from(jobs);
  }

  void toggleFavorite(String jobTitle) {
    setState(() {
      final index = jobs.indexWhere((job) => job['title'] == jobTitle);
      if (index != -1) {
        jobs[index]['isFavorite'] = !(jobs[index]['isFavorite'] as bool);
      }
      filteredJobs = List.from(jobs);
    });
  }

  void applyFilters(String? location, int? minSalary, int? maxSalary) {
    setState(() {
      filteredJobs = jobs.where((job) {
        final jobLocation = job['location'] as String;
        final jobSalary = int.parse(job['salary'].split('€')[0].replaceAll('.', '').trim());
        final matchesLocation = location == null || location.isEmpty || jobLocation.contains(location);
        final matchesMinSalary = minSalary == null || jobSalary >= minSalary;
        final matchesMaxSalary = maxSalary == null || jobSalary <= maxSalary;
        return matchesLocation && matchesMinSalary && matchesMaxSalary;
      }).toList();
    });
  }

  void applySearch(String query) {
    setState(() {
      searchQuery = query;
      filteredJobs = jobs.where((job) {
        final title = job['title'] as String;
        final company = job['company'] as String;
        return title.toLowerCase().contains(query.toLowerCase()) ||
            company.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'JobScroll',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              autofocus: false,
              onChanged: applySearch,
              decoration: InputDecoration(
                hintText: 'Suche nach Jobtitel oder Firma',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white54),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(
                    favoriteJobs: jobs.where((job) => job['isFavorite'] as bool).toList(),
                    toggleFavorite: toggleFavorite,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Filter-Dialog wird hier angezeigt
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredJobs.length,
        itemBuilder: (context, index) {
          final job = filteredJobs[index];
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
      ),
    );
  }
}
