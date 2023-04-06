# Providers Read Me

## auth.dart
- this was my manual implementation of the authentication for the app 
- however I found a better solution in the time being which has a prebuilt authentication feactures
- __This is the amplify_authenticator package__
- this file has been commented out because I was unable to keep the user logged in even after closing the app

## s3_handler.dart
- uploadFile 
    - allows you to add a image from your phone to the connected s3 bucket
    - however the auth situation does not allow for this functionality currently

- downloadFile
    - allows you to download an image from the connected s3 bucket
    - unfortuantly Android seems to have a problems obtaining the file path to download the image
    - This only work correctly with iOS
- listItems
    - this is used to display all the images in the connected s3 bucket in the app
        - reference the show_images_screen.dart file in the screens folder to see implementation
- deleteFile
    - will delete the file from the s3 bucket
    - not implemented in this app