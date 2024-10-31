import 'package:flutter/material.dart';

void showFilterDialog(
    BuildContext context,
    Function(String?, int?, int?, String) applyFilters,
    ) {
  String? selectedLocation;
  int? minSalary;
  int? maxSalary;
  String sortBy = 'title';

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Filter anwenden'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Ort'),
            onChanged: (value) {
              selectedLocation = value;
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Min. Gehalt'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              minSalary = int.tryParse(value);
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Max. Gehalt'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              maxSalary = int.tryParse(value);
            },
          ),
          DropdownButton<String>(
            value: sortBy,
            onChanged: (String? newValue) {
              sortBy = newValue!;
            },
            items: <String>['title', 'location']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value == 'title' ? 'Nach Titel sortieren' : 'Nach Standort sortieren'),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            applyFilters(selectedLocation, minSalary, maxSalary, sortBy);
            Navigator.of(ctx).pop();
          },
          child: Text('Anwenden'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: Text('Abbrechen'),
        ),
      ],
    ),
  );
}
