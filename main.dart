import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const RaceApp());
}

class RaceApp extends StatelessWidget {
  const RaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackDay Pilot - Roadster Pro Cup',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF2C2C2C),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.white70),
        ),
      ),
      home: const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// BASE DE DONNÉES ÉTENDUE DES CIRCUITS FRANÇAIS & GPS
// ==========================================
class CircuitDatabase {
  static final List<Map<String, dynamic>> circuits = [
    {
      "id": "ledenon",
      "name": "Circuit de Lédenon",
      "location": "Gard (30)",
      "startFinishLat": 43.8950,
      "startFinishLon": 4.5320,
      "sectors": [
        {"name": "Secteur 1", "lat": 43.8965, "lon": 4.5335},
        {"name": "Secteur 2", "lat": 43.8980, "lon": 4.5300},
        {"name": "Secteur 3 (Ligne)", "lat": 43.8950, "lon": 4.5320},
      ],
      "length": "3.15 km",
      "records": "1:22.50"
    },
    {
      "id": "magny_cours",
      "name": "Circuit de Nevers Magny-Cours",
      "location": "Nièvre (58)",
      "startFinishLat": 46.8642,
      "startFinishLon": 3.1633,
      "sectors": [
        {"name": "Secteur 1", "lat": 46.8670, "lon": 3.1600},
        {"name": "Secteur 2", "lat": 46.8600, "lon": 3.1550},
        {"name": "Secteur 3 (Ligne)", "lat": 46.8642, "lon": 3.1633},
      ],
      "length": "4.41 km",
      "records": "1:31.20"
    },
    {
      "id": "paul_ricard",
      "name": "Circuit Paul Ricard (Le Castellet)",
      "location": "Var (83)",
      "startFinishLat": 43.2530,
      "startFinishLon": 5.7950,
      "sectors": [
        {"name": "Secteur 1", "lat": 43.2580, "lon": 5.7900},
        {"name": "Secteur 2", "lat": 43.2480, "lon": 5.8000},
        {"name": "Secteur 3 (Ligne)", "lat": 43.2530, "lon": 5.7950},
      ],
      "length": "5.84 km",
      "records": "1:48.50"
    },
    {
      "id": "bugatti_lemans",
      "name": "Circuit Bugatti (Le Mans)",
      "location": "Sarthe (72)",
      "startFinishLat": 47.9560,
      "startFinishLon": 0.2210,
      "sectors": [
        {"name": "Secteur 1", "lat": 47.9590, "lon": 0.2180},
        {"name": "Secteur 2", "lat": 47.9520, "lon": 0.2250},
        {"name": "Secteur 3 (Ligne)", "lat": 47.9560, "lon": 0.2210},
      ],
      "length": "4.18 km",
      "records": "1:35.80"
    },
    {
      "id": "charade",
      "name": "Circuit de Charade",
      "location": "Puy-de-Dôme (63)",
      "startFinishLat": 45.7330,
      "startFinishLon": 3.0330,
      "sectors": [
        {"name": "Secteur 1", "lat": 45.7350, "lon": 3.0300},
        {"name": "Secteur 2", "lat": 45.7300, "lon": 3.0350},
        {"name": "Secteur 3 (Ligne)", "lat": 45.7330, "lon": 3.0330},
      ],
      "length": "3.97 km",
      "records": "1:42.10"
    },
    {
      "id": "dijon_prenois",
      "name": "Circuit de Dijon-Prenois",
      "location": "Côte-d'Or (21)",
      "startFinishLat": 47.3622,
      "startFinishLon": 4.8994,
      "sectors": [
        {"name": "Secteur 1", "lat": 47.3650, "lon": 4.8950},
        {"name": "Secteur 2", "lat": 47.3580, "lon": 4.9040},
        {"name": "Secteur 3 (Ligne)", "lat": 47.3622, "lon": 4.8994},
      ],
      "length": "3.80 km",
      "records": "1:13.00"
    },
    {
      "id": "val_de_vienne",
      "name": "Circuit du Val de Vienne",
      "location": "Vienne (86)",
      "startFinishLat": 46.2230,
      "startFinishLon": 0.6350,
      "sectors": [
        {"name": "Secteur 1", "lat": 46.2250, "lon": 0.6300},
        {"name": "Secteur 2", "lat": 46.2200, "lon": 0.6400},
        {"name": "Secteur 3 (Ligne)", "lat": 46.2230, "lon": 0.6350},
      ],
      "length": "3.77 km",
      "records": "1:35.00"
    },
    {
      "id": "nogaro",
      "name": "Circuit Paul Armagnac (Nogaro)",
      "location": "Gers (32)",
      "startFinishLat": 43.7555,
      "startFinishLon": 0.0035,
      "sectors": [
        {"name": "Secteur 1", "lat": 43.7580, "lon": 0.0010},
        {"name": "Secteur 2", "lat": 43.7520, "lon": 0.0060},
        {"name": "Secteur 3 (Ligne)", "lat": 43.7555, "lon": 0.0035},
      ],
      "length": "3.64 km",
      "records": "1:24.20"
    },
    {
      "id": "anneau_du_rhin",
      "name": "Anneau du Rhin",
      "location": "Haut-Rhin (68)",
      "startFinishLat": 47.9300,
      "startFinishLon": 7.3320,
      "sectors": [
        {"name": "Secteur 1", "lat": 47.9320, "lon": 7.3300},
        {"name": "Secteur 2", "lat": 47.9280, "lon": 7.3350},
        {"name": "Secteur 3 (Ligne)", "lat": 47.9300, "lon": 7.3320},
      ],
      "length": "3.62 km",
      "records": "1:18.50"
    },
    {
      "id": "pau_arnos",
      "name": "Circuit de Pau-Arnos",
      "location": "Pyrénées-Atlantiques (64)",
      "startFinishLat": 43.4350,
      "startFinishLon": -0.5280,
      "sectors": [
        {"name": "Secteur 1", "lat": 43.4380, "lon": -0.5310},
        {"name": "Secteur 2", "lat": 43.4320, "lon": -0.5250},
        {"name": "Secteur 3 (Ligne)", "lat": 43.4350, "lon": -0.5280},
      ],
      "length": "3.03 km",
      "records": "1:19.40"
    },
    {
      "id": "bresse",
      "name": "Circuit de Bresse",
      "location": "Saône-et-Loire (71)",
      "startFinishLat": 46.5700,
      "startFinishLon": 5.2340,
      "sectors": [
        {"name": "Secteur 1", "lat": 46.5720, "lon": 5.2310},
        {"name": "Secteur 2", "lat": 46.5680, "lon": 5.2380},
        {"name": "Secteur 3 (Ligne)", "lat": 46.5700, "lon": 5.2340},
      ],
      "length": "3.00 km",
      "records": "1:21.00"
    },
  ];

