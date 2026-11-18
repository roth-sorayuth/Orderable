

import 'package:orderly/models/order_item.dart';
import 'package:orderly/models/restaurant_table.dart';
import 'package:orderly/models/payment.dart';

enum OrderStatus {open, paid, cancelled}

class Order {

  final String id;
   int discountPercent;

  final RestaurantTable table;

  List<OrderItem> items = [];

  OrderStatus status;

  Payment? payment;


  Order({required this.id, required this.table, this.status = OrderStatus.open, this.payment, this.discountPercent=0,});

}