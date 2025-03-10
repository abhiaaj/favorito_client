import 'package:flutter/material.dart';

class SizeManager {
  var _context;
  double _screenHeight;
  double _screenWidth;

  SizeManager(this._context) {
    _screenHeight = MediaQuery.of(_context).size.height;
    _screenWidth = MediaQuery.of(_context).size.width;
  }

  double h(double value) {
    return value * _screenHeight / 100;
  }

  double w(double value) {
    return value * _screenWidth / 100;
  }
}
