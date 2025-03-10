// @dart=2.9
import 'package:favorito_user/config/SizeManager.dart';
import 'package:favorito_user/model/appModel/search/BusinessProfileData.dart';
import 'package:favorito_user/ui/business/BusinessProfileProvider.dart';
import 'package:favorito_user/ui/search/business_on_map.dart';
import 'package:favorito_user/utils/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class ClusterMap extends StatefulWidget {
  List<BusinessProfileData> list;
  ClusterMap({this.list});
  @override
  _ClusterMapState createState() => _ClusterMapState();
}

class _ClusterMapState extends State<ClusterMap> {
  List<BusinessProfileData> businessLocalList = [];

  List<BusinessProfileData> data = [];
  final PopupController _popupController = PopupController();
  SizeManager sm;
  int pointIndex;
  @override
  void initState() {
    pointIndex = 0;

    data.addAll(widget.list);

    for (int i = 0; i < data.length; i++) {
      if (data[i].location == null) data.removeAt(i);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sm = SizeManager(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: FlutterMap(
              options: MapOptions(
                center: (data
                        .map((e) => Marker(
                              anchorPos: AnchorPos.align(AnchorAlign.center),
                              height: 30,
                              width: 30,
                              point: LatLng(
                                  double.parse(
                                      e.location.split(',').first.trim()),
                                  double.parse(
                                      e.location.split(',').last.trim())),
                              builder: (ctx) => Icon(Icons.pin_drop),
                            ))
                        .toList(growable: true))
                    .first
                    .point,
                zoom: 5,
                maxZoom: 15,
                plugins: [
                  MarkerClusterPlugin(),
                ],
                onTap: (_) => _popupController
                    .hidePopup(), // Hide popup when the map is tapped.
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerClusterLayerOptions(
                  maxClusterRadius: 120,
                  size: Size(100, 60),
                  anchor: AnchorPos.align(AnchorAlign.center),
                  fitBoundsOptions:
                      FitBoundsOptions(padding: EdgeInsets.all(50)),
                  markers: data
                      .map((e) => Marker(
                            anchorPos: AnchorPos.align(AnchorAlign.center),
                            height: 50,
                            width: 200,
                            point: LatLng(
                                double.parse(
                                    e.location.split(',').first.trim()),
                                double.parse(
                                    e.location.split(',').last.trim())),
                            builder: (ctx) => InkWell(
                              onTap: () {
                                Provider.of<BusinessProfileProvider>(context,
                                    listen: false)
                                  ..setBusinessId(e.businessId)
                                  ..refresh(1);
                                Navigator.pushNamed(
                                    context, '/businessProfile');
                              },
                              child: Column(children: [
                                Container(
                                  color: Colors.yellow,
                                  padding: EdgeInsets.all(1),
                                  child: Text(
                                    e.businessName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontSize: 12, color: Colors.black),
                                  ),
                                ),
                                Icon(Icons.pin_drop)
                              ]),
                            ),
                            //
                          ))
                      .toList(growable: true),
                  polygonOptions: PolygonOptions(
                      borderColor: Colors.blueAccent,
                      color: Colors.black12,
                      borderStrokeWidth: 3),
                  popupOptions: PopupOptions(
                      popupSnap: PopupSnap.markerTop,
                      popupController: _popupController,
                      popupBuilder: (_, marker) => Container(
                            width: 0,
                            height: 0,
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () => debugPrint('Popup tap!'),
                                child: Text(
                                  '',
                                  //${marker.point}
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: Colors.black),
                                )),
                          )),
                  builder: (context, markers) {
                    return FloatingActionButton(
                      onPressed: null,
                      child: Text(markers.length.toString()),
                    );
                  },
                ),
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 50),
          //   height: sm.h(10),
          //   child: Row(
          //     children: [
          // Expanded(
          //   child: Padding(
          //       padding: EdgeInsets.only(
          //           left: sm.w(5), right: sm.w(5), top: sm.h(1)),
          //       child: EditTextComponent(
          //           // controller: _mySearchEditTextController,
          //           title: "Search",
          //           suffixTxt: '',
          //           hint: 'Search',
          //           security: false,
          //           valid: true,
          //           maxLines: 1,
          //           maxlen: 100,
          //           keyBoardAction: TextInputAction.search,
          //           // atSubmit: (_val) => executeSearch(SearchReqData(
          //           //     text: _mySearchEditTextController.text)),
          //           prefixIcon: 'search',
          //           // prefClick: () => executeSearch(SearchReqData(
          //           //     text: _mySearchEditTextController.text)
          //           //     )
          //               )
          //               ),
          // ),
          //Don't remove it is filter part for search

          // Padding(
          //   padding: EdgeInsets.only(right: sm.w(5), bottom: sm.h(2)),
          //   child: Card(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(8)),
          //       ),
          //       elevation: 10,
          //       child: Padding(
          //           padding: const EdgeInsets.all(12.0),
          //           child: InkWell(
          //             onTap: () => showPopup(
          //                 sm, context, _popupBody(sm), 'Select Filters'),
          //             child: SvgPicture.asset('assets/icon/filter.svg',
          //                 height: sm.h(2), fit: BoxFit.fitHeight),
          //           ))),
          // ),
          //     ],
          //   ),
          // ),
          Positioned(
            bottom: sm.h(8),
            left: 0,
            right: 0,
            child: business_on_map(list: data),
          ),
        ],
      ),
    );
  }
}
