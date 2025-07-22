import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hello_flutter_weather/models/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather; // 날씨 정보를 저장할 변수
  String _errorMessage = '';
  bool _isLoading = false;

  // OpenWeatherMap API Key (여기에 발급받은 API Key를 입력하세요!)
  final String _apiKey = '4d89441ce27d184df27c04d5e536c046';

  static const String _lastCityKey = 'last_city';

  @override
  void initState() {
    super.initState();
    _loadLastCity();
  }

  Future<void> _loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    final String? lastCity = prefs.getString(_lastCityKey);
    if (lastCity != null && lastCity.isNotEmpty) {
      _cityController.text = lastCity;
      _fetchWeather(lastCity);
    }
  }

  Future<void> _saveLastCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastCityKey, cityName);
  }

  Future<void> _fetchWeather(String cityName) async {
    if (cityName.isEmpty) {
      setState(() {
        _errorMessage = '도시 이름을 입력해주세요.';
        _weather = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_apiKey&units=metric&lang=kr';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          _weather = Weather.fromJson(jsonResponse);
          _errorMessage = '';
        });
        await _saveLastCity(cityName); // 검색 성공 시 도시 이름 저장
      } else {
        setState(() {
          _errorMessage = '날씨 정보를 가져오지 못했습니다. 도시 이름을 확인해주세요. (Error: ${response.statusCode})';
          _weather = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '네트워크 오류가 발생했습니다: $e';
        _weather = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

class WeatherInfoCard extends StatelessWidget {
  final Weather weather;

  const WeatherInfoCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Image.network(
              'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            Text(
              weather.mainCondition,
              style: TextStyle(fontSize: 22, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildWeatherDetail('체감', '${weather.feelsLike.toStringAsFixed(1)}°C'),
                _buildWeatherDetail('습도', '${weather.humidity}%'),
                _buildWeatherDetail('풍속', '${weather.windSpeed}m/s'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ],
    );
  }
}