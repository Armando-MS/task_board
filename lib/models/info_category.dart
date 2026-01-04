class InfoCategory {
  final int id;
  final String name;
  final String image;
  final String slug;

  InfoCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  });

  factory InfoCategory.fromJson(Map<String, dynamic> json) {
    return InfoCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin categoría',
      image: json['image'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}