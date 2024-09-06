import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:proximity_service/common_libs.dart';
import 'package:proximity_service/presentation/home/widgets/marker_data.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();

  final List<MarkerData> _markersData = [];

  final List<Marker> _markers = [];

  final List<Marker> _entityMarkers = [];

  bool _showCircle = false;

  double _currentZoom = 13.0;

  LatLng? _selectedPosition;

  LatLng? _mylocation;

  LatLng? _draggedPosition;

  bool _isDragging = false;

  final TextEditingController _searchController = TextEditingController();

  List<dynamic> _searchResults = [];

  bool _isSearching = false;

  // get current location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

// show current location
  void _showCurrentLocation() async {
    if (_mylocation != null) {
      setState(() {
        _mylocation = null;
      });
    } else {
      try {
        Position position = await _determinePosition();
        LatLng currentLocation = LatLng(position.latitude, position.longitude);

        _mapController.move(currentLocation, 15.0);
        setState(() {
          _mylocation = currentLocation;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  // add marker
  void _addMarker(LatLng position, String title, String description) {
    setState(() {
      final makerData = MarkerData(
          position: position, title: title, description: description);
      _markersData.add(makerData);
      _markers.add(Marker(
          point: position,
          width: 80,
          height: 80,
          child: GestureDetector(
            onTap: () => {},
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 4,
                            offset: Offset(0, 2))
                      ]),
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                )
              ],
            ),
          )));
    });
  }

// show marker dialog
  void _showMarkerDialog(BuildContext context, LatLng position) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Marker'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                _addMarker(
                    position, titleController.text, descriptionController.text);
              },
              child: const Text('Add'))
        ],
      ),
    );
  }

  // Show marker info
  void _showMarkerInfo(MarkerData markerData) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(markerData.title),
              content: Text(markerData.description),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'))
              ],
            ));
  }

  // Search Feature
  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }
    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data.isNotEmpty) {
      setState(() {
        _searchResults = data;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  void _moveToLocation(double lat, double lng) {
    LatLng location = LatLng(lat, lng);
    _mapController.move(location, 15.0);
    setState(() {
      _selectedPosition = location;
      _searchResults = [];
      _isSearching = false;
      _searchController.clear();
    });
  }

  void _showEntityDetails(Map<String, dynamic> entity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(entity['images'][0]['url']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entity['name'],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            Text(
                                ' ${entity['overallRating']} (${entity['totalReview']} reviews)'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(entity['description']),
                        SizedBox(height: 16),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(entity['phoneNumber']),
                        ),
                        ListTile(
                          leading: Icon(Icons.language),
                          title: Text(entity['website']),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(entity['fullAddress']),
                        ),
                        SizedBox(height: 16),
                        Text('Services:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Column(
                          children: (entity['services'] as List)
                              .map((service) => ListTile(
                                    leading: Icon(Icons.check_circle_outline),
                                    title: Text(service['name']),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // search
  void _searchEntities() async {
    final baseUrl =
        'http://10.0.2.2:3333/find-nearby?offset=1&limit=500&q=Nh%C3%A0%20h%C3%A0ng%20g%E1%BA%A7n%20%C4%91%C3%A2y&latitude=${_draggedPosition?.latitude.toString()}&longitude=${_draggedPosition?.longitude.toString()}&radius=5&isHighRating=false&openTime=08%3A00';

    final uri = Uri.parse(baseUrl);

    setState(() {
      _showCircle = true;
    });

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _entityMarkers.clear(); // Clear existing markers
          for (var entity in data["data"]) {
            _entityMarkers.add(
              Marker(
                point: LatLng(entity['location']['coordinates'][1],
                    entity['location']['coordinates'][0]),
                width: 80,
                height: 80,
                child: GestureDetector(
                  onTap: () => _showEntityDetails(entity),
                  child: Column(
                    children: [
                      SvgPicture.network(
                        entity["category"]["linkURL"],
                        width: 40,
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
            );
            print(entity["category"]["linkURL"]);
            print("entityMarkers: ${_entityMarkers.length}");
          }
        });
      } else {
        print('Failed to load entities: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching entities: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      _searchPlaces(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
              onMapEvent: (MapEvent event) {
                if (event is MapEventMove) {
                  setState(() {
                    _currentZoom = event.camera.zoom;
                  });
                }
              },
              initialCenter: const LatLng(51.5, -0.09),
              initialZoom: 13.0,
              onTap: (tapPosition, latLng) {
                _selectedPosition = latLng;

                setState(() {
                  _draggedPosition = _selectedPosition;
                  _isDragging = true;
                  _showCircle = false;
                });
              },
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                scrollWheelVelocity: 0.005,
              )),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            MarkerLayer(markers: _markers),
            MarkerLayer(markers: _entityMarkers),
            if (_draggedPosition != null && _showCircle)
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: _draggedPosition!,
                    radius: 500 * pow(2, (_currentZoom - 13)).toDouble(),
                    color: Colors.blue.withOpacity(0.2),
                    borderColor: Colors.blue,
                    borderStrokeWidth: 2,
                  ),
                ],
              ),
            if (_isDragging && _draggedPosition != null)
              MarkerLayer(markers: [
                Marker(
                    point: _draggedPosition!,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.indigo,
                      size: 40,
                    ))
              ]),
            if (_mylocation != null)
              MarkerLayer(markers: [
                Marker(
                    point: _mylocation!,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 40,
                    ))
              ])
          ],
        ),
        Positioned(
          top: 40,
          left: 15,
          right: 15,
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      hintText: "... Search place",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _isSearching
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _isSearching = false;
                                  _searchResults = [];
                                });
                              },
                              icon: const Icon(Icons.clear))
                          : null),
                  onTap: () {
                    setState(() {
                      print("tap");
                      _isSearching = true;
                    });
                  },
                ),
              ),
              if (_isSearching && _searchResults.isNotEmpty)
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final place = _searchResults[index];
                      return ListTile(
                        title: Text(place['display_name']),
                        onTap: () {
                          double lat = double.parse(place['lat']);
                          double lon = double.parse(place['lon']);
                          _moveToLocation(lat, lon);
                        },
                      );
                    },
                  ),
                )
            ],
          ),
        ),
        _isDragging == false
            ? Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton(
                        onPressed: () {
                          _searchEntities();
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.indigo,
                        child: const Icon(Icons.search),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isDragging = true;
                        });
                      },
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.add_location),
                    ),
                  ],
                ))
            : Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton(
                        onPressed: () {
                          _searchEntities();
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.indigo,
                        child: const Icon(Icons.search),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isDragging = false;
                          _entityMarkers.clear();
                        });
                      },
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.wrong_location),
                    ),
                  ],
                ),
              ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: () {
                  _showCurrentLocation();
                },
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo,
                child: const Icon(Icons.location_searching_rounded),
              ),
              if (_isDragging)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (_draggedPosition != null) {
                        _showMarkerDialog(context, _draggedPosition!);
                      }
                      setState(() {
                        _isDragging = false;
                        _draggedPosition = null;
                      });
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.check),
                  ),
                ),
            ],
          ),
        ),
      ],
    ));
  }
}
