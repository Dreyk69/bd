import 'package:flutter/material.dart';
import 'package:praktika_bd/model/pos_model.dart';

import '../services/db_helper.dart';

class Ddialog extends StatelessWidget {
final Pos? pos;
const Ddialog ({Key? key, this.pos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final cenaController = TextEditingController();
    final kolController = TextEditingController();

    if (pos != null) {
      titleController.text = pos!.title;
      descriptionController.text = pos!.description;
      cenaController.text = pos!.cena as String;
      kolController.text = pos!.kol as String;

    }
    Rect myRect;
    return AlertDialog(
      title: Text(pos == null ? 'Добавить товар' : 'Редактировать товар'),
          content: SizedBox(
            height: 200,
            width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
           children: [
            SizedBox(width: 140,
            child:
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                SizedBox(width: 140, height: 50,
          child:
                 Padding(
                   padding: const EdgeInsets.all(0.0),
                   child: TextFormField(
                     controller: titleController,
                    maxLines: 1,
                     decoration: const InputDecoration(
                       //hintText: 'Введите название',
                       labelText: 'Название',
                       border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      width: 0.0,
                        ),
                       borderRadius: BorderRadius.all(
                        Radius.circular(0),
                       ))),
                   ),
                 ), 
                ),
                SizedBox(width: 140, height: 50,
          child:
                 TextFormField(
                   controller: descriptionController,
                  decoration: const InputDecoration(
                     //hintText: 'Введите описание',
                     labelText: 'Описание',
                    border: OutlineInputBorder(
                     borderSide: BorderSide(
                       color: Colors.white,
                       width: 0.5,
                     ),
                     borderRadius: BorderRadius.all(
                       Radius.circular(0),
                       ))),
                        keyboardType: TextInputType.multiline,
                       onChanged: (str) {},
                       maxLines: 5,
                 ),
                ),
                SizedBox(width: 140, height: 50,
                child:
                 TextFormField(
                   controller: cenaController,
                  decoration: const InputDecoration(
                     //hintText: 'Введите цену',
                     labelText: 'Цена',
                    border: OutlineInputBorder(
                     borderSide: BorderSide(
                       color: Colors.white,
                       width: 0.5,
                     ),
                     borderRadius: BorderRadius.all(
                       Radius.circular(0),
                       ))),
                        keyboardType: TextInputType.multiline,
                       onChanged: (str) {},
                       maxLines: 5,
                 ),
                ),
                SizedBox(width: 140, height: 50,
          child:
                 TextFormField(
                   controller: kolController,
                  decoration: const InputDecoration(
                     //hintText: 'Введите количество',
                     labelText: 'Количество',
                    border: OutlineInputBorder(
                     borderSide: BorderSide(
                       color: Colors.white,
                       width: 0.5,
                     ),
                     borderRadius: BorderRadius.all(
                       Radius.circular(0),
                       ))),
                        keyboardType: TextInputType.multiline,
                       onChanged: (str) {},
                       maxLines: 5,
                 ),
                ),
               ],
             ),
            ),
            SizedBox(width: 146,
            child:
             Column(
               children: const [
                SizedBox(width: 146, height: 200,
          child:
                 Text("Просто что бы было")),
               ]
             )
            ),
           ]
          ),
          ),
           actions: [
             ElevatedButton(
            onPressed: () {
             Navigator.of(context).pop();
             },
            style: ElevatedButton.styleFrom(
             foregroundColor: Colors.grey[600], backgroundColor: Colors.white,
             ),
             child: const Text("Отмена")
           ),
           ElevatedButton(
             onPressed: () async {
                final title = titleController.value.text;
               final description = descriptionController.value.text;
               final cena = cenaController.value.text;
               final kol = kolController.value.text;
               if (title.isEmpty || description.isEmpty || cena.isEmpty || kol.isEmpty) {
                return;
                 }
                  final Pos model = Pos(
                 title: title, description: description, cena: pos?.cena, kol: pos?.kol, id: pos?.id);
                  if (pos == null) {
                 await DBHelper.addPos(model);
                   } else {
                    await DBHelper.updatePos(model);
                    }
                   // ignore: use_build_context_synchronously
                   Navigator.of(context).pop();
                    },
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[900],
            ),
            child: Text(
              pos == null ? 'Сохранить' : 'Редактировать',
              style: const TextStyle(fontSize: 10),
            )
           ),
           ],
    );
  }
}