import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source)async{
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file!= null){

    
    return await _file.readAsBytes();
    
  }
    else {
      return null;
    }
}

showImage(var img) {
  if(img !=null){
    return true;
  }
  else {
   return false;
  }
}
showSnackBar(String content,BuildContext context)
{
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content))
  );

}

  AlertDialog showAlertDialogInPosting(){

    return const AlertDialog(
      title: Text("Your post is uploading.."),
      content: Text('pleaseWait'),
    );
  }