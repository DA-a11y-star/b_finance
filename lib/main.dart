import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart';
// import 'api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme lightColorScheme = ColorScheme(
      primary: Colors.deepPurple,
      primaryContainer: Colors.deepPurple.shade100,
      secondary: Colors.teal,
      secondaryContainer: Colors.teal.shade100,
      surface: Colors.grey.shade100,
      error: Colors.red.shade400,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    );

    final ColorScheme darkColorScheme = ColorScheme(
      primary: const Color.fromARGB(200, 50, 30, 8),
      primaryContainer: Colors.deepPurple.shade700,
      secondary: Colors.teal.shade200,
      secondaryContainer: Colors.teal.shade700,
      surface: const Color.fromARGB(200, 50, 30, 8),
      error: Colors.red.shade700,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.black,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'Budding Finance',
      theme: ThemeData(
        colorScheme: lightColorScheme, // Light theme
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme, // Dark theme
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application.
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser() async {
    await firestore.collection('users').add({
      'name': 'John Doe',
      'age': 25,
      'email': 'john.doe@example.com',
    });
  }

  int _selectedIndex = 0; // This keeps track of the selected tab
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Test', style: TextStyle(fontSize: 24)),
    Text('Transactions Page', style: TextStyle(fontSize: 24)),
    Text('Profile Page', style: TextStyle(fontSize: 24)),
  ];

  // This function is called when a tab is tapped
  void _onItemTapped(int index) {
    addUser();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budding Finance'),
      ),
      body: Center(
        child: _widgetOptions
            .elementAt(_selectedIndex), // Display the current page
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Set the currently selected tab
        selectedItemColor: Theme.of(context).colorScheme.secondaryContainer,
        onTap: _onItemTapped, // Handle the tap event
      ),
    );
  }
}
