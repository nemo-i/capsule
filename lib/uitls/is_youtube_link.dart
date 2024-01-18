// bool isYouTubeLink(String input) {
//   RegExp regExp = RegExp(
//     r"(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})",
//   );

//   return regExp.hasMatch(input);
// }
// bool isYouTubeLink(String input) {
//   RegExp regExp = RegExp(
//     r"(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})",
//   );

//   return regExp.hasMatch(input);
// }
bool isYouTubeLink(String input) {
  RegExp regExp = RegExp(
    r"(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&](?:v=|list=))|youtu\.be\/)([a-zA-Z0-9_-]{11})",
  );

  return regExp.hasMatch(input);
}
