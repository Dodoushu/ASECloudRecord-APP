import 'package:file_picker/file_picker.dart';

Future getSingleImagePath() async{
  String SingleFilePath;
  SingleFilePath = await FilePicker.getFilePath(type: FileType.image);
  return SingleFilePath;
}

Future getMultiImagesPath() async{
  Map<String,String> imagesPaths;
  imagesPaths = await FilePicker.getMultiFilePath(type: FileType.image);

//  Options
//  List<String> allNames = filePaths.keys; // List of all file names
//  List<String> allPaths = filePaths.values; // List of all paths
//  String someFilePath = filePaths['fileName']; // Access a file path directly by its name (matching a key)

  return imagesPaths;
}

Future getMultiFilesPath() async{
  Map<String,String> filesPaths;
  filesPaths = await FilePicker.getMultiFilePath();

//  Options
//  List<String> allNames = filesPaths.keys; // List of all file names
//  List<String> allPaths = filesPaths.values; // List of all paths
//  String someFilePath = filesPaths['fileName']; // Access a file path directly by its name (matching a key)

  return filesPaths;
}

Future getMultiFilesPathKeys() async{
  Map<String,String> filesPaths;
  filesPaths = await FilePicker.getMultiFilePath();

//  Options
  List<String> allNames = filesPaths.keys; // List of all file names
  List<String> allPaths = filesPaths.values; // List of all paths
  String someFilePath = filesPaths['fileName']; // Access a file path directly by its name (matching a key)

  return allNames;
}