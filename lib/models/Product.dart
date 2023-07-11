import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String description;
  final String precautions;
  final String composition;
  final String usage;
  final String imageUrl;
  final String isPopular;
  final String contraindication;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isPopular = 'No',
    this.precautions = '',
    this.composition = '',
    this.usage = '',
    this.contraindication = '',
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      return Product(
        name: '',
        description: '',
        imageUrl: '',
      );
    }

    return Product(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      precautions: data['precautions'] ?? '',
      composition: data['composition'] ?? '',
      usage: data['usage'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      isPopular: data['isPopular'] ?? 'No',
      contraindication: data['contraindication'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'precautions': precautions,
      'composition': composition,
      'usage': usage,
      'imageUrl': imageUrl,
      'isPopular': isPopular,
      'contraindication': contraindication,
    };
  }
}
