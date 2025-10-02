import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:provider/provider.dart';
import 'package:tjini_app/core/di/locator.dart';
import 'package:tjini_app/core/services/firebase_messaging_service.dart';
import 'package:tjini_app/firebase_options.dart';
import 'package:tjini_app/provider/auth_provider.dart';
import 'package:tjini_app/provider/user_provider.dart';
import 'package:tjini_app/repositories/remote/iremote_repository.dart';
import 'package:tjini_app/ui/resources/app_routes.dart';
import 'package:tjini_app/ui/resources/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  await FirebaseMessagingService().initializeFCM();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.white),
  );
  runApp(const TjiniApp());
}

class TjiniApp extends StatelessWidget {
  const TjiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            remoteRepository: locator<IRemoteRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
