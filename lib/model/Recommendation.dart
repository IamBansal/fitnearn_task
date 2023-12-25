class Recommendation {
  final String title;
  final String desc;
  final String image;

  Recommendation({required this.title, required this.desc, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'image': image,
    };
  }
}
