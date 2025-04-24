import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class FilenameHelper
{
  static String generateDefaultFilename()
  {
    final timestamp = DateFormat(
        'dd_MMMM_yyyy_HHmm'
    ).format(
        DateTime.now()
    );
    final uuid = const Uuid().v4();
    return 'date_${timestamp}u_$uuid.jpg';
  }

  static String getFinalFilename(String? customName)
  {
    return (customName?.trim().isNotEmpty ?? false)
        ? '${customName!.trim()}.jpg'
        : generateDefaultFilename();
  }
}
