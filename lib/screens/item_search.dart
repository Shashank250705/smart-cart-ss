import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bloc_flutter/screens/product_details.dart';

//itemsearch
class ItemSearch extends SearchDelegate<String> {
  final List<Map<String, dynamic>> items;

  ItemSearch(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Map<String, dynamic>> results = items
        .where((item) => (item['name'] ?? '')
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]['name'] ?? 'Unknown'),
          subtitle: Text('₹${results[index]['price']?.toString() ?? '0.0'}'),
          leading: _buildImage(results[index]['photo']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsPage(product: results[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<String, dynamic>> suggestions = items
        .where((item) => (item['name'] ?? '')
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]['name'] ?? 'Unknown'),
          subtitle:
              Text('₹${suggestions[index]['price']?.toString() ?? '0.0'}'),
          leading: _buildImage(suggestions[index]['photo']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsPage(product: suggestions[index]),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildImage(String? photoUrl) {
    if (photoUrl != null && photoUrl.startsWith('http')) {
      return Image.network(
        photoUrl,
        width: 50,
        height: 50,
        fit: BoxFit.fitHeight,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image);
        },
      );
    } else if (photoUrl != null) {
      return Image.file(
        File(photoUrl),
        width: 50,
        height: 50,
        fit: BoxFit.fitHeight,
      );
    } else {
      return const Icon(Icons.image);
    }
  }
}
