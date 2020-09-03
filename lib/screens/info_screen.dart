import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 26,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Informativni kalkulator za izračun PPMV-a',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Dodatni troškovi unosa automobila iz EU koji mogu sustignut prevozitelja:',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Ishođenje Potvrde proizvođača - 400,00 kn',
                  style: TextStyle(
                    color: Colors.teal[600],
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Homologacija - 695,00 kn',
                  style: TextStyle(
                    color: Colors.teal[600],
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Naknada za gospodarenje otpadom  - masa vozila x 0,60 kn/kg',
                  style: TextStyle(
                    color: Colors.teal[600],
                    fontSize: 18,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              Text(
                'Aplikacija je osmišljena radi predaje projekta na kolegiju Osnove razvoja web i mobilnih aplikacija',
                style: TextStyle(fontSize: 16),
              ),
              Divider(),
              Text(
                'Mislav Đerđ',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
