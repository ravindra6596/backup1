import 'package:flutter/material.dart';

class NameIcons {
  @override
  Widget getWidget(String name) {
    if (name.startsWith("A") || name.startsWith("a")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.red,
        child: Text(
          'A',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    }
    if (name.startsWith("B") || name.startsWith("b")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.orange,
        child: Text(
          'B',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("C") || name.startsWith("c")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.cyanAccent[700],
        child: Text(
          'C',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("D") || name.startsWith("d")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.brown,
        child: Text(
          'D',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("E") || name.startsWith("e")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.green,
        child: Text(
          'E',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("F") || name.startsWith("f")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.cyan,
        child: Text(
          'F',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("G") || name.startsWith("g")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.lightBlue,
        child: Text(
          'G',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("H") || name.startsWith("h")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.redAccent,
        child: Text(
          'H',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("I") || name.startsWith("i")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.deepOrange,
        child: Text(
          'I',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("J") || name.startsWith("j")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.pink,
        child: Text(
          'J',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("K") || name.startsWith("k")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.indigo,
        child: Text(
          'K',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("L") || name.startsWith("l")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.purple,
        child: Text(
          'L',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("M") || name.startsWith("m")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.lime[900],
        child: Text(
          'M',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("N") || name.startsWith("n")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.lightGreen[900],
        child: Text(
          'N',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("O") || name.startsWith("o")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.lightBlue[900],
        child: Text(
          'O',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("P") || name.startsWith("p")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.teal[900],
        child: Text(
          'P',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("Q") || name.startsWith("q")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.purpleAccent[400],
        child: Text(
          'Q',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("R") || name.startsWith("r")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.deepPurple[900],
        child: Text(
          'R',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("S") || name.startsWith("s")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.blueGrey[900],
        child: Text(
          'S',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("T") || name.startsWith("t")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.brown[900],
        child: Text(
          'T',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("U") || name.startsWith("u")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey[900],
        child: Text(
          'U',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("V") || name.startsWith("v")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.deepPurpleAccent[700],
        child: Text(
          'V',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("W") || name.startsWith("w")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.greenAccent[700],
        child: Text(
          'W',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("X") || name.startsWith("x")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.green[900],
        child: Text(
          'X',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("Y") || name.startsWith("y")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.deepOrange[900],
        child: Text(
          'Y',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    } else if (name.startsWith("Z") || name.startsWith("z")) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.pinkAccent,
        child: Text(
          'Z',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    }
  }
}
