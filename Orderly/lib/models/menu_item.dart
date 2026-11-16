

class MenuItem{

  final String id;
  final String name;
  final String category;
  double price;

  bool isAvailable;

  MenuItem({required this.id, required this.name, required this.category, required this.price, this.isAvailable = true});
}