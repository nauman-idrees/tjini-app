import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/repositories/remote/iremote_repository.dart';
import 'package:tjini_app/repositories/remote/remote_repository.dart';


final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<IRemoteRepository>(RemoteRepository());

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferencesHelper>(
    SharedPreferencesHelper(sharedPreferences),
  );
}
