import 'package:flutter/material.dart';
import 'screens/job_list_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/detail_screen.dart';

void main() {
  runApp(JobStreamApp());
}

class JobStreamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobStream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => JobListScreen(),
        '/favorites': (context) => FavoriteScreen(
          favoriteJobs: [],
          toggleFavorite: (title) {},
        ),
        '/detail': (context) => DetailScreen(
          jobTitle: '',
          company: '',
          location: '',
          description: '',
          requirements: '',
          salary: '',
          isFavorite: false,
          toggleFavorite: () {},
        ),
      },
    );
  }
}
