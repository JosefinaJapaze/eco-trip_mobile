import 'package:ecotrip/data/local/constants/db_constants.dart';
import 'package:ecotrip/models/trip/trip.dart';
import 'package:ecotrip/models/trip/trip_list.dart';
import 'package:sembast/sembast.dart';

class TripDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _tripsStore = intMapStoreFactory.store(DBConstants.STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Database _db;

  // Constructor
  TripDataSource(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(Trip trip) async {
    return await _tripsStore.add(_db, trip.toMap());
  }

  Future<int> count() async {
    return await _tripsStore.count(_db);
  }

  Future<List<Trip>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _tripsStore.find(
      _db,
      finder: finder,
    );

    // Making a List<Trip> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final trip = Trip.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      trip.id = snapshot.key;
      return trip;
    }).toList();
  }

  Future<TripList> getTripsFromDb() async {
    print('Loading from database');

    // trip list
    var tripsList;

    // fetching data
    final recordSnapshots = await _tripsStore.find(
      _db,
    );

    // Making a List<Trip> out of List<RecordSnapshot>
    if (recordSnapshots.length > 0) {
      tripsList = TripList(
          trips: recordSnapshots.map((snapshot) {
        final trip = Trip.fromMap(snapshot.value);
        // An ID is a key of a record from the database.
        trip.id = snapshot.key;
        return trip;
      }).toList());
    }

    return tripsList;
  }

  Future<int> update(Trip trip) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(trip.id));
    return await _tripsStore.update(
      _db,
      trip.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(Trip trip) async {
    final finder = Finder(filter: Filter.byKey(trip.id));
    return await _tripsStore.delete(
      _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _tripsStore.drop(
      _db,
    );
  }
}
