import 'package:favorito_user/component/ImageMaster.dart';
import 'package:favorito_user/config/SizeManager.dart';
import 'package:favorito_user/model/appModel/search/BusinessProfileData.dart';
import 'package:favorito_user/utils/MyColors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:favorito_user/ui/business/BusinessProfileProvider.dart';
import 'package:favorito_user/ui/home/RatingHolder.dart';
import 'package:favorito_user/ui/home/ServicesOfBusiness.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class business_on_map extends StatefulWidget {
  List<BusinessProfileData> list;

  business_on_map({this.list});
  @override
  _business_on_mapState createState() => _business_on_mapState();
}

class _business_on_mapState extends State<business_on_map> {
  SizeManager sm;

  @override
  Widget build(BuildContext context) {
    sm = SizeManager(context);
    return Container(
        height: sm.h(24),
        padding: EdgeInsets.all(4.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.list.length,
            itemBuilder: (BuildContext context, int i) {
              var data = widget.list[i];
              return InkWell(
                onTap: () {
                  Provider.of<BusinessProfileProvider>(context, listen: false)
                      .setBusinessId(data.businessId);
                  Navigator.of(context).pushNamed('/businessProfile');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  elevation: 10,
                  child: SizedBox(
                    width: sm.w(84),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                  height: sm.h(24),
                                  width: sm.h(4),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child:
                                          ImageMaster(url: data.photo ?? ''))),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: sm.w(2), top: sm.h(1)),
                                      child: Text(data.businessName,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800)),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: sm.w(2), top: sm.h(1)),
                                        child: RatingBarIndicator(
                                            rating: double.parse(
                                                data.avgRating.toString()),
                                            itemBuilder: (context, index) =>
                                                Icon(Icons.star, color: myRed),
                                            itemCount: 5,
                                            itemSize: 12.0,
                                            direction: Axis.horizontal)),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: sm.w(2), top: sm.h(1)),
                                      child: Text(
                                          "${((data.distance / 1.6)?.toStringAsFixed(1))} km\n${data.townCity ?? ''}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: sm.w(2), top: sm.h(1)),
                                      child: Text(data.businessStatus ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: data.businessStatus
                                                              .toLowerCase() ==
                                                          'offline'
                                                      ? myRed
                                                      : Colors.green)),
                                    ),
                                    (data.startHours != null &&
                                            data.endHours != null)
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                left: sm.w(2), top: sm.h(1)),
                                            child: Text(
                                                "Opens | ${data.startHours.substring(0, 5)}\nCloses | ${data.endHours.substring(0, 5)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                        fontSize: sm.w(2.8),
                                                        fontWeight:
                                                            FontWeight.w300)),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                left: sm.w(2), top: sm.h(1)),
                                            child: Text(
                                              "Opens | 00:00\nCloses | 00:00",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                      fontSize: sm.w(2.8),
                                                      fontWeight:
                                                          FontWeight.w300),
                                            ),
                                          ),
                                  ]),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: myRedLight0),
                                //    top: sm.h(5), right: sm.h(0)),
                                child: IconButton(
                                    icon:
                                        Icon(Icons.call_outlined, color: myRed),
                                    onPressed: () =>
                                        launch("tel://${data.phone}")),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              );
            }));
  }
}
