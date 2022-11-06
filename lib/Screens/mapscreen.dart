import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glass/glass.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:timelines/timelines.dart';
import 'package:latlong2/latlong.dart';
import 'package:wependio/Screens/chatmainscreen.dart';
// import 'package:timelines/timelines.dart';
// import 'package:wependio/Widgets/successtimeline.dart';

import '../Widgets/process_timeline.dart';
import '../constants.dart';

class Mapscreen extends StatefulWidget {
  const Mapscreen({Key? key}) : super(key: key);

  @override
  State<Mapscreen> createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  late List<Polyline> polylines = [
    Polyline(
      points: [
        LatLng(50.5, -0.09),
        LatLng(51.3498, -6.2603),
        LatLng(53.8566, 2.3522),
      ],
      strokeWidth: 4,
      color: Colors.amber,
    ),
  ];

  // Future<List<Polyline>> getPolylines() async {
  //   final polyLines = [
  //     Polyline(
  //       points: [
  //         LatLng(50.5, -0.09),
  //         LatLng(51.3498, -6.2603),
  //         LatLng(53.8566, 2.3522),
  //       ],

  //       strokeWidth: 4,
  //       color: Colors.amber,
  //     ),
  //   ];
  //   await Future<void>.delayed(const Duration(seconds: 3));
  //   return polyLines;
  // }
//   final GlobalKey globalKey = GlobalKey();
//   // 1
//   Completer<GoogleMapController> _controller = Completer();
// // 2
//   static final CameraPosition _myLocation =
//       CameraPosition(target: LatLng(51.1657, 10.4515), zoom: 7);
//   Set<Marker> _markers = <Marker>{};
//   gettingmarkers() async {
//     _markers.add(
//       Marker(
//         markerId: MarkerId('downloadResizePictureCircle'),
//         onTap: () {
//           showModalBottomSheet(
//               backgroundColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20)),
//               ),
//               context: context,
//               builder: (context) {
//                 return Discoverbottom();
//               });
//         },
//         icon: await MarkerIcon.downloadResizePictureCircle(
//             'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTYYTLgX6ZLrYwz-3c7iB3gVs87jIKnbbg3Ba-Gt8ykJF2uZgu4',
//             size: 150,
//             addBorder: true,
//             borderColor: maincolor,
//             borderSize: 15),
//         position: LatLng(51.1657, 10.4515),
//       ),
//     );
//     _markers.add(
//       Marker(
//         markerId: MarkerId('downloadResizePictureCircle1'),
//         onTap: () {
//           showModalBottomSheet(
//               backgroundColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.horizontal(
//                   left: Radius.circular(20),
//                   right: Radius.circular(20),
//                 ),
//               ),
//               context: context,
//               builder: (context) {
//                 return Discoverbottom();
//               });
//         },
//         icon: await MarkerIcon.downloadResizePictureCircle(
//             'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTYYTLgX6ZLrYwz-3c7iB3gVs87jIKnbbg3Ba-Gt8ykJF2uZgu4',
//             size: 150,
//             addBorder: true,
//             borderColor: maincolor,
//             borderSize: 15),
//         position: LatLng(52.5200, 13.4050),
//       ),
//     );
//     setState(() {});
//   }

  String _mapStyle = "";
  late MapZoomPanBehavior _zoomPanBehavior;

