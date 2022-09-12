
// ignore_for_file: unnecessary_this

class UserFormValidation{
   String? email;
   String? password;
   String? passwordConfirmation;
   DateTime? birthDate;
  String? errorMessage;


  UserFormValidation({this.email, this.password, this.passwordConfirmation, this.birthDate,this.errorMessage});
  String? get emailUser{
    return email;
  }
  void set userEmail(String email){
    this.email=email;
  }
  void set userpassword(String password){
this.password=password;
  }

void set userconfirmationPassword(String confirmPassword){
  passwordConfirmation=confirmPassword;
}
String checkPassword(){
  String passwordError ='';
  if(password!.length <6 ){
   
   passwordError='Password must be more than 6 digits';
  }

  return passwordError;
}
String checkvalidationPassword(){
String errorPasswordConfirmation='';
if(this.password != this.passwordConfirmation){
  
  errorPasswordConfirmation='Passwords don\'t match';
}
return errorPasswordConfirmation;
}


  
}