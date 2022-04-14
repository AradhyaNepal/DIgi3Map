import 'package:digi3map/common/classes/database.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:sqflite/sqflite.dart';

class DomainDatabase {

  late final Database database;

  Future<void> initialize() async{
    database=await initializeDatabase();
  }

  Future<void> addFitnessCareer(int fitnessPoints,int careerPoints) async{
    await insertIntoDomain(
        Domain(
            imagePath: "",
            domainName: "Fitness",
            description: "",
            userId: 0,
            priority: "",
          percentage:fitnessPoints
        )
    );
    await insertIntoDomain(
        Domain(
            imagePath: "",
            domainName: "Career",
            description: "",
            userId: 0,
            priority: "",
          percentage: careerPoints
        )
    );
  }
  Future<void> insertIntoDomain(Domain domain) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $domainTable('
              '${Domain.domainNameJson},'
              ' ${Domain.imagePathJson},'
              ' ${Domain.userIdJson},'
              '${Domain.descriptionJson},'
              '${Domain.pointsJson},'
              '${Domain.priorityJson}'
              ') VALUES('
              '"${domain.domainName}",'
              '"${domain.imagePath}",'
              ' ${domain.userId},'
              '"${domain.description}",'
              '${domain.percentage},'
              '"${domain.priority}")'
      );
    });
  }

  Future<List<Map>> getDomain() async{
    return await database.rawQuery('SELECT * FROM $domainTable');
  }

  Future<void> deleteAllRows() async{
    await database.delete(domainTable);

  }
  Future<void> logOut() async{
    await initialize();
    await deleteAllRows();
    await database.close();
  }
}
