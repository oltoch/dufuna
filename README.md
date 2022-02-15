# Lekki Properties

This app lets users view properties as well as add new properties to a collection.

Users can also update properties.

This app is a test project for a recruitment process with Dufuna.

The app starts up with a splash screen and then navigates to the screen that shows list of
properties. 

This screen shows a list view of all properties in the collection. The list can 
be filtered by number of bedrooms, sitting rooms, kitchens, bathrooms, toilets, property owner
as well as find a property by its address. A custom card is used to display the basic info
of a property on this page.

When a property is clicked, it goes to a page that shows the full details of the properties,
including the images of the property being displayed in a slider. The property can be updated 
and when user clicks on the update button, it goes to the update property page. Properties that 
can be updated include: number of bedrooms, sitting rooms, kitchens, bathrooms, toilets, description
and date the property is valid to.

User can add a new property when they click on add new on the list of property page. User can
upload one or more pictures of the property as well as fill in all details of the property in to
the input fields. (All fields are required to be filled to add a new property).


## Code Structure

### The code is structured into directories which include:

screens: which has all the UIs and logic for rendering to the device screen.

models: contains the data models of the property and image.

http: contains logic and settings for the http package for making http request as well
as getting response

components: contains all custom widgets used within the app

api: contains all the http requests made to add, update, or get property(ies)

controllers: contain logic for managing state of the app as well as getting data from the 
api into controllers

Other files include: constants which contains all constants value such as color and textStyle
and helpers which contains custom functions such as picking images from the device  


## External packages used in the app include:

flutter_screenutil: For screen size adaptation on devices

google_fonts: For getting and using fonts from google material fonts

get: For state management and dependency injection.

http: For making http requests

dio: For making http requests (Added because it provides a simpler method for posting form data)

animated_text_kit: For animating texts to give it a fine look

carousel_slider: For displaying pictures in a slider

image_picker: For picking images from the gallery of the device

## Contact: otchrisola@gmail.com