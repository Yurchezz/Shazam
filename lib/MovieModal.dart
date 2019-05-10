class MovieModal {
  String movieName;
  String fileData;
  String duration;

  MovieModal({this.movieName, this.fileData, this.duration});

  MovieModal.fromJson(Map parsedJson) {
    movieName = parsedJson["movieName"];
    fileData = parsedJson["fileData"];
    duration = parsedJson["duration"];

    Map toJson() {
      return {"movieName": movieName, "fileData": fileData, "duration": duration};
    }
  }
}