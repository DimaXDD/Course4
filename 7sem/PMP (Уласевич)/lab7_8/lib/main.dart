import 'package:flutter/material.dart';
import 'package:lab7_8/hive_page.dart';
import 'package:lab7_8/sharedpage.dart';
import 'package:lab7_8/sqf_page.dart';
import 'package:lab7_8/file_systems_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> pageTitles = ['SQF', 'Shared', 'Android', 'Hive'];
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page?.round() ?? 0;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pageTitles.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: (){
                      _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      color: _currentPageIndex == index ? Colors.grey : null, // Обозначение текущей страницы
                      child: Text(
                        pageTitles[index],
                        style: TextStyle(
                          fontSize: 20,
                          color: _currentPageIndex == index ? Colors.white : null, // Изменение цвета текста для текущей страницы
                        ),
                      ),
                    ),
                  );

                })
          ),
          Expanded(child: PageView(
            controller: _pageController,
            children: <Widget>[
              CarPage(),
              CarSharedPage(),
              FileSystemsPage(),
              HivePage(),
            ],
          ))
        ],
      ),
      
    );
  }
}
