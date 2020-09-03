import 'package:flutter/material.dart';
import 'package:import_car_app/screens/info_screen.dart';

import 'package:intl/intl.dart';

import 'package:import_car_app/models/car.dart';
import 'package:import_car_app/screens/widgets/alert_dialog_widget.dart';
import 'package:import_car_app/screens/widgets/calculate_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final _carInfo = Car();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<bool> _isSelectedOwner;
  List<bool> _isSelectedEngine;
  DateTime _dateTime;
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  Widget _buildCarPrice() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Enter car price',
          suffixText: 'KN',
          suffixIcon: AlertDialogWidget()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Fill thise tile';
        }
      },
      onChanged: (String value) {
        _carInfo.priceNewCar = double.parse(value);
      },
    );
  }

  Widget _buildCarOwner() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ToggleButtons(
        borderWidth: 2,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              'Used',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              'New',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
        isSelected: _isSelectedOwner,
        onPressed: (int index) {
          setState(
            () {
              for (int i = 0; i < _isSelectedOwner.length; i++) {
                _isSelectedOwner[i] = i == index;
              }

              if (index == 1) {
                _carInfo.isNew = true;
              } else
                _carInfo.isNew = false;
            },
          );
        },
      ),
    );
  }

  Widget _buildEngineType() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: ToggleButtons(
        borderWidth: 2,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              'Petrol',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              'Diesel',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
        isSelected: _isSelectedEngine,
        onPressed: (int index) {
          setState(
            () {
              for (int i = 0; i < _isSelectedEngine.length; i++) {
                _isSelectedEngine[i] = i == index;
              }

              if (index == 1) {
                _carInfo.isDieselEngine = true;
              } else
                _carInfo.isDieselEngine = false;
            },
          );
        },
      ),
    );
  }

  Widget _buildCarEmission() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'CO2 emission of the car:',
          suffixText: 'g/km',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'You need to fill this field';
          } else if ((double.parse(value) < 70)) {
            return 'Car emission for the engine can\'t be that low';
          }
        },
        onChanged: (String value) {
          _carInfo.carEmission = double.parse(value);
        },
      ),
    );
  }

  Widget _buildCarAgeInDays() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          Text(
            _dateTime == null
                ? 'Date of 1st registration'
                : _formatter.format(_dateTime).toString(),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: RaisedButton(
              elevation: 5,
              child: Text(
                'Date of 1st registration',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2021),
                ).then(
                  (date) {
                    setState(() {
                      _dateTime = date;
                      _carInfo.date = DateTime.now().difference(date).inDays;
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _isSelectedOwner = [true, false];
    _isSelectedEngine = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_carInfo.date);
    return Scaffold(
      appBar: AppBar(
        title: Text('Unos auta'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoScreen(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(34),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCarOwner(),
                  _buildEngineType(),
                  _buildCarEmission(),
                  _buildCarPrice(),
                  _buildCarAgeInDays(),
                  SizedBox(height: 20),
                  RaisedButton(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return CalculateWidget(_carInfo);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
