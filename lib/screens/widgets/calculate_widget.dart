import 'package:flutter/material.dart';

import 'package:import_car_app/models/car.dart';
import 'package:import_car_app/constants.dart' as Constants;

class CalculateWidget extends StatelessWidget {
  final Car _carInfo;
  double valueComponent;
  double ecoComponent;

  CalculateWidget(this._carInfo);

  AlertDialog _buildCalculateWidget(BuildContext context) {
    return AlertDialog(
      title: Text('Posebni porez'),
      content: Container(
        height: 200,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Eco component: ${ecoComponent.toStringAsFixed(2)} kn',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green[500],
              ),
            ),
            Text(
              'Value component: ${valueComponent.toStringAsFixed(2)} kn',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Together: ${(ecoComponent + valueComponent).toStringAsFixed(2)} kn',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red[500],
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Nazad',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ],
    );
  }

  void _calculate() {
    for (var i = 1; i < Constants.addition.length; i++) {
      if (_carInfo.priceNewCar < Constants.saleValue[i]) {
        valueComponent = Constants.addition[i - 1];
        valueComponent += (_carInfo.priceNewCar - Constants.saleValue[i - 1]) *
            Constants.salePercentageAddition[i - 1];
        break;
      } else if (i == Constants.addition.length) {
        valueComponent = Constants.addition[i];
        valueComponent += (_carInfo.priceNewCar - Constants.saleValue[i]) *
            Constants.salePercentageAddition[i];
        break;
      }
    }

    

    if (_carInfo.isDieselEngine) {
      for (var i = 1; i < Constants.emissionDiesel.length; i++) {
        if (_carInfo.carEmission <= Constants.emissionDiesel[i]) {
          ecoComponent = Constants.additionDiesel[i - 1];
          ecoComponent +=
              (_carInfo.carEmission - Constants.emissionDiesel[i - 1]) *
                  Constants.multiplierDiesel[i - 1];
          break;
        } else if (i == Constants.emissionDiesel.length) {
          ecoComponent = Constants.additionDiesel[i];
          ecoComponent += (_carInfo.carEmission - Constants.emissionDiesel[i]) *
              Constants.multiplierDiesel[i];
          break;
        }
      }
    } else {
      for (var i = 1; i < Constants.emissionPetrol.length; i++) {
        if (_carInfo.carEmission < Constants.emissionPetrol[i]) {
          ecoComponent = Constants.additionPetrol[i - 1];
          ecoComponent +=
              (_carInfo.carEmission - Constants.emissionPetrol[i - 1]) *
                  Constants.multiplierPetrol[i - 1];
          break;
        } else if (i == Constants.emissionPetrol.length) {
          ecoComponent = Constants.additionPetrol[i];
          ecoComponent += (_carInfo.carEmission - Constants.emissionPetrol[i]) *
              Constants.multiplierPetrol[i];
          break;
        }
      }
    }
    if (_carInfo.isNew) {
      return;
    }
    else {
      if(_carInfo.date<30){
        return;
      }
      for(var i=0;i<Constants.carAge.length;i++){
        if(_carInfo.date<(Constants.carAge[i]*30)){
          valueComponent=valueComponent*Constants.depreciation[i-1];
          ecoComponent=ecoComponent*Constants.depreciation[i-1];
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    _calculate();
    return Container(
      child: _buildCalculateWidget(context),
    );
  }
}
