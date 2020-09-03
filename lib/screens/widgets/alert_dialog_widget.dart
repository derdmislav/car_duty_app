import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:import_car_app/constants.dart' as Constants;

class AlertDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return _buildAlertDialog(context);
            },
          );
        });
  }
}

AlertDialog _buildAlertDialog(BuildContext context) {
  return AlertDialog(
    title: Text('Cijena auta'),
    content: Text(
      'Cijenu auta tokom prve registracije mozete pronaci na sluzbenoj stranici carine.',
    ),
    actions: [
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Nazad'),
      ),
      FlatButton(
        onPressed: _launchURL,
        child: Text('Link na stranicu'),
      ),
    ],
  );
}

_launchURL() async {
  if (await canLaunch(Constants.officialPricingURL)) {
    await launch(Constants.officialPricingURL);
  } else {
    throw 'Could not launch';
  }
}
