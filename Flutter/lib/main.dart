import 'package:digi3map/common/classes/database.dart';
import 'package:digi3map/common/classes/setup_notification.dart';
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_sql.dart';
import 'package:digi3map/screens/homepage/provides/multiplication_provider.dart';
import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main(){
  try{

    WidgetsFlutterBinding.ensureInitialized();
    NotificationManager().sendNotification();
  }catch(e){
    print("Network Error");
  }

  runApp(const MainPage());
}


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context)=>Auth()
        ),
        ChangeNotifierProvider(
            create: (context)=>MultiplicationProvider()
        ),
      ],
      child: MaterialApp(
        title: "Digi3Map",
        theme: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(primary:ColorConstant.kBlueColor,secondary: ColorConstant.kBlueColor),
        ),
        home: SplashPage(),
      ),
    );
  }
}
