import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartmedia/providers/user_provider.dart';
import 'package:smartmedia/responsive/mobilescreen_layout.dart';
import 'package:smartmedia/responsive/responsive_layout_screen.dart';
import 'package:smartmedia/responsive/webscreen_layout.dart';
import 'package:smartmedia/screens/login_screen.dart';
import 'package:smartmedia/screens/subscreens/add_article_layout.dart';
 import 'package:smartmedia/utils/colors.dart';
 
void main() async {
  //ensure that flutter is being initialized
  WidgetsFlutterBinding.ensureInitialized();
  //wait for Firebase Initiliazing 
  //if the Ki is a web application
  if(kIsWeb){
   await Firebase.initializeApp(
    options: const  FirebaseOptions(apiKey: 'AIzaSyDCYMYCuSSuSTN7N8hz740hgv3F3SUdU1w', appId: '1:772807047957:web:1f7d7f59922480b3bec71c', messagingSenderId: '772807047957', projectId: 'appsmartmedia-d6f05',
    storageBucket: 'appsmartmedia-d6f05.appspot.com')
   ) ;
  }
  //if it's mobile device
  else{
  await Firebase.initializeApp();
  }

  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  
  return   MultiProvider(
    
    providers: [
      ChangeNotifierProvider(create: (_)=>UserProvider(),)
    ],
    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    
        routes: {
          '/journalist/addArticle':(context)=>  const AddArticleLayout(),
                '/journalist/homeScreen':(context)=>  const MobileScreenLayout(),

        },
      color: white,
     title: 'Demo Smart Media Application',
      theme: ThemeData(primarySwatch: Colors.deepPurple,
      selectedRowColor: Colors.white,
      textTheme: Theme.of(context).textTheme.apply(
      
      bodyColor: Colors.black,
      displayColor: Colors.pinkAccent
      ),
      ),
      home:
      //  ResponsiveLayout(WebScreenLayout: WebScreen(), mobileScreenLayout: MobileScreen()),
      StreamBuilder(
        //work only if user sign in or sign out
        stream:FirebaseAuth.instance.authStateChanges() ,
        builder: ((context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active)
          {
            if(snapshot.hasData){
              
              return const ResponsiveLayout(WebScreenLayout: WebScreen(), mobileScreenLayout: MobileScreenLayout());
            } else if(snapshot.hasError){
              return Center(child: Text('------ERROR ERROR ERROR CHECK IT CHECK IT CHECK IT ERROR ERROR ERROR CHECKIT THE FOKING ERROR PLEASE OR NOTHING WILL WORK AS EXCEPTED / Type of error is : -----------${snapshot.error}----------------------------------------------------')
              );
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){

            return  const Center(
              child: CircularProgressIndicator(
                color: secondColor,

              ) ,
            );
          }
          return const  LoginScreen();
        }
        
        
        ),
      ),

    ),
  );


  }}