  static Map<String, dynamic> detectCircuitByGPS(double currentLat, double currentLon) {
    Map<String, dynamic> closest = circuits[0];
    double minDistance = double.infinity;

    for (var circuit in circuits) {
      double cLat = circuit["startFinishLat"];
      double cLon = circuit["startFinishLon"];
      double dist = sqrt(pow(currentLat - cLat, 2) + pow(currentLon - cLon, 2));
      if (dist < minDistance) {
        minDistance = dist;
        closest = circuit;
      }
    }
    return closest;
  }
}

// Modèle global partagé pour lier setup et sessions (Spécial Roadster Pro Cup)
class SessionDataModel {
  static final List<Map<String, dynamic>> sessionsList = [
    {
      "session": "Session 1 - Roadster Pro Cup",
      "circuit": "Circuit de Lédenon",
      "date": "Aujourd'hui, 10:30",
      "best": "1:28.45",
      "setup": {
        "pression": "AV: 2.10b | AR: 2.00b",
        "geometrie": "Carrossage: -2.5° | Pincement: 0.10mm",
        "suspension": "Hauteur: 110mm | Dureté: 8 clics"
      },
      "tours": [
        {"tour": "Tour 5 (Best)", "temps": "1:28.45", "s1": "29.2s", "s2": "35.1s", "s3": "24.15s", "delta": "-0.25s"},
        {"tour": "Tour 4", "temps": "1:28.90", "s1": "29.4s", "s2": "35.2s", "s3": "24.3s", "delta": "+0.20s"},
      ]
    },
  ];
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final String selectedCar = "Mazda MX-5 NA (Roadster Pro Cup)";

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeDashboard(
        onNavigate: (index) => setState(() => _currentIndex = index),
        selectedCar: selectedCar,
      ),
      const ChronoLiveTab(),
      const HistoriqueTab(),
      ReglagesTab(selectedCar: selectedCar),
      const EntretienTab(),
      const SecuriteTab(),
      CouplesSerrageTab(selectedCar: selectedCar),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex > 0 ? _currentIndex : 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 9,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Live'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.tune), label: 'Réglages'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Entretien'),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: 'Sécurité'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_applications), label: 'Couples'),
        ],
      ),
    );
  }
}

