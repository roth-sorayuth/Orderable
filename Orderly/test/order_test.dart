 

import 'package:orderly/services/payment_service.dart';
import 'package:orderly/services/table_service.dart';
import 'package:test/test.dart';
import 'package:orderly/services/order_service.dart';
import 'package:orderly/models/restaurant_table.dart';  
import 'package:orderly/models/order.dart';
import 'package:orderly/models/order_item.dart';
import 'package:orderly/services/menu_service.dart';




void main() {
  

    test(' creates a new order ', () {
     
      final orderService = OrderService();
      final TableService tableService = TableService();
      tableService.addTable(id: '1', capacity: 4);
      final table = tableService.getTable(tableId: '1')!;
      
      orderService.createOrder(orderId: 'order1', table: table);

      expect(orderService.orders.length, 1);
      expect(orderService.orders[0].id, 'order1');
      expect(table.status, TableStatus.occupied);
    });

     test('createOrder throws exception if table is not available', () {
      final orderService = OrderService();
      final TableService tableService = TableService();
      tableService.addTable(id: '1', capacity: 4, status: TableStatus.occupied);
      final table = tableService.getTable(tableId: '1')!;

      expect(() => orderService.createOrder(orderId: 'order1', table: table), throwsException);
     });

    
    test('createOrder throws exception if order already exists', () {
      final orderService = OrderService();
      final TableService tableService = TableService();
      tableService.addTable(id: '1', capacity:  4);
      final table = tableService.getTable(tableId: '1')!;
      orderService.createOrder(orderId: 'order1', table: table);

      expect(() => orderService.createOrder(orderId: 'order1', table: table), throwsException);
    });

  
    test('cancelOrder updates order status and table status', () {  
      final orderService = OrderService();
      final TableService tableService = TableService();
      tableService.addTable(id: '1', capacity: 4);
      final table = tableService.getTable(tableId: '1')!;
      
      orderService.createOrder(orderId: 'order1', table: table);
      orderService.cancelOrder(orderId: 'order1');

      expect(orderService.orders[0].status, OrderStatus.cancelled);
      expect(table.status, TableStatus.available);
    });

    test('Add item to order', () {

  final orderService = OrderService();
  final tableService = TableService();
  final menuService = MenuService();

  tableService.addTable(id: '1', capacity: 4);
  final table = tableService.getTable(tableId: '1')!;

  orderService.createOrder(orderId: 'order1', table: table);

  menuService.addMenuItem(id: 'item1', name: 'Pizza', price: 10.0, category: 'Food',);
  final item = menuService.getMenuItem(id: 'item1')!;
 
 orderService.addItemToOrder(orderId: 'order1', item: OrderItem(id: item.id,menuItem: item , priceSnapshot: item.price, quantity: 1));
  

  expect(orderService.orders[0].items.length, 1);
  expect(orderService.orders[0].items[0].id, 'item1');
});


test('Remove item from order', () {
  final orderService = OrderService();
  final tableService = TableService();
  final menuService = MenuService();

  tableService.addTable(id: '1', capacity: 4);
  final table = tableService.getTable(tableId: '1')!;

  orderService.createOrder(orderId: 'order1', table: table);

  menuService.addMenuItem(id: 'item1', name: 'Pizza', price: 10.0, category: 'Food',);
  final item = menuService.getMenuItem(id: 'item1')!;
 
 orderService.addItemToOrder(orderId: 'order1', item: OrderItem(id: item.id,menuItem: item , priceSnapshot: item.price, quantity: 1));
  
 orderService.removeItemFromOrder(orderId: 'order1', itemId: 'item1');

  expect(orderService.orders[0].items.length, 0);
});

//order unavailable item test
test('Add unavailable item to order', () {
  final orderService = OrderService();
  final tableService = TableService();
  final menuService = MenuService();

  tableService.addTable(id: '1', capacity: 4);
  final table = tableService.getTable(tableId: '1')!;

  orderService.createOrder(orderId: 'order1', table: table);


  menuService.addMenuItem(id: 'item1', name: 'Pizza', price: 10.0, category: 'Food',);
  final item = menuService.getMenuItem(id: 'item1')!;
  
  //update item availability to false
  menuService.updateAvailability(id: 'item1', isAvailable: false);

  expect(() => orderService.addItemToOrder(orderId: 'order1', item: OrderItem(id: item.id,menuItem: item , priceSnapshot: item.price, quantity: 1)), throwsException);

});
test('Pay order', () {
  final orderService = OrderService();
  final tableService = TableService();
  final menuService = MenuService();
  final paymentService = PaymentService();

  tableService.addTable(id: '1', capacity: 4);
  final table = tableService.getTable(tableId: '1')!;

  orderService.createOrder(orderId: 'order1', table: table);

  menuService.addMenuItem(id: 'item1', name: 'Pizza', price: 10.0, category: 'Food',);
  final item = menuService.getMenuItem(id: 'item1')!;
  


  orderService.addItemToOrder(orderId: 'order1', item: OrderItem(id: item.id,menuItem: item , priceSnapshot: item.price, quantity: 2));

  final payment=  paymentService.processPayment(paymentId: 'P1', amountPaid: 30, totalOrderPrice: orderService.orders[0].totalAmount);
 


  orderService.payOrder(orderId: 'order1', payment: payment);


final order = orderService.orders[0];
expect(order.totalAmount, 20.0);
expect(order.status, OrderStatus.paid);
expect(order.payment?.amountPaid, 30.0);
expect(order.payment?.change, 10.0);
expect(table.status, TableStatus.available);
  //expect change
});





}
