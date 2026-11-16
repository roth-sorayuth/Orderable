 import 'package:orderly/models/menu_item.dart';

class OrderItem {


  final String id;
  final MenuItem menuItem;

  final double priceSnapshot;

  int quantity;


  OrderItem({required this.id, required this.menuItem, required this.priceSnapshot, required this.quantity});


 }