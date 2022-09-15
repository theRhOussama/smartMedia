
import 'package:flutter/material.dart';
import 'package:smartmedia/utils/colors.dart';



class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType; 
  final Icon icon;
    final   String typeOfInput;
    final TextEditingController? validationPassword;
    
      
   Text?  errorText(String? value){
     if(value == null) return   const Text('holla');
     else {
       return null;
     }
  } 

   TextFieldInput(
    {
    

    Key? key,
    this.validationPassword,
     required this.typeOfInput,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    required this.icon, required  this.isPass
  } ) : super(key: key);

 static  var  radio=     (var value, var groupValue,var title,var changedValue){
  
return  
RadioListTile(value:value ,groupValue: groupValue,title: title,onChanged: changedValue,controlAffinity:ListTileControlAffinity.trailing,
tileColor: Colors.deepPurple.shade50,
);
 }
;


  @override
  Widget build(BuildContext context) {
     

     
    String passwordTestValidation='';
    
    return TextFormField(

       showCursor: true,
      controller: textEditingController,
       validator: ((value) {
        if(typeOfInput.toString()=='phoneNumber'){
              if(value?.length == 0){
              
          return 'المرجو ملء الخانه';

        }
          else if(value!.isEmpty || !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)[0,1}[-\s\./0-9]+$').hasMatch(value)){
            return"Enter correct phone Number"; 
            
          }else return null;
        }
        if(typeOfInput.toString()=='password'.toString()){
            if(value?.length == 0){
              
          return 'المرجو ملء الخانه';

        }
          else if(value!.isEmpty || value.length<6){
            return'طول القن السري يجب أن يتعدى 6';
          }
          else {
              return null;
          }

        }
        if(typeOfInput.toString()=='confirmPassword'.toString()){
          if(value?.length == 0){
                      
                      return 'المرجو ملء الخانه';
          }
          else if(validationPassword!= null &&    validationPassword!.text !=textEditingController.text ){

            return 'القن السري غير مطابق';

          }
          else return null;
        }
        if(typeOfInput.toString()=='email'.toString())
        {
             if(value?.length == 0){
          return 'المرجو ملء الخانه';

        }
        
         else  if(  value!.isEmpty ||!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
          return 'المرجو أدخال بريد الكتروني مناسب';
          else return null;}

        
        if(typeOfInput.toString()=='text'.toString()) {
             if(value?.length == 0){
          return 'المرجو ملء الخانه';

        }
       else  if(value!.isEmpty ||!RegExp(r'^[a-z A-Z]+$').hasMatch(value))
        return "Enter corrected value";
        else return null;
        }
        else return null;
      
        }),
      decoration: InputDecoration(   
      
      hoverColor: Colors.amber,
       errorStyle: TextStyle(color: Colors.red),
      fillColor: Colors.white,
        filled: true,
        hintTextDirection: TextDirection.rtl,
        hintText: hintText,
        labelText: hintText,
        
     border:OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    
        suffixStyle: const TextStyle(color: Colors.blueGrey,fontSize: 15),
        contentPadding: const EdgeInsets.all(8),
        suffixIcon:icon 
         ),
         
         keyboardType: textInputType,
         obscureText: isPass,
         
          
         
      );
    
  }
}
