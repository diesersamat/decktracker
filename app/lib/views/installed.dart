import 'package:flutter/material.dart';

class InstalledPage extends StatefulWidget {
  const InstalledPage({Key? key}) : super(key: key);

  @override
  State<InstalledPage> createState() => _InstalledPageState();
}

class _InstalledPageState extends State<InstalledPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
          body: Center(
            child: Text('Installed'),
          ),
        ));
  }
}
