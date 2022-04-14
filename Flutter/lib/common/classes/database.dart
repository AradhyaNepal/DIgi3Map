import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:sqflite/sqflite.dart';


const String domainTable="Domain";
const String habitTable="Habit";
const String habitTransactionTable="HabitTransaction";
const String randomTable="Random";
const String randomTransactionTable="RandomTransaction";
Future<Database> initializeDatabase() async{

  var databasesPath = await getDatabasesPath();
  String path = databasesPath + Service.databaseName;
  Database database=await openDatabase(path, version: 2,
      onUpgrade: (Database db, int version,int old) async {
        await db.execute(
            'CREATE TABLE $domainTable ('
                '${Domain.domainIdJson} INTEGER PRIMARY KEY AUTOINCREMENT,'
                ' ${Domain.domainNameJson} TEXT,'
                ' ${Domain.imagePathJson} TEXT,'
                '${Domain.userIdJson} INTEGER,'
                ' ${Domain.descriptionJson} TEXT,'
                '${Domain.pointsJson} INTEGER,'
                '${Domain.priorityJson} TEXT)'
        );
        await db.execute(
          'CREATE TABLE $randomTable ('
              '${RandomTaskModal.idJson} INTEGER PRIMARY KEY,'
              ' ${RandomTaskModal.nameJson} TEXT,'
              ' ${RandomTaskModal.imageJson} TEXT,'
              ' ${RandomTaskModal.descriptionJson} TEXT,'
              '${RandomTaskModal.priorityJson} TEXT,'
              '${RandomTaskModal.setsJson} INTEGER,'
              '${RandomTaskModal.restMinuteJson} INTEGER,'
              '${RandomTaskModal.taskTypeJson} TEXT,'
              '${RandomTaskModal.taskMinuteJson} INTEGER)',
        );


        await db.execute(
          'CREATE TABLE $habitTable ('
              '${Habit.idJson} INTEGER PRIMARY KEY,'
              ' ${Habit.nameJson} TEXT,'
              ' ${Habit.photoJson} TEXT,'
              '${Habit.widgetJson} TEXT,'
              ' ${Habit.descriptionJson} TEXT,'
              '${Habit.setsJson} INTEGER,'
              '${Habit.restJson} INTEGER,'
              '${Habit.timeJson} INTEGER)',
        );

        String query= 'CREATE TABLE $randomTransactionTable ('
            '${RandomTaskModal.idJson} INTEGER PRIMARY KEY AUTOINCREMENT,'
            '${RandomTaskModal.nameJson} INTEGER)';


        print(query);
        await db.execute(
           query
        );

        await db.execute(
            'CREATE TABLE $habitTransactionTable ('
                '${Habit.idJson} INTEGER PRIMARY KEY AUTOINCREMENT,'
                '$habitFailed bool,'
                '$collectedDate value,'
                '${Habit.nameJson} INTEGER)'
        );
      });
  return database;
}
const String habitFailed="failed";
const String collectedDate="collectedDate";
