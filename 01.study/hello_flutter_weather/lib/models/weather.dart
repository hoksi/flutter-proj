class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String iconCode;
  final double feelsLike;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.iconCode,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['description'], // 더 상세한 날씨 설명으로 변경
      iconCode: json['weather'][0]['icon'],
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }

  @override
  String toString() {
    return 'Weather(cityName: $cityName, temperature: $temperature, mainCondition: $mainCondition, iconCode: $iconCode, feelsLike: $feelsLike, humidity: $humidity, windSpeed: $windSpeed)';
  }
}
