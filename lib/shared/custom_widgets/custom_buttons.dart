import 'package:contact_archive/shared/custom_widgets/custom_mat_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String label;

  CustomButton(this.label);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/home');
      },
      child: Container(
        child: Text(label),
      ),
    );
  }
}

class CustomDangerButton extends StatelessWidget {
  String label;

  CustomDangerButton(this.label);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
//        Navigator.pushNamed(context, '/home');
      },
      child: Container(
        color: Colors.red,
        child: Text(label),
      ),
    );
  }
}

class CustomPrimaryButton extends StatelessWidget {
  String label;
  Function customFunction;

  CustomPrimaryButton(this.label, this.customFunction);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => this.customFunction(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: colorCustom,
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: Colors.grey[300])),
//        padding: EdgeInsets.only(left: 20.0, bottom: 0.0),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
