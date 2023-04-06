# API ReadMe

## api.dart
- contains the fetchImage and fetchData functions which access the API directly

## api_info.dart
- the class structure for the json output from the fetchData function
    - fectchData outputs a value of type ApiInfo 
    

## api_value.dart
- this class stores the value of... for the current user session
    - bucket
    - project
    - dataset
    - volume
    - frame
- these values are set back to the default values when the user closes the app
