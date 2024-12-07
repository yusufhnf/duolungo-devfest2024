import 'package:flutter/material.dart';

import 'style_translator_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    const StyleTranslatorScreen(),
    const Center(child: Text("Create your own feature"))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Duolungo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Smart Translator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Your Feature',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: pages[_selectedIndex],
        ),
      ),
    );
  }
}
