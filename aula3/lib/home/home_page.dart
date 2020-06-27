import 'package:aula3/home/repositories/home_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = HomeRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Future",
              ),
              Tab(
                text: "Stream",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder<List<Map>>(
              future: repository.getTarefas(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Erro aconteceu");
                } else if (snapshot.hasData) {
                  final list = snapshot.data;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(list[index]['name']),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            StreamBuilder<List<Map>>(
              stream: repository.streamTarefas(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Erro aconteceu");
                } else if (snapshot.hasData) {
                  final list = snapshot.data;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(list[index]['name']),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
