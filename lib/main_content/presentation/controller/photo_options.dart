import 'package:image_picker/image_picker.dart';

class PhotoOptions{
  final picker = ImagePicker();

  Future<XFile> getImage() async {
    try{
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery, maxWidth: 600, maxHeight: 600, imageQuality: 1);
      if(pickedFile != null){
        return pickedFile;
      }else{
        print('Image selection cancelled.');
        throw Exception("Image selection cancelled.");
      }
    }catch(error){
      print('Error picking image: $error');
      throw Exception('Error picking image: $error');
    }
  }

}
