 // ignore_for_file: prefer_const_constructors

 import 'dart:typed_data';
 
import 'package:flutter/material.dart';
 
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartmedia/ressources/auth_method.dart';
import 'package:smartmedia/screens/login_screen.dart';
 import 'package:smartmedia/utils/utils.dart';
 
import 'package:smartmedia/widgets/text_field_input.dart';

import '../responsive/mobilescreen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/webscreen_layout.dart';
enum UserTypeEnum{reader,journalist}
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final formKey= GlobalKey<FormState>();
class _SignUpScreenState extends State<SignUpScreen> {

UserTypeEnum? _userTypeEnum;
  int currentStep=0;
  final TextEditingController _emailInputController=TextEditingController();
    final TextEditingController _passwordInputController=TextEditingController();
        final TextEditingController _confirmpasswordInputController=TextEditingController();
        final TextEditingController _usernameInputController =TextEditingController();
          final TextEditingController _firstnameInputController =TextEditingController();
            final TextEditingController _lastnameInputController =TextEditingController();
                  final TextEditingController _phonenumberInputController =TextEditingController();
                  final  TextEditingController _typeOfuser= TextEditingController();
                  Uint8List? _image ;

                   
    Future     register() async{
      
             AuthMethods().signUpUser( typeOfuser: _typeOfuser.text,  email: _emailInputController.text, password: _passwordInputController.text, username: _usernameInputController.text, firstname: _firstnameInputController.text, lastname: _lastnameInputController.text, phoneNumber: _phonenumberInputController.text,file: _image!);

          }          
                  
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailInputController.dispose();
    _passwordInputController.dispose();
    _usernameInputController.dispose();
    _firstnameInputController.dispose();
    _lastnameInputController.dispose();
    _phonenumberInputController.dispose();
}
void selectImage() async{
  Uint8List im = await pickImage(ImageSource.gallery);
  setState(() {
    _image=im;
    
  });
}
                  //------------Go To Login Screen

