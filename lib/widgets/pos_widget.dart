import 'package:flutter/material.dart';

import '../model/pos_model.dart';


class PosWidget extends StatelessWidget {
  const PosWidget(
      {Key? key,
      required this.pos,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);
  final Pos pos;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox (
  width: 411.4,
  height: 120,
  child: Card(
        color: Colors.white,
        elevation: 2.0,
        child: Row(
          children: [
            Text(pos.title),
            Text(pos.description),
            Text('Цена:''${pos.cena}'),
            Text('Количество:''${pos.kol}'),
            ]
        )
        )
        ),
      );
  }
}