import 'dart:io';

void main(List<String> arguments) {
  bool keepAppOn = true;
  TripsCatalogue tripsCatalogue = TripsCatalogue();
  tripsCatalogue.savedTrips = [];
  while (keepAppOn) {
    print(
        'Pick an option number:\n1) Add a trip\n2) Edit a trip\n3) Delete a trip\n4) View trips\n5) Search trips\n6) Reserve a trip\nOr press anything else to exit');
    int pickedOption = int.parse(stdin.readLineSync()!);
    switch (pickedOption) {
      case 1:
        print('Type the info of the trip');
        Trip trip = Trip();
        print('Enter the id');
        trip.id = int.parse(stdin.readLineSync()!);
        print('Enter the passanger limit');
        trip.passengerLimit = int.parse(stdin.readLineSync()!);
        print('Enter the passanger number');
        trip.passengerNumber = int.parse(stdin.readLineSync()!);
        print('Enter the price');
        trip.price = double.parse(stdin.readLineSync()!);
        print('Enter the year');
        int year = int.parse(stdin.readLineSync()!);
        print('Enter the month');
        int month = int.parse(stdin.readLineSync()!);
        print('Enter the day');
        int day = int.parse(stdin.readLineSync()!);
        trip.date = DateTime.utc(year, month, day);
        print('Enter the location');
        trip.location = stdin.readLineSync()!;
        tripsCatalogue.addTrip(trip);
        break;
      case 2:
        print('Type the number of the trip you want to edit');
        int index = int.parse(stdin.readLineSync()!);
        Trip trip = tripsCatalogue.savedTrips![index - 1]!;
        print('Enter the id');
        trip.id = int.parse(stdin.readLineSync()!);
        print('Enter the passanger limit');
        trip.passengerLimit = int.parse(stdin.readLineSync()!);
        print('Enter the passanger number');
        trip.passengerNumber = int.parse(stdin.readLineSync()!);
        print('Enter the price');
        trip.price = double.parse(stdin.readLineSync()!);
        print('Enter the year');
        int year = int.parse(stdin.readLineSync()!);
        print('Enter the month');
        int month = int.parse(stdin.readLineSync()!);
        print('Enter the day');
        int day = int.parse(stdin.readLineSync()!);
        trip.date = DateTime.utc(year, month, day);
        print('Enter the location');
        trip.location = stdin.readLineSync()!;
        tripsCatalogue.deleteTrip(index - 1);
        tripsCatalogue.addTrip(trip);
        break;
      case 3:
        print('Type the number of the trip you want to delete');
        int index = int.parse(stdin.readLineSync()!);
        tripsCatalogue.deleteTrip(index - 1);
        break;
      case 4:
        tripsCatalogue.viewTrips();
        break;
      case 5:
        print('Type the price of the trip you want to search');
        double price = double.parse(stdin.readLineSync()!);
        tripsCatalogue.searchTrips(price);
        break;
      case 6:
        print('Type the number of the trip you want to reserve');
        int index = int.parse(stdin.readLineSync()!);
        tripsCatalogue.reserveTrip(tripsCatalogue.savedTrips?[index - 1]);
        break;
      default:
        keepAppOn = false;
        break;
    }
  }
}

const String idField = 'id';
const String passengerLimitField = 'passengerLimit';
const String passengerNumberField = 'passengerNumber';
const String priceField = 'price';
const String locationField = 'location';
const String dateField = 'date';

class Trip {
  int? id, passengerLimit, passengerNumber;
  double? price;
  String? location;
  DateTime? date;

  Trip();

  Map toMap() {
    Map map = {};
    map[idField] = id;
    map[passengerLimitField] = passengerLimit;
    map[passengerNumberField] = passengerNumber;
    map[priceField] = price;
    map[locationField] = location;
    map[dateField] = date;
    return map;
  }

  Trip.fromMap(Map map) {
    id = map[idField];
    passengerLimit = map[passengerLimitField];
    passengerNumber = map[passengerNumberField];
    price = map[priceField];
    location = map[locationField];
    date = map[dateField];
  }
}

class TripsCatalogue {
  List? savedTrips;

  void addTrip(Trip trip) {
    savedTrips?.add(trip);
  }

  void deleteTrip(int index) {
    savedTrips?.removeAt(index);
  }

  void viewTrips() {
    savedTrips?.sort((a, b) {
      return a.toMap()[dateField].compareTo(b.toMap()[dateField]);
    });
    savedTrips?.forEach((element) {
      element.toMap().forEach((k, v) => print("$k: $v"));
    });
  }

  void searchTrips(double price) {
    savedTrips?.forEach((element) {
      if (element.toMap()[priceField] == price) {
        print(element.toMap());
      }
    });
  }

  void reserveTrip(Trip trip) {
    Map map = trip.toMap();
    if (map[passengerLimitField] > map[passengerNumberField]) {
      map[passengerNumberField]++;
      trip = Trip.fromMap(map);
    } else {
      print('Trip fully reserved');
    }
  }
}
