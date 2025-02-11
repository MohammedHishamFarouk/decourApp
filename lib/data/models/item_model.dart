class ItemModel{
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;

  ItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
  });

  factory ItemModel.fromJson(Map<String,dynamic>jsonData){
    return ItemModel(
        id: jsonData["id"],
      title: jsonData["title"],
      price: jsonData["price"],
      description: jsonData["description"],
        images: List<String>.from(jsonData["images"]),
    );
  }

}