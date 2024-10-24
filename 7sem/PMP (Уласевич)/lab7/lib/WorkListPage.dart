import 'package:flutter/material.dart';
import 'services/DatabaseHelper.dart';
import 'WorkDetailPage.dart';
import 'EditWorkPage.dart';
import 'FileOperationsPage.dart';  // Импортируйте файл
import 'models/Work.dart';

class WorkListPage extends StatefulWidget {
  @override
  _WorkListPageState createState() => _WorkListPageState();
}

class _WorkListPageState extends State<WorkListPage> {
  late Future<List<Work>> WorkList;

  @override
  void initState() {
    super.initState();
    WorkList = DatabaseHelper.instance.readAllWork();
  }

  void _refreshWorkList() {
    setState(() {
      WorkList = DatabaseHelper.instance.readAllWork();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Teams'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_copy),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FutureBuilder<List<Work>>(
                    future: WorkList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return FileOperationsPage(WorkList: snapshot.data!); // Передача списка команд
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Work>>(
        future: WorkList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final Work = snapshot.data![index];
              return ListTile(
                title: Text(Work.workName),
                subtitle: Text(Work.companyName),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkDetailPage(
                      work: Work,
                      onUpdate: _refreshWorkList,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditWorkPage(),
            ),
          ).then((_) {
            _refreshWorkList();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
