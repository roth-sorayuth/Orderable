import 'package:orderly/models/order.dart';
import 'package:orderly/models/restaurant_table.dart';
import 'package:orderly/models/order_item.dart';

class OrderService {
  List<Order> orders = [];

  void createOrder({required String orderId, required RestaurantTable table}) {
    // table must be available
    if (table.status != TableStatus.available) {
      throw Exception('Table ${table.id} is not available.');
    }
    Order? order = _findOrderOrNull(orderId: orderId);
    if (order != null) {
      throw Exception('Order with id $orderId already exists.');
    }

    orders.add(Order(id: orderId, table: table));
    table.status = TableStatus.occupied;
  }

  void cancelOrder({required String orderId}) {
    Order? order = _findOrderOrNull(orderId: orderId);
    if (order == null) {
      throw Exception('Order with id $orderId does not exist.');
    }
    if (order.status != OrderStatus.open) {
      throw Exception('Only open orders can be cancelled.');
    }
    order.status = OrderStatus.cancelled;
    order.table.status = TableStatus.available;
  }

  void addItemToOrder({required String orderId, required OrderItem item}) {
    // if item status is not available, throw exception
    if (!item.menuItem.isAvailable) {
      throw Exception('Item ${item.menuItem.name} is not available.');
    }
    Order? order = _findOrderOrNull(orderId: orderId);
    if (order == null) {
      throw Exception('Order with id $orderId does not exist.');
    }
    if (order.status != OrderStatus.open) {
      throw Exception('Items can only be added to open orders.');
    }
    order.items.add(item);
  }

  void removeItemFromOrder({required String orderId, required String itemId}) {
    Order? order = _findOrderOrNull(orderId: orderId);
    if (order == null) {
      throw Exception('Order with id $orderId does not exist.');
    }

    if (order.status != OrderStatus.open) {
      throw Exception('Items can only removed from open order.');
    }
    order.items.removeWhere((item) => item.id == itemId);
  }

  

  

  void completeOrder({required String orderId}) {
    Order? order = _findOrderOrNull(orderId: orderId);
    if (order == null) {
      throw Exception('Order with id $orderId does not exist.');
    }
    if (order.status != OrderStatus.open) {
      throw Exception('Only open orders can be completed.');
    }
    order.status = OrderStatus.paid;
    order.table.status = TableStatus.available;
  }

  Order? _findOrderOrNull({required String orderId}) {
    for (Order o in orders) {
      if (o.id == orderId) {
        return o;
      }
    }
    return null;
  }
}
