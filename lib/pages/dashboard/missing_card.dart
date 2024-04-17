import 'package:flutter/material.dart';
import 'package:hanap_app/models/models.dart';

class MissingCard extends StatelessWidget {
  const MissingCard({super.key, required this.missing});

  final Content missing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Hero(
          tag: 'missingImage${missing.name}',
          child: missing.imageUrls.isNotEmpty
              ? Image.network(
                  missing.imageUrls.first,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey, // Placeholder color
                ),
        ),
        title: Text(missing.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Age: ${missing.age}'),
            Text('Last Seen: ${missing.lastSeen.toString()}'),
            Text('Description: ${missing.description}'),
          ],
        ),
        trailing: Text(
          'Bounty: ${missing.bounty}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green, // Adjust color as needed
          ),
        ),
      ),
    );
  }
}
