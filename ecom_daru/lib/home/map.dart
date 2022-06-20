import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class DisplayMap extends StatefulWidget {
  @override
  _DisplayMapState createState() => _DisplayMapState();
}
/* 
const kGoogleApiKey = "AIzaSyByjyIxwG4NQSl-SEjw4H-tgT9YAp-VvhQ";
final homeScaffoldKey = GlobalKey<ScaffoldState>(); */

class _DisplayMapState extends State<DisplayMap> {
  GoogleMapController? googleMapController;
  bool mapToggel = false;
  var currLoc;
  var searchAddress;
  List<Marker> markers = [];
  // PickResult? selectedPlace;

  void initState() {
    super.initState();
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (value) => {
        setState(
          () {
            currLoc = value;
            mapToggel = true;
            markers.add(
              newMarker(),
            );
          },
        ),
      },
    );
  }

  Marker newMarker() {
    return Marker(
      markerId: MarkerId('markerId'),
      position: LatLng(
        currLoc.latitude,
        currLoc.longitude,
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      googleMapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  key: homeScaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            mapToggel
                ? GoogleMap(
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        currLoc.latitude,
                        currLoc.longitude,
                      ),
                      zoom: 20,
                    ),
                    markers: Set.from(markers),
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    onMapCreated:
                        // onMapCreated ,getCurrentLocation()
                        (GoogleMapController controller) {
                      // ignore: unnecessary_statements
                      onMapCreated;
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            'Loading Please Wait',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            Positioned(
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(16),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Location',
                    suffixIcon: IconButton(
                      onPressed: () {
                        print('object');
                        searchLocation();
                      },
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      searchAddress = val;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  searchLocation() {
    locationFromAddress(searchAddress).then((result) {
      print('LOCATION Latitude = ${result[0].latitude}');
      print('LOCATION Longitude = ${result[0].longitude}');
      if (googleMapController != null) {
        print('if blk');
        return SizedBox();
      } else {
        print('else blk');
        googleMapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                result[0].latitude,
                result[0].longitude,
              ),
              zoom: 10.0,
            ),
          ),
        );
      }
    });
  }
}
/*  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.toString());
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      scaffold.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }
  } */
  /*   
             */
 /* ElevatedButton(
              child: Text("Load Google Map"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PlacePicker(
                        apiKey: kGoogleApiKey,
                        initialPosition: LatLng(currLoc.latitude, currLoc.longitude),
                        useCurrentLocation: true,
                        selectInitialPosition: true,

                        usePlaceDetailSearch: true,
                        onPlacePicked: (result) {
                          selectedPlace = result;
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        forceSearchOnZoomChanged: true,
                        automaticallyImplyAppBarLeading: false,
                        autocompleteLanguage: "en",
                        region: 'In',
                        selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                          print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                          return isSearchBarFocused
                              ? Container()
                              : FloatingCard(
                                  bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                  leftPosition: 0.0,
                                  rightPosition: 0.0,
                                  width: 500,
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: state == SearchingState.Searching
                                      ? Center(child: CircularProgressIndicator())
                                      : ElevatedButton(
                                          child: Text("Pick Here"),
                                          onPressed: () {
                                            // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                            //            this will override default 'Select here' Button.
                                            print("do something with [selectedPlace] data");
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                );
                        },
                      /*   pinBuilder: (context, state) {
                          if (state == PinState.Idle) {
                            return Icon(Icons.favorite_border);
                          } else {
                            return Icon(Icons.favorite);
                          }
                        }, */
                      );
                    },
                  ),
                );
              },
            ),
            selectedPlace == null
                ? Container()
                : Text(selectedPlace!.formattedAddress ?? ""), */
            
            /* Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  // show input autocomplete with selected mode
                  // then get the Prediction selected
                  Prediction? p = await PlacesAutocomplete.show(
                      context: context, apiKey: kGoogleApiKey);
              displayPrediction(p!, homeScaffoldKey.currentState!);
                },
                child: Text('Find address'),
              ),
            ), */