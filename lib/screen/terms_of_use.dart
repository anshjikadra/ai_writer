import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class terms_of_use extends StatefulWidget {
  const terms_of_use({Key? key}) : super(key: key);

  @override
  State<terms_of_use> createState() => _terms_of_useState();
}

class _terms_of_useState extends State<terms_of_use> {

  String term='';
  @override
  void initState() {
    super.initState();
     load();
  }

  load()
  async{
   term = await rootBundle.loadString('assets/terms.txt');
   setState(() {});


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Terms of Use"),centerTitle: true,
        backgroundColor: Color(0xFF077A37),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon:Icon(Icons.close)),
      ),

      body:ListView(
        padding: EdgeInsets.all(10),
        children: [
          Text("${term}"),
        ],
      )
    );
  }
}
