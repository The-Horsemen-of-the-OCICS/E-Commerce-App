import 'package:flutter/material.dart';

Widget drawerItem({required String text, required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(children: <Widget>[
      Padding(padding: const EdgeInsets.only(left: 8.0), child: Text(text)),
    ]),
    onTap: onTap,
  );
}
