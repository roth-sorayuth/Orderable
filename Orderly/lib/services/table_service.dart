import 'package:orderly/models/restaurant_table.dart';

class TableService {
  final List<RestaurantTable> tables = [];



  void addTable({required String id, required int capacity, TableStatus status = TableStatus.available}) {
    RestaurantTable? table = _findTableOrNull(id: id);
    if (table != null) {
      throw Exception('Table with id $id already exists.');
    }
    tables.add(RestaurantTable(id: id, capacity: capacity, status: status));
  }
  

  void removeTable({required String tableId}) {
    RestaurantTable? table = _findTableOrNull(id: tableId);
    if (table == null) {
      throw Exception('Table with id $tableId does not exist.');
    }
    tables.remove(table);
  }

  RestaurantTable? getTable({required String tableId}) {
    return _findTableOrNull(id: tableId);
  }


  

  RestaurantTable? _findTableOrNull({required String id}) {
    for(RestaurantTable t in tables) {
      if (t.id == id) {
        return t;
      }
    }
    return null;
  }
}


