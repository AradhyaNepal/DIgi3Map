import 'package:digi3map/common/classes/database.dart';
import 'package:sqflite/sqflite.dart';

class FitnessDatabase {
  static const idCol="id",failedCol="failed",dateCol="date",workoutIdCol="habitId";



  static Future<void> deleteLocalTransaction(int id)async{
    Database database=await initializeDatabase();

    await database.delete(workoutTransactionTable,where: "$idCol=?",whereArgs: [id]);
  }



  static Future<List<Map>> getTransaction() async{

    Database database=await initializeDatabase();

    return await database.rawQuery('SELECT * FROM $workoutTransactionTable');
  }
  static Future<void> saveTransactionLocally(int workoutId,bool failed,String date) async{

    Database database=await initializeDatabase();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $workoutTransactionTable('
              '$workoutIdCol'
              '$failedCol,'
              '$dateCol'
              ') VALUES('
              '$workoutId,'
              '${failed?1:0},'
              '"$date")'
      );
    });
  }


}
