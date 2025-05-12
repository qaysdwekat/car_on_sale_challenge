class RegexValidation {
  static final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');
}

extension StringExtention on String {
  bool get isValidEmail {
    return isNotEmpty && RegexValidation.emailRegex.hasMatch(this);
  }

  bool get isValidVin {
    return isNotEmpty && RegexValidation.vinRegex.hasMatch(toUpperCase());
  }

  String get tryFixJsonMissingCommas {
    final pattern = RegExp(r'(["\d}])\s*["]');
    return replaceAllMapped(pattern, (match) {
      // Add comma between two adjacent fields if missing
      final first = match.group(1);
      return '$first",';
    });
  }
}
