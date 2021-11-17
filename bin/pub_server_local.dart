import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:unpub/unpub.dart' as unpub;

void main(List<String> args) async {
  final unpubMongoDb = Platform.environment['UNPUB_MONGODB'] ?? 'mongodb://localhost:27017/dart_pub';
  final unpubFolderPackage = Platform.environment['UNPUB_FOLDER_PACKAGES'] ?? './packages';
  final unpubPort = int.tryParse(Platform.environment['PORT'] ?? '') ?? 4000;

  final db = Db(unpubMongoDb);
  await db.open();

  final app = unpub.App(
    metaStore: unpub.MongoStore(db),
    packageStore: unpub.FileStore(unpubFolderPackage),
  );

  final server = await app.serve('0.0.0.0', unpubPort);
  print('Serving at http://${server.address.host}:${server.port}');
}
