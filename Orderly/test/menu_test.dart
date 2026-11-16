
import 'package:test/test.dart';
import 'package:orderly/services/menu_service.dart';

void main() {
// write a test for menu item service to check if menu item is added correctly and if it can be retrieved by id
  test('add item', () {
    final menuService = MenuService();
    
    //convert to named parameters
    menuService.addMenuItem(id: '1', name: 'Pizza', price: 10.0, category: 'Food');
    
    // write a test to check if the menu item is added correctly
    expect(menuService.menuItems.length, 1);
    expect(menuService.menuItems[0].id, '1');
    expect(menuService.menuItems[0].name, 'Pizza');
    expect(menuService.menuItems[0].price, 10.0);
    expect(menuService.menuItems[0].category, 'Food');
  });
  test('add existing item', () {
    final menuService = MenuService();
    menuService.addMenuItem(id: '1', name: 'Pizza', price: 10.0, category: 'Food');

    expect(
      () =>menuService.addMenuItem(id: '1', name: 'Pizza', price: 10.0, category: 'Food'), throwsException

    );
    
    
   
   
  });
  test('remove item', () {
    final menuService = MenuService();
    menuService.addMenuItem(id: '1', name: 'Pizza', price: 10.0, category: 'Food');

   menuService.removeMenuItem(id: '1');

    expect(menuService.menuItems.length, 0);
    
    
   
   
  });
  test('remove non-existing item', () {
    final menuService = MenuService();
    menuService.addMenuItem(id: '1', name: 'Pizza', price: 10.0, category: 'Food');

    expect(
      () =>menuService.removeMenuItem(id: '2'), throwsException

    );
    
    
   
   
  });

  // test for update availability of menu item
  test('update availability', () {
    final menuService = MenuService();
    menuService.addMenuItem(id: '1', name: 'Pizza', price: 10.0, category: 'Food');    
    menuService.updateAvailability(id: '1', isAvailable: false);
    expect(menuService.menuItems[0].isAvailable, false);
  });


}
