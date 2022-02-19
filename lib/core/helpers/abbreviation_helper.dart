String abbreviationHelper(double value) {
  int count = 0;
  double tempValue = value;
  String prefix = '';

  while (tempValue > 999) {
    tempValue = tempValue.roundToDouble();
    tempValue /= 1000;
    count++;
  }
  
  if (count == 0) {
    prefix = '';
  } else if (count == 1) {
    prefix = 'K';
  } else if (count == 2) {
    prefix = 'M';
  } else if (count == 3) {
    prefix = 'B';
  }
  return prefix + tempValue.toString();
}
