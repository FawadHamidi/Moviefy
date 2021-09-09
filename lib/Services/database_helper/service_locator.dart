import 'package:get_it/get_it.dart';
import 'package:moviefy/Services/database_helper/database.dart';

GetIt locator = GetIt.instance;
DatabaseHelper db = DatabaseHelper();

void setupLocator() {
  print('service locator');
  locator.registerSingleton(DatabaseHelper());
}
