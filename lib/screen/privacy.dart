import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class privacy extends StatefulWidget {
  const privacy({Key? key}) : super(key: key);

  @override
  State<privacy> createState() => _privacyState();
}

class _privacyState extends State<privacy> {
  
  String privacy='';
  @override
  void initState() {
    
    super.initState();
    load_privacy();
  }
  
  load_privacy()async{
    
   privacy = await rootBundle.loadString('assets/privacy.txt');
   setState(() {});
   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        centerTitle: true,
        backgroundColor: Color(0xFF077A37),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon:Icon(Icons.close)),
      ),
      
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Text(privacy),
        ],
      ),
    );
  }
}
