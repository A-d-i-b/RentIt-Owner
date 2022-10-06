mixin PowerBackup {
  final powerBackUpOptions = [
    'N/A',
    'Available',
    'Not Available',
  ];
}

mixin AcRooms {
  final acRoomsOptions = [
    'N/A',
    'Available',
    'Not Available',
  ];
}

mixin Maintenance {
  final maintenanceOptions = [
    'N/A',
    'Included',
    'Not Included',
  ];
}

mixin ElectricityCharges {
  final electricityOptions = [
    'N/A',
    'Included',
    'Not Included',
  ];
}

mixin AvailableFor {
  final availableForOptions = [
    'N/A',
    'Male',
    'Female',
    'Both',
  ];
}

mixin PreferredTenants {
  final preferredTenantOptions = [
    'N/A',
    'Students',
  ];
}

mixin Food {
  final foodOptions = [
    'N/A',
    'Available',
    'Not Available',
  ];
}

mixin Wifi {
  final wifiOptions = [
    'N/A',
    'Available',
    'Not Available',
  ];
}

mixin Furniture {
  final furnitureOptions = [
    'N/A',
    'Furnished',
    'Semi Furnished',
    'Unfurnished',
  ];
}

mixin BHK {
  final bhkOptions = ((int maxBHK) {
    final options = <String>['N/A'];

    for (var i = 1; i <= maxBHK; i++) {
      options.add('$i BHK');
    }
    return options;
  })(4);
}
