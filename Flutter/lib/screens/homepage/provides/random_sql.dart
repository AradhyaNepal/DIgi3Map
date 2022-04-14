import 'package:digi3map/common/classes/database.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:sqflite/sqflite.dart';

class RandomDatabase {
  late final Database database;
  Future<void> initialize() async{
    database=await initializeDatabase();
  }




  Future<void> insertIntoRandom(RandomTaskModal randomTaskModal) async {


    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $randomTable\n('
              '${RandomTaskModal.idJson},'
              '${RandomTaskModal.nameJson},'
              ' ${RandomTaskModal.imageJson},'
              '${RandomTaskModal.descriptionJson},'
              '${RandomTaskModal.priorityJson},'
              '${RandomTaskModal.setsJson},'
              '${RandomTaskModal.restMinuteJson},'
              '${RandomTaskModal.taskTypeJson},'
              '${RandomTaskModal.taskMinuteJson}'
              ') VALUES\n('
              '"${randomTaskModal.id}",'
              '"${randomTaskModal.name}",'
              '"${randomTaskModal.imagePath}",'
              '"${randomTaskModal.description}",'
              '"${randomTaskModal.priority}",'
              '${randomTaskModal.sets},'
              '${randomTaskModal.rest},'
              '"${randomTaskModal.type}",'
              '${randomTaskModal.time})'

      );
    });
  }

  Future<List<Map>> getRandomTaskModal() async{
    List<Map> randomMap= (await database.rawQuery('SELECT * FROM $randomTable')).map((e) => e).toList();
    List<Map> transactionMap=await getTransaction();

    for(Map single in transactionMap){
      randomMap.removeWhere((element) {
        int randomId=element[RandomTaskModal.idJson];
        int transactionId=single[RandomTaskModal.nameJson];
        return randomId==transactionId;
      });
    }
    return randomMap;
  }

  Future<List<Map>> getTransaction() async{
    return await database.rawQuery('SELECT * FROM $randomTransactionTable');
  }
  Future<void> deleteAllRows() async{
    await database.delete(randomTable);

  }
  Future<void> logOut() async{
    await initialize();
    await deleteAllRows();
    await database.delete(randomTransactionTable);
    await database.close();
  }

  Future<void> saveTransactionLocally(int randomId) async{
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $randomTransactionTable('
              '${RandomTaskModal.nameJson}'
              ') VALUES('
              '$randomId)'
      );
    });
  }

  Future<void> deleteLocalTransaction(int id)async{
    await database.delete(randomTransactionTable,where: "${RandomTaskModal.idJson}=?",whereArgs: [id]);
  }





}
