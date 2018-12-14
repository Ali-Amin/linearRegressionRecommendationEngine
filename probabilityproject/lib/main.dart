import 'package:flutter/material.dart';
import 'bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  final Bloc _bloc = Bloc();

  String _recommendation = "";
  int downloadsVal = 0; 
  int ratingVal = 0;
  int ratingSumVal = 0;
  double probabilityVal = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        leading: Icon(Icons.dashboard),
        title: Text("Unmeme Engine"),
      ),
      body: Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             fit: BoxFit.fitWidth,
             image: AssetImage("assets/background.png")
           )
         ),
         child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget> [
              
              SizedBox(height: 10.0,),

              Image(
                image: AssetImage("assets/logo.jpg"),
                height: MediaQuery.of(context).size.height * 0.2,
                ),

              SizedBox(height: 20.0),

              Text(
                "Mobile Application Charge Recommendation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: "Arial",
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width *0.06,
                  vertical: MediaQuery.of(context).size.width *0.02),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(Icons.file_download, color: Colors.white),
                    hintText: "Enter Downloads Here",
                    ),
                  onChanged: (String text) => downloadsVal = int.parse(text),
                )
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width *0.06,
                  vertical: MediaQuery.of(context).size.width *0.02),                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(Icons.rate_review, color: Colors.white),
                    hintText: "Enter Ratings",
                  ),
                   onChanged: (String text) => ratingVal = int.parse(text),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width *0.06,
                  vertical: MediaQuery.of(context).size.width *0.02),                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(Icons.add, color: Colors.white),
                    hintText: "Enter Ratings Sum",
                  ),
                  onChanged: (String text) => ratingSumVal = int.parse(text),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.3,
                  vertical: MediaQuery.of(context).size.width * 0.02,
                  ),
                child: RaisedButton(
                  color: Colors.teal[100],
                  child: Text("SUMBIT"),
                  onPressed: () {
                    probabilityVal = 0.6011 + (-0.000000001078*downloadsVal) + (-0.03974*ratingVal) + (-0.00000006294*ratingSumVal);
                    _bloc.probabilitySink(probabilityVal);
                  },
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height* 0.01),

              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.3,
                  ),
                              child: StreamBuilder(
                  stream: _bloc.probability,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data > 0.5) {
                        _recommendation = "Recommendation: Paid";
                      } else {
                        _recommendation = "Recommendation: Free";
                      }
                      return  Text(
                        _recommendation + "\nPolarity: " + snapshot.data.toStringAsFixed(3),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 0.2,
                          color: Colors.white,
                          fontSize: 17.0,
                          fontFamily: "helvetica" ,
                          fontWeight: FontWeight.w900
                       )
                      );
                    } else {
                      return  Text(
                        "Please Fill the Information Above",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: "Arial" ,
                       )
                      );
                    }
                  }

                ),
              )
            ]
          )
        ),
      ),
    );
  }
}