class AppValidator{

  String?_validateEmail(value){
    if(value!.isEmpty){
      return 'Please enter a email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegExp.hasMatch(value)){
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(value){
    if(value!.isEmpty){
      return 'Please enter a PhoneNumber';
    }
    if(value.length!=11){
      return 'Please enter a 11 digit phone number';
    }
    return null;
  }

  String? _validatePassword(value){
    if(value!.isEmpty){
      return 'Please enter a passsword';
    }
    return null;
  }

  String? _validateUsername(value){
    if(value!.isEmpty){
      return 'Please enter a username';
    }
    return null;
  }
}