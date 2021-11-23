Original App Design Project - README Template
===

# Cycl-o-Space

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Cycl-o-Space is an app that gives people who might need companion while cycling the chance to newtork with other cyclists, form and join groups and rides in their area. It's the ideal opportunity for anyone to optimize their cycling experiences, discover new chances to ride and make some friends along the way.

### App Evaluation
### Cycl-o-Space
- **Category:* Fitness / Photo & Video / Social Networking*
- **Mobile:* This app and its functionality would be primarily developed for mobile but could potentially have more features.*
- **Story:* Allows users to share their lives in pictures and enhance their content with filters.*
- **Market:* Any cyclist that takes pictures/videos could enjoy this app. Ability to follow and hashtag based on interests and categories allows users with unique interests to engage with relevant content.*
- **Habit:* Bikers can use this app and post throughout the day as many times as they want. Users can explore endless outdoor pictures/videos in any category imaginable whenever they want. Very easy to become a habit!*
- **Scope:* Cycl-o-Space started out as an app for casual cyclist/bike rider to explore and share their experiences amongst each other, just posting pictures/videos and viewing feeds.*

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [x] User can create a new account
* [x] User can log in
* [ ] User can view own profile
* [x] User can post a new photo to their feed
* [x] User can view a navigation map in home tab
* [ ] User can search for other users
* [ ] User can like a photo
* [ ] User can follow/unfollow another user
* [x] User can view a feed of photos
* [ ] User can modify the app settings
* [x] User can log out
* [ ] User can comment on a photo.

**Optional Nice-to-have Stories**

* User can view other user's profiles see their photo feed.
* User can see their profile page with their photos.
* User can see a list of their followers.
* User can see a list of their following.
* User can use unit conversion for navigation.
* User can switch appearance light/dark mode.
* User can see trending photos.
* User can search for photos by a hashtag.
* User can see notifications when their photo is liked or they are followed.

### 2. Screen Archetypes

* Register/Login Screen
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their lounge.
* My Lounge Screen
   * Upon signing in, user can view a navigation map to start a freestyle ride and/or look up directions.
   * User can also modify different app settings in the top right corner including general, notification and appearance.
* Feed Screen
   * User can view other user's posts
   * User can search for other users
   * User can like a photo
   * User can follow/unfollow another user
   * User can view a feed of photos
   * User can comment on a photo.
* Record Screen 
   * Allows user to upload a photo/video and fill in information that is interesting to them including a caption, location etc...
* Routes
   * User can search for popular routes and favorite bike hiking destinations with best reviews.
   * User can track their mileage
* Network 
   * User can access a forum with different bicycle topics including tutorials, ride tips, events and/or any relevant topic concerning cycling.
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* My Lounge
* Feed
* Record
* Routes
* Network

Optional:
* Discover/Forum

**Flow Navigation** (Screen to Screen)

* Login Screen
  * => My Lounge screen
* Registration Screen
  * => Login Screen
* Home/My Lounge Screen
  * => Navigation map screen for freestyle ride with 
  * => Settings to modify general, notification and appearance settings.
* Feed Screen
  * => Home (after you finish posting the photo)
  * => In the actual wireframe, you will need multiple screens to represent the creation process to add filters, etc.
* Record 
  * => Feed (after user finishes posting the photo/video with or without a caption)
* Routes/Bike Paths
   * => Discover/Explore scroll screen at the top 
   * => Navigation screen with directions to selected path
   * 
* Network 
   * => Forum listing with different topics.
   * => message chat for user to input a topic and/or question in the forum.
## Wireframes
[Add picture of your hand sketched wireframes in this section]

<img src="https://i.imgur.com/VA4h049.png" width=600>

### [BONUS] Digital Wireframes & Mockups

<img src="https://media.giphy.com/media/JL2ihAsT0hmiVLpLQu/giphy.gif" width=600>

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src="https://media.giphy.com/media/0V84uQzssBoO0aDGqe/giphy.gif" width=600>

Latest 

<img src="http://g.recordit.co/Pqbfyy0YQ4.gif" width=600>

<img src="http://g.recordit.co/maUNpTag6v.gif" width=600>

### [BONUS] Interactive Prototype

## Schema 

### Models: 

Post 

| Property | Type     | Description|
| -------- | -------- | -------- |
| objectId |String |unique id for the user post (default field)|
|username|String|The username for the user (required).|
|password|String/Number/Character|The password for the user (required on signup).|
|email| String/Number/Character|The email address for the user (optional).|
|currentUser| String/Number|image current user session
|become| String | Set current user as user
author	|Pointer to User|	image author
image	|File	|image that user posts
caption	|String	|image caption by author
commentsCount|Number|number of comments that has been posted to an image
likesCount|	Number	|number of likes for the post
createdAt|	DateTime|date when post is created (default field)
updatedAt|	DateTime|date when post is last updated 

### Networking

* Register Screen
    * (Create/POST) Create the user's username, password 
    * (Read/GET) Retrieve user's email address
```
func myMethod() {
  var user = PFUser()
  user.username = "myUsername"
  user.password = "myPassword"
  user.email = "email@example.com"
  // other fields can be set just like with PFObject
  user["phone"] = "415-392-0202"

  user.signUpInBackground {
    (succeeded: Bool, error: Error?) -> Void in
    if let error = error {
      let errorString = error.localizedDescription
      // Show the errorString somewhere and let the user try again.
    } else {
      // Hooray! Let them use the app now.
    }
    
  }
  
}
```

* Login Screen
    -   (Read/GET) Query logged in user object
    
```
PFUser.logInWithUsername(inBackground:"myname", password:"mypass") {
  (user: PFUser?, error: Error?) -> Void in
  if user != nil {
    // Do stuff after successful login.
  } else {
    // The login failed. Check error to see why.
  }
}
```

* Lounge/Profile Screen

  -   (Read/GET) Query all posts where user is author
```
let query = PFQuery(className:"Post")
query.whereKey("author", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(posts.count) posts.")
  // TODO: Do something with posts...
   }
}
``` 
*
     * (Read/GET) Query logged in user object
       
```
var currentUser = PFUser.current()
if currentUser != nil {
  // Do stuff with the user
} else {
  // Show the signup or login screen
}
``` 
*
    * (Update/PUT) Update user profile image
        

     
* Feed Screen

    * (Create/POST) Create a new post
```
var user = PFUser.currentUser()

// Make a new post
var post = PFObject(className:"Post")
post["title"] = "My New Post"
post["body"] = "This is some great content."
post["user"] = user
post.save() 

```
*
    *  (Read/GET) Fetching posts for a user's feed.
    * (Create/POST) Create a new like on a post
    * (Delete) Delete existing like
    * (Create/POST) Create a new comment on a post
    * (Delete) Delete existing comment
- [OPTIONAL: List endpoints if using existing API such as Yelp]
