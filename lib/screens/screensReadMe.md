# Screens Read Me

## data_viewer_settings_screen.dart
- this is the setting screen for configuring the api
- stores the new values in the api_value.dart class
    - the values from api_value.dart are used to build the image in the home_page.dart

## home_page.dart
- the main page that diplays the image that which is called from the fetchImage function from api.dart

## image_picker_screen.dart
- not included because bug occured that would change app color and NOT successfully upload the image to the bucket
- has been commented out

## show_images_screen.dart
- builds a grid view of all the images in the connected s3 bucket
- currently only iOS can show newly added images with no errors
- android can only show images that are included in the assets folder