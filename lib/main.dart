// import 'package:flutter/material.dart';
// import 'package:login_fresh/login_fresh.dart';
// import 'services/auth.dart';
// import 'widgets/fligh_iInstruments.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   //You have to create a list with the type of login's that you are going to import into your application

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: Scaffold(body: buildLoginFresh()));
//   }

//   LoginFresh buildLoginFresh() {
//     List<LoginFreshTypeLoginModel> listLogin = [
//       LoginFreshTypeLoginModel(
//           callFunction: (BuildContext _buildContext) {
//             // develop what they want the facebook to do when the user clicks
//           },
//           logo: TypeLogo.facebook),
//       LoginFreshTypeLoginModel(
//           callFunction: (BuildContext _buildContext) {
//             // develop what they want the Google to do when the user clicks
//           },
//           logo: TypeLogo.google),
//       // LoginFreshTypeLoginModel(
//       //     callFunction: (BuildContext _buildContext) {
//       //       print("APPLE");
//       //       // develop what they want the Apple to do when the user clicks
//       //     },
//       //     logo: TypeLogo.apple),
//       LoginFreshTypeLoginModel(
//           callFunction: (BuildContext _buildContext) {
//             Navigator.of(_buildContext).push(MaterialPageRoute(
//               builder: (_buildContext) => widgetLoginFreshUserAndPassword(),
//             ));
//           },
//           logo: TypeLogo.userPassword),
//     ];

//     return LoginFresh(
//       pathLogo: 'assets/karta_paragon.png',
//       isExploreApp: false,
//       functionExploreApp: () {
//         // develop what they want the ExploreApp to do when the user clicks
//       },
//       isFooter: false,
//       widgetFooter: this.widgetFooter(),
//       typeLoginModel: listLogin,
//       isSignUp: true,
//       // backgroundColor: Colors.red,
//       // cardColor: Colors.white,
//       widgetSignUp: this.widgetLoginFreshSignUp(),
//     );
//   }

//   Widget widgetLoginFreshUserAndPassword() {
//     return LoginFreshUserAndPassword(
//       callLogin: (BuildContext _context, Function isRequest, String user,
//           String password) async {
//         isRequest(true);

//         print('-------------- function call----------------');
//         print(user);
//         print(password);
//         print('--------------   end call   ----------------');
//         dynamic result =
//             await _auth.signInEmailPassword(email: user, password: password);

//         if (result != null) {
//           print('Successfully logged in');
//           print(result);
//           // User user = await fetchUser(result.email);
//           Navigator.of(_context).push(MaterialPageRoute(
//             builder: (_buildContext) => const FlightInstrumentsPage(),
//           ));
//         } else {
//           Navigator.of(_context).push(MaterialPageRoute(
//             builder: (_buildContext) => buildLoginFresh(),
//           ));
//           // Future.delayed(Duration(seconds: 2), () async {
//           // });
//         }
//         isRequest(false);
//       },
//       // logo: './assets/karta_paragon.png',
//       isFooter: false,
//       widgetFooter: this.widgetFooter(),
//       isResetPassword: true,
//       widgetResetPassword: this.widgetResetPassword(),
//       isSignUp: true,
//       signUp: this.widgetLoginFreshSignUp(),
//     );
//   }

//   Widget widgetResetPassword() {
//     return LoginFreshResetPassword(
//       // logo: './assets/karta_paragon.png',
//       funResetPassword:
//           (BuildContext _context, Function isRequest, String email) {
//         isRequest(true);

//         Future.delayed(Duration(seconds: 2), () {
//           print('-------------- function call----------------');
//           print(email);
//           print('--------------   end call   ----------------');
//           isRequest(false);
//         });
//       },
//       isFooter: false,
//       widgetFooter: this.widgetFooter(),
//     );
//   }

//   Widget widgetFooter() {
//     return LoginFreshFooter(
//       logo: 'assets/logo_footer.png',
//       text: 'Power by',
//       funFooterLogin: () {
//         // develop what they want the footer to do when the user clicks
//       },
//     );
//   }

//   Widget widgetLoginFreshSignUp() {
//     return LoginFreshSignUp(
//         isFooter: false,
//         widgetFooter: this.widgetFooter(),
//         // logo: './assets/karta_paragon.png',
//         funSignUp: (BuildContext _context, Function isRequest,
//             SignUpModel signUpModel) async {
//           isRequest(true);

//           print(signUpModel.email);
//           print(signUpModel.password);
//           print(signUpModel.repeatPassword);
//           print(signUpModel.surname);
//           print(signUpModel.name);

//           dynamic result = await _auth.registerUser(
//               email: signUpModel.email, password: signUpModel.password);

//           isRequest(false);
//           if (result != null) {
//             print('Successfully registered new user');
//             print(result.uid);
//             print(result.email);

//             // User user = new User(
//             //   email: result.email,
//             //   name: result.email,
//             //   uid: result.uid,
//             // );
//             // // Future<http.Response> _futureAlbum = addUser(user);
//             // addUser(user);

//             Navigator.of(_context).push(MaterialPageRoute(
//               builder: (_buildContext) => widgetLoginFreshUserAndPassword(),
//             ));
//           } else {
//             print('Error while creating new user');
//           }
//         });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/fligh_iInstruments.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAV Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'UAV Controller'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
          decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/home_screen.jpg"),
          fit: BoxFit.cover,
        ),
      )),
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   child: Container(height: 50.0),
      // ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 100,
        child: FloatingActionButton(
          child: const Text('START',
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Times',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)), //child widget inside this button
          shape: const BeveledRectangleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FlightInstrumentsPage()),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
