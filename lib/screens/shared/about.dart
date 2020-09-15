import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A propos'),
        backgroundColor: main,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text("Description"),
              subtitle: Text(
                  '''Application mobile pour l'association COMIF du campus Georges Charpak de l'Ecole des Mines Saint Etienne. Cette application a pour objectif de permettre aux serveurs de l'association d'effectuer les opérations de base lors d'un service.'''),
            ),
            ListTile(
              title: Text("Contacts"),
              subtitle: Text(
                  '''En cas de problème ou si vous souhaiter voir de nouvelles fonctionalités, vous pouvez faire un tour sur Github où le code source est disponible : https://github.com/valentinpollart/Comif_Server_App .'''),
            ),
            ListTile(
              title: Text("Licence"),
              subtitle: Text(
                  '''MIT License\n\nCopyright © 2020 Valentin Pollart\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'''),
            ),
          ],
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
