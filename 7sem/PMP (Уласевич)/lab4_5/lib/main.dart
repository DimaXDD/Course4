import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageViewScreen(), // Используем PageViewScreen как главный экран
    );
  }
}


class PageViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          FirstScreen(), // Ваш первый экран
          SecondScreen(), // Ваш второй экран
        ],
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd.MM.yyyy – kk:mm').format(DateTime.now());

    List<Map<String, dynamic>> weatherItems = [
      {
        'phrase': 'Serti time',
        'time': '3:40am',
        'icon': Icons.nightlight_round,
        'bgColor': Colors.grey[200],
        'textColor': Colors.black,
        'timeColor': Colors.deepPurpleAccent,
      },
      {
        'phrase': 'Remaining',
        'secondPhrase': 'Dhuhr',
        'time': '15.20 min',
        'icon': Icons.wb_sunny,
        'bgColor': Colors.deepPurple,
        'textColor': Colors.white,
        'secondTextColor': Colors.orange,
        'timeColor': Colors.white,
      },
      {
        'phrase': 'Next Prayer',
        'secondPhrase': 'Asr',
        'time': '14:24pm',
        'icon': Icons.wb_sunny,
        'bgColor': Colors.deepPurple[300],
        'textColor': Colors.white,
        'secondTextColor': Colors.orange,
        'timeColor': Colors.white,
      },
      {
        'phrase': 'Iftar Time',
        'time': '6:45pm',
        'icon': Icons.cloud,
        'bgColor': Colors.deepOrange[100],
        'textColor': Colors.black,
        'timeColor': Colors.orange,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 800, // Increased height for more vertical space
          decoration: BoxDecoration(
            color: Colors.teal[50],
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 15,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Current Time',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 245,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.drag_handle),
                ),
              ),
              Positioned(
                top: 70,
                left: 10,
                right: 10,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: weatherItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: weatherItems[index]['bgColor'],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index == 1 || index == 2) ...[
                                  Text(
                                    weatherItems[index]['phrase'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: weatherItems[index]['textColor'],
                                    ),
                                  ),
                                  Text(
                                    weatherItems[index]['secondPhrase'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: weatherItems[index]['secondTextColor'],
                                    ),
                                  ),
                                ] else ...[
                                  Text(
                                    weatherItems[index]['phrase'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: weatherItems[index]['textColor'],
                                    ),
                                  ),
                                ],
                                SizedBox(height: 3),
                                Text(
                                  weatherItems[index]['time'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: weatherItems[index]['timeColor'],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Icon(
                              weatherItems[index]['icon'],
                              size: 30,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 330, // Adjusted position for better spacing
                left: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Daily Dua',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '🙌',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Slightly grayer text',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Even grayer and smaller text',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 440, // Adjusted position for better spacing
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _buildCategoryCard(Icons.person, 'Prayer Time'),
                        _buildCategoryCard(Icons.place, 'Mosque Finder'),
                        _buildCategoryCard(Icons.book, 'AI Quran'),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0, // Positioning at the bottom
                left: 0,
                right: 0,
                child: _buildFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(IconData icon, String title) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Rounded bottom corners
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFooterIcon(Icons.home, true), // Home icon highlighted
          _buildFooterIcon(Icons.calendar_today, false),
          _buildFooterIcon(Icons.notifications, false),
          _buildFooterIcon(Icons.settings, false),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? Colors.blue : Colors.grey, size: 30),
        SizedBox(height: 4),
        Text(
          isActive ? 'Home' : '',
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class SecondScreen extends StatelessWidget {
  // Функция для получения текущей даты в нужном формате
  String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd MMMM yyyy').format(now); // Формат: 26 September 2024
  }

  // Функция для получения списка дней недели
  List<Map<String, String>> getWeekDays() {
    DateTime now = DateTime.now();
    return [
      {'day': 'MO', 'date': DateFormat('d').format(now.subtract(Duration(days: now.weekday - 1)))},
      {'day': 'TU', 'date': DateFormat('d').format(now.subtract(Duration(days: now.weekday - 2)))},
      {'day': 'WE', 'date': DateFormat('d').format(now.subtract(Duration(days: now.weekday - 3)))},
      {'day': 'TH', 'date': DateFormat('d').format(now.subtract(Duration(days: now.weekday - 4)))},
      {'day': 'FR', 'date': DateFormat('d').format(now.subtract(Duration(days: now.weekday - 5)))},
      {'day': 'SA', 'date': DateFormat('d').format(now.subtract(Duration(days: now.weekday - 6)))},
      {'day': 'SU', 'date': DateFormat('d').format(now)}, // Текущий день
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Получение текущего дня недели (1 - понедельник, 7 - воскресенье)
    int currentDay = DateTime.now().weekday;

    // Данные для элемента расписания
    List<Map<String, dynamic>> weatherItems = [
      {
        'phrase': 'Serti time',
        'time': '3:40am',
        'icon': Icons.nightlight_round,
        'bgColor': Colors.grey[200],
        'textColor': Colors.black,
        'timeColor': Colors.deepPurpleAccent,
      },
      {
        'phrase': 'Remaining',
        'secondPhrase': 'Dhuhr',
        'time': '15.20 min',
        'icon': Icons.wb_sunny,
        'bgColor': Colors.deepPurple,
        'textColor': Colors.white,
        'secondTextColor': Colors.orange,
        'timeColor': Colors.white,
      },
      {
        'phrase': 'Next Prayer',
        'secondPhrase': 'Asr',
        'time': '14:24pm',
        'icon': Icons.wb_sunny,
        'bgColor': Colors.deepPurple[300],
        'textColor': Colors.white,
        'secondTextColor': Colors.orange,
        'timeColor': Colors.white,
      },
      {
        'phrase': 'Iftar Time',
        'time': '6:45pm',
        'icon': Icons.cloud,
        'bgColor': Colors.deepOrange[100],
        'textColor': Colors.black,
        'timeColor': Colors.orange,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Вернуться на предыдущий экран
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: MediaQuery.of(context).size.height * 0.9, // Responsive height
          decoration: BoxDecoration(
            color: Colors.blue[700],
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              // Прозрачная иконка стрелки назад
              Positioned(
                top: 15,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Вернуться на предыдущий экран
                    },
                  ),
                ),
              ),
              // Прозрачная иконка колокольчика
              Positioned(
                top: 15,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Оставляем без функционала
                    },
                  ),
                ),
              ),
              // Текущая дата под стрелкой
              Positioned(
                top: 90,
                left: 20,
                child: Text(
                  getFormattedDate(), // Формат: 26 September 2024
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black54, offset: Offset(1, 1), blurRadius: 3)],
                  ),
                ),
              ),
              // Дни недели в квадратиках с отступом ниже даты
              Positioned(
                top: 140,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: getWeekDays().asMap().entries.map((entry) {
                    int index = entry.key + 1; // Преобразуем в дни недели от 1 до 7
                    String day = entry.value['day']!;
                    String date = entry.value['date']!;

                    return Container(
                      width: 35,
                      height: 45,
                      decoration: BoxDecoration(
                        color: currentDay == index
                            ? Colors.white.withOpacity(0.4) // Выделение текущего дня
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            date,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Белый блок снизу
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6, // Высота как 60% от экрана
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  // Добавляем прямоугольник с иконками и текстом
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              // Желтый кружочек
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 10), // Отступ между кружком и текстом
                              // Текст по центру
                              Expanded(
                                child: Text(
                                  'Are you fasting today?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              // Иконка с галочкой
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Название "Scheduler"
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Scheduler',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Перечисление элементов
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(20.0),
                          itemCount: weatherItems.length,
                          itemBuilder: (context, index) {
                            var item = weatherItems[index];
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: item['bgColor'],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    item['icon'],
                                    color: item['timeColor'],
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['phrase'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: item['textColor'],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (item['secondPhrase'] != null) // Проверка на наличие второго текста
                                          Text(
                                            item['secondPhrase'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: item['secondTextColor'] ?? Colors.black,
                                            ),
                                          ),
                                        SizedBox(height: 5),
                                        Text(
                                          item['time'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: item['timeColor'],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}