double? parseDecimal(String text) =>
    double.tryParse(text.trim().replaceAll(',', '.'));
