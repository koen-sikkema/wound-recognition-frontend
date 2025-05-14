import 'package:intl/intl.dart';

class FilenameHelper
{
  static String generateDefaultFilename()
  {

    final now = DateTime.now();

    final date = DateFormat('dd-MM-yyyy').format(now);
    final time = '${DateFormat('HH').format(now)}u${DateFormat('mm').format(now)}m${DateFormat('ss').format(now)}s';
    return 'Dag_${date} - Tijd_${time}u.jpg';

  }

  static String getFinalFilename(String? customName)
  {
    return (customName?.trim().isNotEmpty ?? false)
        ? '${customName!.trim()}.jpg'
        : generateDefaultFilename();
  }
}
