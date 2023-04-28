library my_prj.globals;

  var latitude;
  var longitude;
  var time;
  var chanceOfRain;
  var currentTemp;
  var cloudIndex;
  var weatherDesc;
  bool snow = false;

  void calculateBools()
  {
    if(chanceOfRain >= 50 && currentTemp < 32)
    {
      snow = true;
    }
  }