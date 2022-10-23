import 'package:flutter/material.dart';
import 'package:praktika_bd/model/pos_model.dart';


import '../services/db_helper.dart';
import '../widgets/pos_widget.dart';
import 'ddialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  late final Pos? pos;
  

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 110, 68, 236),
        title: const Text('Score'),
      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => setState(() {showDialog(
           context: context,
          builder: (context) => const Ddialog(),
          );
          }),
          label: const Text("Добавить товар"),
          icon: const Icon(Icons.add),
          backgroundColor: const Color.fromARGB(255, 102, 100, 108),
          ),
          body: FutureBuilder<List<Pos>?>(
            future: DBHelper.getAllPos(),
            builder: (context, AsyncSnapshot<List<Pos>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => PosWidget(
                    pos: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                        context,
                         MaterialPageRoute(
                          builder: (context) =>  Ddialog(
                                    pos: snapshot.data![index],
                      )));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Уверены, что хотите удалить?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  onPressed: () async {
                                    await DBHelper.deletePos(
                                        snapshot.data![index]);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Да'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Нет'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('Пока нет записей'),
              );
            }
            return const SizedBox.shrink();
            },
          )
          );
  }
}