  //late GoogleMapController mapController;
  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior(
      enableDoubleTapZooming: true,
    );
    // polylines = getPolylines();
    // gettingmarkers();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   rootBundle.loadString("Assets/style/map_style.txt").then((string) {
    //     print(string);
    //     _mapStyle = string;
    //     setState(() {});
    //   });
    // });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(),
            preferredSize: Size(MediaQuery.of(context).size.width, 10)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ImageIcon(
            AssetImage("Assets/Images/wependiosmall.png"),
            size: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        title: ImageIcon(
          AssetImage("Assets/Images/wependiologo2.png"),
          size: 100,
          color: Colors.white,
        ),
        // leadingWidth: 50,
        backgroundColor:
            AdaptiveTheme.of(context).theme.brightness == Brightness.light
                ? maincolor
                : Color(0xff4F5666),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Chatmainscreen();
                    }));
                  },
                  child: SvgPicture.asset(
                    "Assets/Images/message.svg",
                    height: 24,
                    width: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "Assets/Images/notification.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "Assets/Images/add.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      //extendBody: true,
      // 1
      body: Stack(
        //fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          SfMaps(
            layers: [
              MapTileLayer(
                zoomPanBehavior: _zoomPanBehavior,
                urlTemplate: AdaptiveTheme.of(context).brightness ==
                        Brightness.dark
                    ? "https://api.mapbox.com/styles/v1/wependio/cl84rcyip000014rt6zyqyugh/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoid2VwZW5kaW8iLCJhIjoiY2w4MTlneWE5MDI0YzN2bXl1eHV0dnNucyJ9.8GyGjlfDECYD1cjcOObdtQ"
                    : 'https://api.mapbox.com/styles/v1/wependio/cl81tqo7y00dd14mpf83y4a6g/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoid2VwZW5kaW8iLCJhIjoiY2w4MTlneWE5MDI0YzN2bXl1eHV0dnNucyJ9.8GyGjlfDECYD1cjcOObdtQ',
                initialZoomLevel: 2,
                initialFocalLatLng: MapLatLng(28.644800, 77.216721),
              ),
            ],
          ),

          // FlutterMap(
          //   options: MapOptions(
          //     minZoom: 2,
          //     maxZoom: 18,
          //     zoom: 2,
          //     center: LatLng(51.5090214, -0.1982948),
          //   ),
          //   layers: [
          //     TileLayerOptions(
          //       urlTemplate:
          //           "https://api.mapbox.com/styles/v1/itsatifriaz/cl81grbg8000u14pnci54vb3t/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaXRzYXRpZnJpYXoiLCJhIjoiY2w4MWdvMnI4MDA1NjN2bnVwcmdzZTIweiJ9.y0RicZtFCNT3xZKz4PCe0Q",
          //       additionalOptions: {
          //         'mapStyleId': "cl81grbg8000u14pnci54vb3t",
          //         'accessToken':
          //             "pk.eyJ1IjoiaXRzYXRpZnJpYXoiLCJhIjoiY2w4MWdvMnI4MDA1NjN2bnVwcmdzZTIweiJ9.y0RicZtFCNT3xZKz4PCe0Q",
          //       },
          //     ),
          //     PolylineLayerOptions(
          //       polylines: polylines,
          //       polylineCulling: true,
          //     )
          //   ],
          // ),

          // GoogleMap(
          //   // circles: Set.from(
          //   //   [
          //   //     Circle(
          //   //       circleId: CircleId('currentCircle'),
          //   //       center: LatLng(51.1657, 10.4515),
          //   //       radius: 10000,
          //   //       fillColor: Colors.blue.shade100.withOpacity(0.5),
          //   //       strokeColor: Colors.blue.shade100.withOpacity(0.1),
          //   //     ),
          //   //   ],
          //   // ),
          //   myLocationButtonEnabled: false,
          //   rotateGesturesEnabled: false,
          //   zoomControlsEnabled: false,
          //   compassEnabled: false,
          //   polylines: {
          //     Polyline(
          //       startCap: Cap.buttCap,
          //       endCap: Cap.roundCap,
          //       polylineId: PolylineId('1'),
          //       color: maincolor,
          //       width: 2,
          //       patterns: [
          //         PatternItem.dash(10),
          //         PatternItem.gap(50),
          //       ],
          //       points: MapsCurvedLines.getPointsOnCurve(
          //           LatLng(51.1657, 10.4515), LatLng(52.5200, 13.4050)),

          //       //  const [
          //       //   LatLng(48.1351, 11.5820),
          //       //   LatLng(52.5200, 13.4050),
          //       // ],
          //     ),
          //   },
          //   markers: _markers,
          //   // 2
          //   initialCameraPosition: _myLocation,
          //   // 3
          //   mapType: MapType.normal,
          //   // 4
          //   onMapCreated: (GoogleMapController controller) {
          //     _controller.complete(controller);
          //     // mapController = controller;
          //     // setState(() {});
          //     print(_mapStyle);
          //     controller.setMapStyle(_mapStyle);
          //     // controller.setMapStyle(_mapStyle);
          //   },
          // ),
          Positioned(
            top: 20,
            child: SafeArea(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: Colors.black.withOpacity(0.4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "My",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Worldmap",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ).asGlass(
                    blurX: 40,
                    blurY: 40,
                    tileMode: TileMode.clamp,
                    frosted: true,
                    clipBorderRadius: BorderRadius.circular(15),
                    tintColor: Colors.black.withOpacity(0.2))
                // GlassmorphicContainer(
                //   width: 200,
                //   height: 70,
                //   borderRadius: 20,
                //   blur: 100,
                //   alignment: Alignment.bottomCenter,
                //   border: 0,
                //   linearGradient: LinearGradient(
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       colors: [
                //         Colors.black.withOpacity(0.4),
                //         Colors.black.withOpacity(0.4),
                //       ],
                //       stops: [
                //         0.1,
                //         1,
                //       ]),
                //   borderGradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [
                //       Color(0xFFffffff).withOpacity(0.5),
                //       Color((0xFFFFFFFF)).withOpacity(0.5),
                //     ],
                //   ),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "My",
                //         style: TextStyle(
                //           color: Colors.white,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                ),
          ),
        ],
      ),
      // Column(
      //   children: [
      //     //  MyMarker(globalKey),

      //     Expanded(
      //       child:
      //     ),
      //   ],
      // ),
    );
  }
}

