import 'info_category.dart'; // Importante para conectar los modelos

class InfoProduct {
  final int id;
  final String title;
  final String slug;
  final int price;
  final String description;
  final InfoCategory category; // Usamos el nuevo modelo aquí
  final List<String> images;

  InfoProduct({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  factory InfoProduct.fromJson(Map<String, dynamic> json) {
    return InfoProduct(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Sin título',
      slug: json['slug'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      // Llamamos al factory del modelo de categoría
      category: InfoCategory.fromJson(json['category'] ?? {}),
      images: (json['images'] as List? ?? []).map((e) {
        return e.toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll('"', '')
            .trim();
      }).toList(),
    );
  }
}