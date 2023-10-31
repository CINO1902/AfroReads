import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestion = [
      'On my way',
      'In the middle',
      'what little doesn it offer',
      'The girl who lost the source',
      'Dazzling mirage'
    ];

    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (context, index) {
        final suggesstion = suggestion[index];
        return ListTile(
          title: Text(suggesstion),
          onTap: () {
            query = suggesstion;
            showResults(context);
            FocusScope.of(context).unfocus();
          },
        );
      },
    );
  }
}
