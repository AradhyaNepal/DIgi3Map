import 'package:digi3map/common/classes/database.dart';

import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:sqflite/sqflite.dart';

class HabitDatabase {




  static Future<void> deleteLocalTransaction(int id)async{
    Database database=await initializeDatabase();

    await database.delete(habitTransactionTable,where: "${Habit.idJson}=?",whereArgs: [id]);
  }

  static Future<void> insertIntoHabit(Habit habit) async {
    Database database=await initializeDatabase();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $habitTable('
              '${Habit.idJson},'
              ' ${Habit.nameJson},'
              ' ${Habit.photoJson},'
              '${Habit.widgetJson},'
              ' ${Habit.descriptionJson},'
              '${Habit.setsJson},'
              '${Habit.restJson},'
              '${Habit.timeJson}'
              ') VALUES('
                  '${habit.id},'
                  ' "${habit.name}",'
                  ' "${habit.photoUrl}",'
                  '"${habit.widgetType}",'
                  ' "${habit.description}",'
                  '${habit.sets},'
                  '${habit.rest},'
                  '${habit.time})',
      );
    });
  }

  static Future<List<Map>> getHabit() async{
    Database database=await initializeDatabase();
    List<Map> habitMap= (await database.rawQuery('SELECT * FROM $habitTable')).map((e) => e).toList();
    List<Map> transactionMap=await getTransaction();

    for(Map single in transactionMap){
      habitMap.removeWhere((element) {
        int habit=element[Habit.idJson];
        int transactionId=single[Habit.nameJson];
        return habit==transactionId;
      });
    }
    return habitMap;
  }
  static Future<List<Map>> getTransaction() async{

    Database database=await initializeDatabase();

    return await database.rawQuery('SELECT * FROM $habitTransactionTable');
  }
  static Future<void> saveTransactionLocally(int habitId,bool failed,String date) async{

    Database database=await initializeDatabase();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $habitTransactionTable('
              '${Habit.nameJson},'
              '$habitFailed,'
              '$collectedDate'
              ') VALUES('
              '$habitId,'
              '${failed?1:0},'
              '"$date")'
      );
    });
  }

  static Future<void> deleteAllRows() async{
    Database database=await initializeDatabase();
    await database.delete(habitTable);

  }
}
