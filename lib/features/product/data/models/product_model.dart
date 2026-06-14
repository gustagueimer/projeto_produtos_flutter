class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  bool fav;
    
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    this.fav = false,
  });

  void changeFav() {
    if(fav == false) {
      fav = true;
      return;
    }
    fav = false;
  }
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"].toDouble(),
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'title':title,
      'description':description,
      'price':price,
      'category':'lmao',
      'image':Uri.parse(image).toString(),
    };
  }
}