class Discoverbottom extends StatefulWidget {
  const Discoverbottom({
    Key? key,
  }) : super(key: key);

  @override
  State<Discoverbottom> createState() => _DiscoverbottomState();
}

class _DiscoverbottomState extends State<Discoverbottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: AdaptiveTheme.of(context).theme.brightness == Brightness.light
            ? Colors.white
            : Colors.black.withOpacity(0.5),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: maincolor,
                  child: SvgPicture.asset(
                    "Assets/Images/expand.svg",
                    height: 24,
                    width: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 150,
                    decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Rio de Janeiro",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: maincolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "Assets/Images/location.svg",
                            height: 24,
                            width: 24,
                            color: maincolor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "MUC",
                            style: TextStyle(
                                color: maincolor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: maincolor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: Divider(
                      color: maincolor,
                      thickness: 2,
                    ),
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "112 KM",
                    style: TextStyle(
                        color: maincolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    child: Divider(
                      color: maincolor,
                      thickness: 2,
                    ),
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "Assets/Images/location.svg",
                            height: 24,
                            width: 24,
                            color: maincolor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "MUC",
                            style: TextStyle(
                                color: maincolor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: maincolor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/great-ocean-road-174028267-1494616481.jpg",
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://www.travelandleisure.com/thmb/-hjsJ26zlr8qkkxUsLiBLmBFmNw=/1600x1200/smart/filters:no_upscale()/iguazu-falls-argentina-brazil-MOSTBEAUTIFUL0921-e967cc4764ca4eb2b9941bd1b48d64b5.jpg",
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: Padding(
                  padding: EdgeInsets.all(2),
                ),
              )
              // Timeline.tileBuilder(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   builder: TimelineTileBuilder.fromStyle(
              //     // indicatorStyle: IndicatorStyle.container,
              //     endConnectorStyle: ConnectorStyle.dashedLine,
              //     // indicatorPositionBuilder: (context,index){
              //     //   return 20.0;
              //     // },

              //     contentsAlign: ContentsAlign.reverse,
              //     connectorStyle: ConnectorStyle.dashedLine,
              //     contentsBuilder: (context, index) => Padding(
              //       padding: const EdgeInsets.all(24.0),
              //       child: Text('Timeline Event $index'),
              //     ),
              //     itemCount: 3,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ).asGlass(
      clipBorderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      tintColor: Colors.white,
    );
  }
}