navigateToLoginScreen(){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const  LoginScreen()));
}

                  //------------Get Steps
    List<Step> getSteps()=>[
       Step(
        //First Step
        state: currentStep>0?StepState.complete:StepState.indexed,
        isActive:currentStep>=0,
        title: Text('Account'),
      content: Center(
        
        child: Column(
          children: [Stack(      //------------Image Picker

                          children: [
                              _image!=null?        CircleAvatar(
                              backgroundImage: MemoryImage(_image!),
                              radius: 64,
                             
                              
                            ):
                            const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 64,
                             
                              
                            ),
                            Positioned(
                              bottom: -10,
                              left:80 ,
                              
      child: 
      IconButton(onPressed:selectImage,icon: const Icon(Icons.add_a_photo,color:Colors.deepPurpleAccent,),))
                          ],
                         ),

                        const SizedBox(height: 15),
                        //-------------------------------radio Button Type of  Users 
                        Center(
                          child: TextFieldInput.radio(UserTypeEnum.reader,_userTypeEnum,Center(child: Text('ساستعمل التطبيق  : قارئ')) ,(val){
                            setState(() {
                              _userTypeEnum= val;
                              _typeOfuser.text=val.toString();
                              print('----------You are :  ${_userTypeEnum.toString()}');
                               print('----------You are :  ${_typeOfuser.toString()}');
                            });
                          }),
                          
                        ),
                     
   TextFieldInput.radio(UserTypeEnum.journalist,_userTypeEnum,Center(child: Text('ساستعمل التطبيق : صحفي')),(val){
                          setState(() {
                            _userTypeEnum=val;
                               print('----------You are :  ${_userTypeEnum.toString()}');
                          });
                        }),
                              //------------Email

                         const SizedBox(height: 15),
                               TextFieldInput(textEditingController:_emailInputController , hintText:' البريد الألكتروني', 
                                 typeOfInput: 'email',
                               
                               textInputType:TextInputType.emailAddress,icon:const Icon(Icons.email),isPass: false,
                               
                               ),
                                           
                                                //------------UserName

                                   const SizedBox(height: 15),
                                 TextFieldInput(textEditingController:_usernameInputController , hintText:'اسم االمستخدم', 
                                   typeOfInput: 'userbale',textInputType:TextInputType.emailAddress,icon:const Icon(Icons.person_add_alt_1),isPass: false,),
                    SizedBox(height: 15),
                  //------------Password
                                        TextFieldInput(textEditingController:_passwordInputController , hintText:'القن السري' ,
                                          typeOfInput: 'password',textInputType:TextInputType.emailAddress,icon:const Icon(Icons.password), isPass: true, ),
//--------------Confirm Password
SizedBox(height: 15),
                                             TextFieldInput(textEditingController:_confirmpasswordInputController , hintText:'القن السري' ,
                                          typeOfInput: 'confirmPassword',textInputType:TextInputType.emailAddress,icon:const Icon(Icons.password), isPass: true,
                                          validationPassword: _passwordInputController,
                                           ),
                         ]
        ),
                       
      ), 
      
      
       ),
                         //------------SecondStep

        Step(title: Text('Personal Informations'),
               state: currentStep>1?StepState.complete:StepState.indexed,
        isActive: currentStep>=1,
      content: Container(
            
        child: Column(
                            //------------FirstName
          children: [
                  TextFieldInput(textEditingController:_firstnameInputController 
                  , hintText:'الاسم الشخصي',textInputType:TextInputType.name,icon:Icon(Icons.person),isPass: false,
                  typeOfInput: 'text',
                  ),
      SizedBox(height: 15),
                  //------------LastName

       TextFieldInput(textEditingController:_lastnameInputController , hintText:'الاسم العائلي', textInputType:TextInputType.name,icon:Icon(Icons.family_restroom),isPass: false,  typeOfInput: 'text',),
      SizedBox(height: 15),

                  //------------PhoneNumber

      TextFieldInput(textEditingController:_phonenumberInputController , hintText:'رقم الهاتف', textInputType:TextInputType.name,icon:Icon(Icons.phone),isPass: false,  typeOfInput: 'phoneNumber',),
      SizedBox(height: 15),
],
        ),
      )),
       Step(title: const Text('Complete'),
       isActive: currentStep>=2,
      content: const SizedBox(
        width: 150,
        height: 150,
        child: Center(
          child:  Text('المرجو الضغط على انشاء حساب ، مرحبا بكم في سمارت ميديا',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        ))),

    ];
  @override
  Widget build(BuildContext context) {
    

       checkImageError(){
     
    if(_image == null)return 0; else return 1;
  }

    return Scaffold( 
      appBar: AppBar(title:SvgPicture.asset('assets/1.svg',height: 150,color: Colors.white,),
      centerTitle: true),
        body:Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Stepper(
          controlsBuilder: ((context, details) {
            final isLatStep=currentStep==getSteps().length-1;
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
              children: [
              if(currentStep!=0)
           Expanded(
            flex: 2,
              child: ElevatedButton(
                
               style: ElevatedButton.styleFrom(padding: EdgeInsets.all(4),maximumSize: Size.infinite),
              onPressed:details.onStepCancel, child: const Text('العوده الى الوراء',style: TextStyle(fontSize: 18),)
              
              ),
            ),
            SizedBox(width:2),
             if(currentStep==0)
           Expanded(
            flex: 2,
             child: TextButton.icon(
                icon: const Icon(Icons.home),
              onPressed:navigateToLoginScreen, label: Text('العوده',style:  TextStyle(fontSize: 18),),
              
              ),
           ),
            SizedBox(width: 10),
        
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(4)),
              
              onPressed:
              details.onStepContinue
              
              , child: Text(isLatStep?'انشاء حساب':'التالي',style: const TextStyle(fontSize: 18),)),
          ),
        
              ],
            
            
            );
        
          } ),
          // type: StepperType.horizontal,
            steps:getSteps(),
            currentStep: currentStep,
            onStepContinue: (){
              final isLastStep= currentStep==getSteps().length-1;
              final isFirstStep = currentStep==0;
             
                 if(isFirstStep && checkImageError()==0){
                print('---------------------------------------first step');
                setState(() {
                   showSnackBar('You must choose a picture',context);
                      currentStep=currentStep-1;
                });
             
              }
          
              if(isLastStep){
                  
                // Validation of The Form
                print('Completed');
                //send data to the Server 
           
            register();
        
              
        var res ='wait';
        if(register().toString()!="success".toString()){
          showSnackBar(res, context);
        }
         if (register().toString()=='success'.toString())
        {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)
            =>const ResponsiveLayout(WebScreenLayout: WebScreen(), mobileScreenLayout: MobileScreenLayout()),
            )
          );
        
             }
           }
          
              else{
              setState(()=>currentStep+=1);}
            },
            onStepCancel: 
              currentStep==0?null:()=> setState(()=>currentStep-=1)
            ),
        ),
    );
}
}