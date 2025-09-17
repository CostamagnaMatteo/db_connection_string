/// This class is for internal usage only
/// [GenericConnectionString] contains a definition of all the supported field used by
/// the connection string supported by the library
class GenericConnectionString {
  /// Define the local path or the url to the resource
  final String? dataSource;

  final String? version;
  final String? password;
  //TODO: property used by Sqlite
  final bool? isNew;
  //TODO: property used by Sqlite
  //ATTENTION: maybe this property could became an enum of supported encoding
  final bool? useUTF16Encoding;

  GenericConnectionString({
    this.dataSource,
    this.version,
    this.password,
    this.isNew,
    this.useUTF16Encoding,
  });
}