// ==========================================
// ACCUEIL (ROADSTER PRO CUP)
// ==========================================
class HomeDashboard extends StatelessWidget {
  final Function(int) onNavigate;
  final String selectedCar;

  const HomeDashboard({
    Key? key,
    required this.onNavigate,
    required this.selectedCar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("STAND OFFICIEL - CHAMPIONNAT", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                  SizedBox(height: 4),
                  Text("Bonjour, Pilote 🏁", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.red[900],
                child: const Icon(Icons.sports_motorsports, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.redAccent, width: 1.5),
            ),
            child: Row(
              children: [
                const Icon(Icons.directions_car, color: Colors.redAccent, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("MODÈLE ENGAGÉ", style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(selectedCar, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red[900]!, Colors.black87]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("GPS & Base Circuits Français", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 8),
                Text("Détection automatique active (Lédenon, Magny-Cours, Le Castellet, Le Mans, Dijon, Nogaro...)", style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 4),
                Text("🛰️ Liaison géolocalisation & enregistrement direct des secteurs", style: TextStyle(color: Colors.amberAccent, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("ACCÈS RAPIDE", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.35,
            children: [
              _buildMenuCard(context, "Chrono Live", Icons.timer, Colors.green, 1),
              _buildMenuCard(context, "Stats & Session", Icons.bar_chart, Colors.blue, 2),
              _buildMenuCard(context, "Réglages & Setup", Icons.tune, Colors.teal, 3),
              _buildMenuCard(context, "Entretien & Usure", Icons.build, Colors.orange, 4),
              _buildMenuCard(context, "Sécurité & FIA", Icons.security, Colors.red, 5),
              _buildMenuCard(context, "Couples de Serrage", Icons.settings_applications, Colors.purple, 6),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Color color, int index) {
    return InkWell(
      onTap: () => onNavigate(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// CHRONO LIVE AVEC DÉTECTION GPS AUTOMATIQUE
// ==========================================
class ChronoLiveTab extends StatefulWidget {
  const ChronoLiveTab({Key? key}) : super(key: key);

  @override
  State<ChronoLiveTab> createState() => _ChronoLiveTabState();
}

class _ChronoLiveTabState extends State<ChronoLiveTab> {
  bool _isRunning = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _currentTime = "00:00.000";
  String _bestLap = "--:--.---";
  String _lastLap = "--:--.---";
  String _delta = "+0.00s";
  Color _deltaColor = Colors.grey;
 
  int _currentSector = 1;
  String _s1Time = "-:--.--";
  String _s2Time = "-:--.--";
  String _s3Time = "-:--.--";
 
  final Stopwatch _sectorStopwatch = Stopwatch();

  Map<String, dynamic> _currentCircuit = CircuitDatabase.circuits[0];
  bool _isGpsScanning = false;

  void _detectCircuitAutomatically() {
    setState(() {
      _isGpsScanning = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _currentCircuit = CircuitDatabase.detectCircuitByGPS(43.8950, 4.5320);
        _isGpsScanning = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("GPS Fix : ${_currentCircuit['name']} détecté (${_currentCircuit['length']}) !")),
      );
    });
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
      _sectorStopwatch.start();
      _currentSector = 1;
      _s1Time = "-:--.--";
      _s2Time = "-:--.--";
      _s3Time = "-:--.--";
    });
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        final elapsed = _stopwatch.elapsed;
        _currentTime = _formatDuration(elapsed);
      });
    });
  }

  String _formatDuration(Duration elapsed) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String threeDigits(int n) => n.toString().padLeft(3, '0');
    return "${twoDigits(elapsed.inMinutes)}:${twoDigits(elapsed.inSeconds.remainder(60))}.${threeDigits(elapsed.inMilliseconds.remainder(1000))}";
  }

  void _nextSectorOrLap() {
    if (!_isRunning) return;
   
    final sectorElapsed = _formatDuration(_sectorStopwatch.elapsed);
    setState(() {
      if (_currentSector == 1) {
        _s1Time = sectorElapsed;
        _currentSector = 2;
      } else if (_currentSector == 2) {
        _s2Time = sectorElapsed;
        _currentSector = 3;
      } else {
        _s3Time = sectorElapsed;
        _lastLap = _currentTime;
       
        if (_bestLap == "--:--.---" || _currentTime.compareTo(_bestLap) < 0) {
          _bestLap = _currentTime;
          _delta = "-0.25s (PB)";
          _deltaColor = Colors.greenAccent;
        } else {
          _delta = "+0.20s";
          _deltaColor = Colors.redAccent;
        }

        _enregistrerSessionAutomatique();

        _stopwatch.reset();
        _currentSector = 1;
        _s1Time = "-:--.--";
        _s2Time = "-:--.--";
        _s3Time = "-:--.--";
      }
      _sectorStopwatch.reset();
      _sectorStopwatch.start();
    });
  }

  void _enregistrerSessionAutomatique() {
    SessionDataModel.sessionsList.insert(0, {
      "session": "Session GPS - ${_currentCircuit['name']}",
      "circuit": _currentCircuit['name'],
      "date": "À l'instant",
      "best": _bestLap,
      "setup": {
        "pression": "AV: 2.10b | AR: 2.00b",
        "geometrie": "Carrossage: -2.5° | Pincement: 0.10mm",
        "suspension": "Hauteur: 110mm | Dureté: 8 clics"
      },
      "tours": [
        {"tour": "Tour validé (GPS)", "temps": _lastLap, "s1": _s1Time, "s2": _s2Time, "s3": _s3Time, "delta": _delta}
      ]
    });
  }

  void _stopStopwatch() {
    _timer?.cancel();
    _stopwatch.stop();
    _sectorStopwatch.stop();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetStopwatch() {
    _timer?.cancel();
    _stopwatch.reset();
    _sectorStopwatch.reset();
    setState(() {
      _isRunning = false;
      _currentTime = "00:00.000";
      _currentSector = 1;
      _s1Time = "-:--.--";
      _s2Time = "-:--.--";
      _s3Time = "-:--.--";
      _delta = "+0.00s";
      _deltaColor = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> sectors = _currentCircuit["sectors"] ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("TRACÉ GPS DÉTECTÉ", style: TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(_currentCircuit["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text("${_currentCircuit['location']} • Longueur : ${_currentCircuit['length']}", style: const TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isGpsScanning ? null : _detectCircuitAutomatically,
                  icon: _isGpsScanning
                      ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.my_location, size: 16),
                  label: Text(_isGpsScanning ? 'Scan...' : 'Scanner GPS'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900], padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0D0D0D),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red, width: 2.5),
              boxShadow: [BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 10, spreadRadius: 2)],
            ),
            child: Column(
              children: [
                const Text("CHRONO EN COURS", style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 1.5)),
                const SizedBox(height: 5),
                Text(_currentTime, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.white)),
                const Divider(height: 25, color: Colors.white24),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSectorBox(sectors.isNotEmpty ? sectors[0]["name"] : "S1", _s1Time, _currentSector == 1 && _isRunning),
                    _buildSectorBox(sectors.isNotEmpty ? sectors[1]["name"] : "S2", _s2Time, _currentSector == 2 && _isRunning),
                    _buildSectorBox(sectors.isNotEmpty ? sectors[2]["name"] : "S3", _s3Time, _currentSector == 3 && _isRunning),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(child: _buildInfoCard("DELTA", _delta, _deltaColor)),
              const SizedBox(width: 10),
              Expanded(child: _buildInfoCard("BEST TOUR", _bestLap, Colors.greenAccent)),
              const SizedBox(width: 10),
              Expanded(child: _buildInfoCard("DERNIER", _lastLap, Colors.white70)),
            ],
          ),
          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _isRunning ? _stopStopwatch : _startStopwatch,
                icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                label: Text(_isRunning ? 'Pause' : 'Start'),
                style: ElevatedButton.styleFrom(backgroundColor: _isRunning ? Colors.orange : Colors.green, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
              ),
              ElevatedButton.icon(
                onPressed: _isRunning ? _nextSectorOrLap : null,
                icon: const Icon(Icons.flag),
                label: Text(_currentSector == 3 ? 'Boucler Tour' : 'Secteur +'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
              ),
              ElevatedButton.icon(
                onPressed: _resetStopwatch,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800], padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectorBox(String title, String time, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.red[900]?.withValues(alpha: 0.6) : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? Colors.redAccent : Colors.white12),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? Colors.white : Colors.grey)),
          const SizedBox(height: 4),
          Text(time, style: const TextStyle(fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white10)),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

// ==========================================
// STATS & SESSIONS
// ==========================================
class HistoriqueTab extends StatefulWidget {
  const HistoriqueTab({Key? key}) : super(key: key);

  @override
  State<HistoriqueTab> createState() => _HistoriqueTabState();
}

class _HistoriqueTabState extends State<HistoriqueTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const Text("STATISTIQUES & SESSIONS ASSOCIÉES", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 4),
        const Text("Retrouvez vos enregistrements GPS et setups de la Roadster Pro Cup", style: TextStyle(color: Colors.grey, fontSize: 11)),
        const SizedBox(height: 12),
        ...SessionDataModel.sessionsList.map((sessionData) {
          final setup = sessionData["setup"] as Map<String, dynamic>;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ExpansionTile(
              leading: const Icon(Icons.sports_score, color: Colors.amber),
              title: Text(sessionData["session"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: Text("${sessionData['circuit']} • ${sessionData['date']}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
              trailing: Text(sessionData["best"], style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 13)),
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.black38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("⚙️ SETUP CHÂSSIS UTILISÉ", style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold, fontSize: 11)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("• Pressions : ${setup['pression']}", style: const TextStyle(fontSize: 11, color: Colors.white70)),
                            const SizedBox(height: 3),
                            Text("• Géométrie : ${setup['geometrie']}", style: const TextStyle(fontSize: 11, color: Colors.white70)),
                            const SizedBox(height: 3),
                            Text("• Suspensions : ${setup['suspension']}", style: const TextStyle(fontSize: 11, color: Colors.white70)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text("⏱️ DÉTAIL DES TOURS GPS", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 11)),
                      const SizedBox(height: 6),
                      ...(sessionData["tours"] as List).map((t) {
                        bool isBest = t["tour"].toString().contains("Best") || t["tour"].toString().contains("GPS");
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(t["tour"], style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isBest ? Colors.greenAccent : Colors.white70)),
                              Text("S1:${t['s1']} | S2:${t['s2']} | S3:${t['s3']}", style: const TextStyle(fontSize: 9, color: Colors.grey)),
                              Text(t["temps"], style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: isBest ? Colors.greenAccent : Colors.white)),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}

// ==========================================
// RÉGLAGES & CURSEUR DE DURETÉ
// ==========================================
class ReglagesTab extends StatefulWidget {
  final String selectedCar;
  const ReglagesTab({Key? key, required this.selectedCar}) : super(key: key);

  @override
  State<ReglagesTab> createState() => _ReglagesTabState();
}

class _ReglagesTabState extends State<ReglagesTab> {
  String meteoMode = "Sec";
 
  double avG = 2.10;
  double avD = 2.10;
  double arG = 2.00;
  double arD = 2.00;

  double carrossageAV = -2.5;
  double carrossageAR = -2.0;
  double pincementAV = 0.10;
  double pincementAR = 0.20;

  double hauteurAV = 110.0;
  double hauteurAR = 120.0;
 
  double dureteGlobale = 10.0;

  void _ajusterPression(String roue, double delta) {
    setState(() {
      if (roue == "AV-G") avG = (avG + delta).clamp(1.2, 3.5);
      if (roue == "AV-D") avD = (avD + delta).clamp(1.2, 3.5);
      if (roue == "AR-G") arG = (arG + delta).clamp(1.2, 3.5);
      if (roue == "AR-D") arD = (arD + delta).clamp(1.2, 3.5);
    });
  }

  void _sauvegarderEtAssocierSession() {
    final nouveauSetup = {
      "pression": "AV: ${avG.toStringAsFixed(2)}b / ${avD.toStringAsFixed(2)}b | AR: ${arG.toStringAsFixed(2)}b / ${arD.toStringAsFixed(2)}b",
      "geometrie": "Carrossage: ${carrossageAV}°/${carrossageAR}° | Pincement: ${pincementAV}mm",
      "suspension": "Hauteur AV:${hauteurAV.toInt()}mm AR:${hauteurAR.toInt()}mm | Dureté: ${dureteGlobale.toInt()} clics"
    };

    setState(() {
      SessionDataModel.sessionsList.insert(0, {
        "session": "Setup Châssis (Roadster Pro Cup)",
        "circuit": "Circuit de Lédenon",
        "date": "À l'instant",
        "best": "En cours...",
        "setup": nouveauSetup,
        "tours": [
          {"tour": "Setup initialisé", "temps": "--:--.---", "s1": "-", "s2": "-", "s3": "-", "delta": "0.00s"}
        ]
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Setup sauvegardé pour la Roadster Pro Cup !")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("SETUP CHÂSSIS & GÉOMÉTRIE", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.teal, width: 1.5),
            ),
            child: Column(
              children: [
                const Text("PRESSIONS DES PNEUS (PAS DE 0.05b)", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.tealAccent)),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRoueCard("AV-G", avG),
                    _buildRoueCard("AV-D", avD),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Icon(Icons.directions_car, size: 40, color: Colors.white24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRoueCard("AR-G", arG),
                    _buildRoueCard("AR-D", arD),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.amber, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("GÉOMÉTRIE (CARROSSAGE & PINCEMENT)", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amberAccent)),
                const SizedBox(height: 10),
                _buildSliderRow("Carrossage AV", carrossageAV, -5.0, 0.0, 0.1, "°", (val) => setState(() => carrossageAV = val)),
                _buildSliderRow("Carrossage AR", carrossageAR, -5.0, 0.0, 0.1, "°", (val) => setState(() => carrossageAR = val)),
                _buildSliderRow("Pincement AV", pincementAV, -1.0, 1.0, 0.05, "mm", (val) => setState(() => pincementAV = val)),
                _buildSliderRow("Pincement AR", pincementAR, -1.0, 1.0, 0.05, "mm", (val) => setState(() => pincementAR = val)),
              ],
            ),
          ),
          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.purpleAccent, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("SUSPENSIONS (HAUTEURS & DURETÉ)", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.purpleAccent)),
                const SizedBox(height: 10),
                _buildSliderRow("Hauteur de caisse AV", hauteurAV, 80.0, 180.0, 1.0, "mm", (val) => setState(() => hauteurAV = val)),
                _buildSliderRow("Hauteur de caisse AR", hauteurAR, 80.0, 180.0, 1.0, "mm", (val) => setState(() => hauteurAR = val)),
                const Divider(color: Colors.white24, height: 20),
                _buildSliderRow("Dureté des amortisseurs", dureteGlobale, 1.0, 20.0, 1.0, "clics", (val) => setState(() => dureteGlobale = val)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              const Text("Conditions Piste : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(width: 15),
              ChoiceChip(
                label: const Text("☀️ Sec"),
                selected: meteoMode == "Sec",
                selectedColor: Colors.orange[800],
                onSelected: (bool selected) {
                  setState(() {
                    meteoMode = "Sec";
                    avG = 2.10; avD = 2.10; arG = 2.00; arD = 2.00;
                  });
                },
              ),
              const SizedBox(width: 10),
              ChoiceChip(
                label: const Text("🌧️ Pluie"),
                selected: meteoMode == "Pluie",
                selectedColor: Colors.blue[800],
                onSelected: (bool selected) {
                  setState(() {
                    meteoMode = "Pluie";
                    avG = 1.80; avD = 1.80; arG = 1.70; arD = 1.70;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _sauvegarderEtAssocierSession,
              icon: const Icon(Icons.bookmark_add),
              label: const Text("Sauvegarder le Setup Pro Cup"),
              style: ElevatedButton.styleFrom(backgroundColor: meteoMode == "Sec" ? Colors.red[800] : Colors.blue[800], padding: const EdgeInsets.all(12)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRoueCard(String nomRoue, double pression) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.tealAccent.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Text(nomRoue, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.amber)),
          const SizedBox(height: 4),
          Text("${pression.toStringAsFixed(2)} bar", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                icon: const Icon(Icons.remove_circle_outline, color: Colors.orangeAccent, size: 20),
                onPressed: () => _ajusterPression(nomRoue, -0.05),
              ),
              const SizedBox(width: 10),
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                icon: const Icon(Icons.add_circle_outline, color: Colors.greenAccent, size: 20),
                onPressed: () => _ajusterPression(nomRoue, 0.05),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSliderRow(String label, double value, double min, double max, double step, String unit, Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70))),
          Text("${value.toStringAsFixed(step < 1 ? 2 : 0)} $unit", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.white)),
          Expanded(
            flex: 4,
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: ((max - min) / step).round(),
              activeColor: Colors.amber,
              inactiveColor: Colors.white12,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// ENTRETIEN
// ==========================================
class EntretienTab extends StatefulWidget {
  const EntretienTab({Key? key}) : super(key: key);

  @override
  State<EntretienTab> createState() => _EntretienTabState();
}

class _EntretienTabState extends State<EntretienTab> {
  final List<Map<String, dynamic>> maintenances = [
    {"title": "Vidange Moteur (1.6L / 1.8L MX-5)", "current": 45, "limit": 100},
    {"title": "Vidange Boîte de vitesse", "current": 220, "limit": 300},
    {"title": "Vidange Pont Torsen", "current": 295, "limit": 300},
    {"title": "Pneus Semi-Slicks Cup", "current": 42, "limit": 50},
    {"title": "Plaquettes de frein Racing", "current": 15, "limit": 25},
    {"title": "Disques de frein", "current": 350, "limit": 500},
  ];

  void _ouvrirFormulaireAjout() {
    TextEditingController nameController = TextEditingController();
    TextEditingController currentController = TextEditingController(text: "0");
    TextEditingController limitController = TextEditingController(text: "50");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E1E1E),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ajouter un élément d'entretien", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Nom de la pièce / action..."),
                  autofocus: true,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: currentController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Tours actuels"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: limitController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Limite max de tours"),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[800], padding: const EdgeInsets.all(12)),
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        setState(() {
                          maintenances.add({
                            "title": nameController.text,
                            "current": int.tryParse(currentController.text) ?? 0,
                            "limit": int.tryParse(limitController.text) ?? 100,
                          });
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Enregistrer l'élément", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _modifierTours(int index) {
    TextEditingController currentController = TextEditingController(text: maintenances[index]["current"].toString());
    TextEditingController limitController = TextEditingController(text: maintenances[index]["limit"].toString());
   
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E1E1E),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Modifier : ${maintenances[index]['title']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                const SizedBox(height: 16),
                TextField(
                  controller: currentController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Nombre de tours actuels"),
                  autofocus: true,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: limitController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Maximum à atteindre"),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800], padding: const EdgeInsets.all(12)),
                    onPressed: () {
                      setState(() {
                        maintenances[index]["current"] = int.tryParse(currentController.text) ?? maintenances[index]["current"];
                        maintenances[index]["limit"] = int.tryParse(limitController.text) ?? maintenances[index]["limit"];
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Valider les modifications", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _ouvrirFormulaireAjout,
        icon: const Icon(Icons.add),
        label: const Text("Ajouter"),
        backgroundColor: Colors.orange[800],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: maintenances.length,
        itemBuilder: (context, index) {
          final m = maintenances[index];
          bool isAlert = m["current"] >= (m["limit"] * 0.9);
          return Card(
            color: isAlert ? const Color(0xFF331A1A) : const Color(0xFF1E1E1E),
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Icon(isAlert ? Icons.warning : Icons.check_circle, color: isAlert ? Colors.orange : Colors.green),
              title: Text(m["title"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: Text("Actuel: ${m['current']} tours / Max: ${m['limit']} tours", style: const TextStyle(fontSize: 11)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18, color: Colors.blueAccent),
                    onPressed: () => _modifierTours(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey, size: 20),
                    onPressed: () => setState(() => maintenances.removeAt(index)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        m["current"] = 0;
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800], padding: const EdgeInsets.symmetric(horizontal: 6)),
                    child: const Text("Reset", style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// SÉCURITÉ & FIA
// ==========================================
class SecuriteTab extends StatefulWidget {
  const SecuriteTab({Key? key}) : super(key: key);

  @override
  State<SecuriteTab> createState() => _SecuriteTabState();
}

class _SecuriteTabState extends State<SecuriteTab> {
  final List<Map<String, String>> equipments = [
    {"item": "Siège Baquet FIA", "expire": "12/2026", "norme": "FIA 8855-1999"},
    {"item": "Harnais 6 points", "expire": "03/2028", "norme": "FIA 8853-2016"},
    {"item": "Extincteur Auto", "expire": "06/2026", "norme": "FIA Tech. List 16"},
    {"item": "Casque & HANS", "expire": "09/2028", "norme": "FIA 8859-2015"},
    {"item": "Combinaison pilote", "expire": "01/2027", "norme": "FIA 8856-2018"},
  ];

  void _ouvrirFormulaireAjout() {
    TextEditingController nameController = 