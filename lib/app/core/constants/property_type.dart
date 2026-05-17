enum PropertyType { villa, apartment, land, all }

PropertyType propertyTypeFromString(String value) {
  switch (value) {
    case "villa":
      return PropertyType.villa;

    case "apartment":
      return PropertyType.apartment;

    case "land":
      return PropertyType.land;

    case "الكل":
      return PropertyType.all;

    default:
      return PropertyType.all; // fallback
  }
}
