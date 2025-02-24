import 'package:another_flushbar/flushbar_helper.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/ui/join_trip/store/join_trip_store.dart';
import 'package:ecotrip/ui/join_trip/widgets/trip_offer_card.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:ecotrip/widgets/navigate_widget.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

class JoinScheduledScreen extends StatefulWidget {
  @override
  _JoinScheduledScreenState createState() => _JoinScheduledScreenState();
}

class _JoinScheduledScreenState extends State<JoinScheduledScreen> {
  late JoinTripStore _store;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = getIt<JoinTripStore>();
    Geolocator.getCurrentPosition().then((position) {
      _store.listNearbyTrips(
          position.latitude, position.longitude, "scheduled");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: 'join_scheduled_trip_title'),
      body: _buildBody(),
    );
  }

  List<Widget> _buildTripList() {
    if (_store.nearbyTripsFuture.status == FutureStatus.pending) {
      return [];
    }
    List<Widget> tripCards = [];
    for (var trip in _store.nearbyTripsFuture.value ?? []) {
      tripCards.add(
        TripOfferCard(
          tripOffer: TripOffer(
            tripId: trip?.id ?? 0,
            totalSeats: trip?.totalSeats ?? 0,
            type: trip?.type ?? "",
            cost: trip?.cost ?? 0,
            creator: trip?.creator ?? "",
            toLat: trip?.addressTo?.latitude ?? 0,
            toLon: trip?.addressTo?.longitude ?? 0,
            fromLat: trip?.addressFrom?.latitude ?? 0,
            fromLon: trip?.addressFrom?.longitude ?? 0,
            fromAddress: trip?.addressFrom?.address ?? "",
            toAddress: trip?.addressTo?.address ?? "",
            timeOfDay: trip?.scheduledTripParams?.startTime ?? "",
            dayOfWeek: trip?.frequentTripParams?.dayOfWeek?.name ?? "",
            date: trip?.scheduledTripParams?.startDate ?? DateTime.now(),
          ),
        ),
      );
    }
    return tripCards;
  }

  Widget _buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text("Viajes disponibles actualmente:"),
                SizedBox(height: 20),
                ..._buildTripList(),
              ],
            ),
          ),
        ),
        Observer(
          builder: (context) {
            return _store.success
                ? NavigateWidget(Routes.home)
                : _showErrorMessage(_store.errorStore.errorMessage);
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _store.isLoading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        ),
        _buildTextButton("/join_scheduled_trip_map"),
      ],
    );
  }

  Widget _buildTextButton(route) {
    return Positioned(
      bottom: 20,
      left: MediaQuery.of(context).size.width * 0.2,
      right: MediaQuery.of(context).size.width * 0.2,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.lime,
        ),
        child: TextButton(
          onPressed: () => Navigator.of(context).pushNamed(route),
          child: Text(
            'VER MAPA',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: "Error",
            duration: Duration(seconds: 3),
          ).show(context);
        }
      });
    }
    return SizedBox.shrink();
  }
}
