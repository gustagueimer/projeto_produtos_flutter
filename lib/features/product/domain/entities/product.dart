import 'dart:typed_data';

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final bool fav;
  final Uint8List? fotoBytes;
  
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    this.fav = false,
    this.fotoBytes,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? image,
    bool? fav,
    Uint8List? fotoBytes
  }){
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      fav: fav ?? this.fav,
      fotoBytes: fotoBytes ?? this.fotoBytes
    );
  }

  @override
  String toString() {
    bool isFotoBytes = false;
    if(fotoBytes != null) {
      isFotoBytes = true;
    }
    return "Product(id: $id, title: $title, price: $price, image: $image, fotoBytes: $isFotoBytes fav: $fav);";
  }
} 