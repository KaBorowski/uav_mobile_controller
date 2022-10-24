import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/flight_Instruments.dart';

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
      theme: ThemeData(primaryColor: const Color(0xFF616161)),
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
      body: Container(
          decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Dron.jpg"),
          opacity: 0.6,
          fit: BoxFit.cover,
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF616161),
        child: Container(height: 50.0),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 150,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF616161),
          child: const Text('CONNECT',
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Times',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
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
