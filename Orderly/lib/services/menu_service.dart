import 'package:orderly/models/menu_item.dart';

class MenuService {
  
  List<MenuItem> menuItems = [];
  

  
 
  void addMenuItem({required String id, required String name, required double price, required String category}) {
    MenuItem? menuItem = _findMenuItemOrNull(id: id);

    if (menuItem != null){
      throw Exception('Menu item with id $id already exists.');
    }
  
    menuItems.add(MenuItem(id: id, name: name, price: price, category: category));
  }


  void removeMenuItem({required String id}) {
    MenuItem? menuItem = _findMenuItemOrNull(id: id);

    if (menuItem == null){
      throw Exception('Menu item with id $id does not exist.');
    }

    menuItems.remove(menuItem);
  }

  void updateAvailability({required String id, required bool isAvailable}) {
    MenuItem? menuItem = _findMenuItemOrNull(id: id);

    if (menuItem == null){
      throw Exception('Menu item with id $id does not exist.');
    }

    menuItem.isAvailable = isAvailable;
  }

  void updatePrice({required String id, required double price}) {
    MenuItem? menuItem = _findMenuItemOrNull(id: id);

    if (menuItem == null){
      throw Exception('Menu item with id $id does not exist.');
    }

   
      menuItem.price = price;
    
  }

  MenuItem? getMenuItem({required String id}) {
    return _findMenuItemOrNull(id: id);
  }


  MenuItem? _findMenuItemOrNull({required String id}){
    for(MenuItem i in menuItems){
      if(i.id == id){
        return i;
      }
    }
    return null;
  }
}