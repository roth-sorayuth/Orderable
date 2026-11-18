
import 'package:orderly/services/table_service.dart';
import 'package:test/test.dart';

void main(){
  test("create table", (){
    final tableService = TableService();
    tableService.addTable(id: "01", capacity: 4);

    expect(tableService.tables.length, 1);


  });

  test("create table that exists", (){
    final tableService = TableService();
    tableService.addTable(id: "01", capacity: 4);
  
    expect(()=> tableService.addTable(id: "01", capacity: 4), throwsException);
    

  });

  test("remove tablessssssssss", (){
    final tableService = TableService();
    tableService.addTable(id: "01", capacity: 4);
    tableService.removeTable(tableId: "01");
  
    expect(tableService.tables.length, 0);
    

  });

  test("remove tablessssssssss that not exists", (){
    final tableService = TableService();
    tableService.addTable(id: "01", capacity: 4);
    tableService.removeTable(tableId: "01");
  
    expect(()=>tableService.removeTable(tableId: "02"),throwsException);
    

  });
}