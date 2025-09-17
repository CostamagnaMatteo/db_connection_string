import '../generic_connection_string.dart';

abstract interface class IMapper {
  GenericConnectionString toDbConnectionString(String str);
}
