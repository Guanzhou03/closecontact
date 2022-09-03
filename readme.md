# Introduction

Hello! We are Alvin Jiang and Chen Guanzhou, developers of Close Contact, an android friend-finding app, and this is our readme, which also serves as a documentation to why and how we came to undertake this project. Throughout this document, you will understand why we believe our project is meaningful and the motivation behind it.

We will also elaborate on the features that we have decided to implement, providing a program flow to understand how our app is structured. After which, we detailed the various Software Engineering Principles we have adopted, followed by the project log to detail the time each of us have spent over the course of this project.

# Motivation

As students facing the challenges of interacting with others amidst the COVID-19 situation, we find it difficult to get to know others, and increase our social circle.

Many students find themselves craving social interaction with others, with high levels of loneliness reported in college students[^1]. An idea of a social networking app, made for students, can increase one’s exposure to others such that they can make more friends.

[^1]: Labrague, L. J., Santos, J. A., & Falguera, C. (2020). Social and emotional loneliness among college students during the COVID-19 pandemic: The predictive role of coping behaviours, social support, and personal resilience. https://doi.org/10.21203/rs.3.rs-93878/v1

# Aim

We hope to create a social app that University students can make use of to find other students of the same course/hobbies/activities that they are keen on. Using a matchmaking system, we can allow students to swipe through the profiles of others, and chat with those they are interested in.

The app will serve to improve and enhance social interactions by providing a platform that allows for social interaction between students. This promotes more social activity within NUS students which has been painfully lacking, especially in recent years.

# User Stories

1.  As a student, I want to be able to customize my profile to include my course, hobbies, activities that I am looking to do with others.
2.  As a student, I want to be able to message other users on the app.
3.  As a student, I want to be able to look at the profiles of other users of the app, and swipe right or left depending on whether I am interested in interacting with them.
4.  As a student, I want to be able to see when others request to chat with me, and accept or decline accordingly.
5.  As a student, I want to be able to report others who abuse the platform, and send messages to the administrator.
6.  As an administrator, I want to be able to receive feedback from users regarding the platform and respond to messages sent by users.

# Tech Stack

1.  Flutter/Dart (Frontend)
2.  Firebase (Backend)
3.  Android Studio (IDE)

# Code Base

<https://github.com/Guanzhou03/closecontact>

# Deployment

To try the app out yourself, download the apk here:

[**https://drive.google.com/file/d/1UpY7zVAml_6G90qV2IdoBKcsFMvDqI-s/view?usp=sharing**](https://drive.google.com/file/d/1UpY7zVAml_6G90qV2IdoBKcsFMvDqI-s/view?usp=sharing)

# Features and Timeline

**As we update on our readme over the course of the project, we will have decided to make use of this section to review our goals over the Milestones.**

## Features to be completed by Milestone 2:

1.  Creating and Customizing Profile
    1.  Users can select their course of study, interested activities, hobbies, from a given list, which will be displayed on their profile. ✅
    2.  Users can upload and display a profile picture. ✅
    3.  Users can write a short biography about themselves, which will be displayed on their profile. ✅
2.  Messaging System
    1.  Allow users to message other users. ✅
    2.  Allow users to send messages to the administrator. ✅
        1.  Completed as of Milestone 3
1.  Request Handling System
    1.  Allow users to see their sent requests ❎
        1.  We have since decided to remove this feature, as we do not think the benefits it brings is significant enough to justify the work necessary, and it also does not negatively affect any of our user stories.
    2.  Allow users to see their incoming requests, and accept or decline accordingly. ✅
1.  Matchmaking System
2.  Swiping system allows users to connect with others, swiping right automatically sends the other party a chat request, which can be accepted by the other party. Swiping left will allow the user to skip the current profile. ✅

## Features to be completed by Milestone 3:

1.  Allows users to filter out profiles with certain characteristics (eg Course/Gender). ✅
2.  Implement a feedback system for users to report bugs, other users. ✅
3.  Mechanisms to collect datasets for analysis. ❎
    1.  For this portion, we were unable to explore mechanisms to collect datasets, although firebase console provides an easy way for us to look at the data within the database.
4.  **Improve on current core features to increase options for users (new).**
    1.  **Swipe System to allow users to swipe once on every other user only.** ✅
    2.  **Messaging System to allow sending of images, videos etc.** ✅
    3.  **Profile Page to allow for greater customization.**✅
5.  **Improve on current User interface to increase intuitiveness for users. (new)** ✅
6.  **Implement an algorithm that recommends profiles based on “similarity” (new)** ✅
7.  **Improve current testing methods. (new)** ✅
    1.  While we made some small improvements, we did not deviate much from our testing techniques as implemented in Milestone 2. This will be further elaborated upon under the Quality Assurance Section.
8.  User verification system to prevent misuse. ✅
    1.  Already implemented in Milestone 2

**Possible extensions on our app in the future:**

Looking beyond Milestone 3, we could potentially explore these following features, although it is not a priority at this stage of development.

-   Data on profiles which are swiped left/right by the user can also be stored to provide even better recommendations to enhance user experience using data analysis.
-   Extend beyond NUS into university students in Singapore/students in general
-   We would like to further explore administrator versions of the application, which we have ideated upon but did not have the time to implement.

**How are we different from other platforms?**

1.  **Social media platforms (Instagram/Facebook/Twitter)**

    Our platform focuses on allowing NUS students to make friends and connections with other NUS students. Social media platforms do not narrow down the demographic to NUS students specifically, and it is much easier to make friends and connections with our product than with these social media platforms.

2.  **Matchmaking/Dating platforms(Tinder/Bumble)**

    Our platform provides a safe environment for students to interact and make connections with other students. The students must be verified by their NUS email and are not anonymous and users can report any offences/offenders through the app and they will be directed to the relevant authorities. Other matchmaking apps like Tinder may not be as safe, and are not limited to just students so it may be harder for our users to make connections with people that are similar to them. (NUS students looking for NUS students to befriend/date)

3.  **Social applications targeted at NUS Students (NUS Chat Bot)**

    Although these applications target NUS/University students in general, they do not contain details about the user such as their hobbies and interests. There are also no avenues for them to share photos of themselves, compared to our app. Matchmaking is also done on a random basis and not based on direct chat requests. Our app shows interests and details of a user so interested users can reach out and make friends with them.

# Project Scope

This section of the readme covers the login and authentication process, key functionality of the application and extensions that can enhance user experience.

**Authentication** - User registration and login with verification using NUS email address.

**Key functionality** - Core features including home page, profile page, and chats page

**Extensions** - Users can filter profiles, use a feedback system/report system, allow users to upload images/other media, and make use of a user recommendation system.

## Milestone 1: User registration and login

### Frontend routing with login and register page

1.1. Set up routing from the login page to the home page.

1.3. Register page

1.4 Login Page

![](media/947e88f045a8676097bf7ec45e02d271.png)![](media/60a4d4a3689a9f2072b1be2f889cccc5.png)

Login page Register page

### Backend endpoints API and database

2.1 Setup backend API endpoints and a database for user registration and login using Firebase Authentication.

2.2 Users must register and login in order to use the app as intended.

## Milestone 2: Core features including Home page, Profile page, Chat requests and messaging features, and improvements from MS1

### Email verification with Firebase Authentication

Users must verify their email using their NUS email address when they register.

![](media/c758f923360d69e18fdaa4c878e6e405.png)

![](media/47256b9b0b2ad56e46dea02107dcd940.png)

*Verification email*

*Alert to display email verification sent*

### Forget password feature

Users can reset their password and the link to reset password will be sent to their registered NUS email address.

![](media/8b26bd347abc50827cab1a92c641896c.png)![](media/97d7319e0663a314e33a2be63d1a388a.png)

Reset password email

Reset password page

### Home page

After logging in, users will be brought to the home page where they can see other profiles, and users will be able to swipe left/right for each profile they see, until there are no more profiles left. Swiping right sends a chat request to the other user while swiping left skips the user.![](media/099fd02b47daba6f5256fa65da5776ec.png)

Sample home page profile

### 

### 

### 

### Profile page

Users can navigate to their profile page to update their profile information. Users must provide their information so that they can participate in swiping and other app activities. Users with an incomplete profile (missing information in My Profile page) cannot swipe right on other users.

![](media/63fe53f70d6c85b16bfe8e3265b0d1ca.png)

Sample profile page

### 

### Chats Page

Users can also navigate in the navigation bar at the bottom to the chats page, where their current chats are. A chat room is created and shown in this page once the user accepts a chat request from another user, or another user accepts the current user’s chat request. They can tap into their current chat to view chat messages and continue chatting.

![](media/73b488390b12c9e7975e84978382e700.png)

Sample chats page of current chats

### Chat Requests Page

From the Chats Page, users can tap into the chat requests page on the top right of the Chats Page screen. Here, the users can see all incoming chat requests from other users. Users can tap into the profile avatar to see information about the user sending the chat request. In the chat requests page, users can swipe right to accept the chat request or swipe left to dismiss the request. ![](media/618e0d48aa4c4358a0b52af50a49e918.png)

![](media/13627ff0a034ef2e35d2fb10f2ac2423.png)

Sample chat request screen

User’s information after avatar tap

### Individual chat room

Here is where users chat with one another in private. The messages are displayed based on the time of the message, with the latest message shown first.

![](media/859a12ede2dac4da78cb628b75de63e6.png)

Sample chat room

## 

## Milestone 3: Extensions, optimizations and improvements to existing features to improve user experience and usability.

### Chat Requests Improvements

Users will now be able to make the decision to accept or decline incoming chat requests

after tapping into the incoming user’s profile info, using intuitive accept or decline buttons. This is an improvement as feedback has been given regarding the unintuitive swiping in the chat request page previously as users did not know they had to swipe.

![](media/87bfeec6f7a2a5c4e8fd9268c826964e.png)![](media/f5367e71e2c1954b20f11b40aff49876.png)

**→**![](media/f5367e71e2c1954b20f11b40aff49876.png)

**Tap on profile**

### Profile page improvements

There are now more fields for user to provide their information so other users can get to know them better. Gender, area/location, and more interests have been added. Should users not want to share these information, we have also added an option for them to choose not to reveal their information. There are also improvements in text alignment.

![](media/6b7610e9f128bf037381b3a0822ee442.png)![](media/54a3dcad3082cdfd2cb7b53ce2509434.png)

Choose Interests Added gender and area fields

### Set user preferences and filter out profiles

Users can now set their preferences in the filter profile page, and only filtered profiles will be shown in the home page. Users can select any number of preferences, including everything which will show all available profiles. If no profile matches the preferences, the home page will show no profiles.

![](media/79d04c4fd4d75bf0e1da8a15a3f0a5f1.png)![](media/4ff27ef399a61122e0d832b4b9b79a9a.png)

**→**

Profile page Set your preferences

### Recommendation algorithm implementation

We have implemented a recommendation algorithm, where profiles that users may be more likely to be interested in are shown first in the home page. We use a simple interests-matching algorithm to calculate the similarity score between the interests of any two users. We sort the list of profiles on the stack using this similarity score, to allow profiles with similar interests to the user be shown first, enhancing the user experience.

For example, if user X matches all my interests listed in my profile, then user X will have the highest similarity score and will appear first for me to swipe in the home page. This will be particularly useful especially then the number of profiles increases.

Example: The profile with 3 out of 4 similar interests (highest among all profiles) appears first.

![](media/a4635054b1fcd215915c4dee836f1a83.png)![](media/c88eb9a3dab99382de9430534331e776.png)

### Image uploading feature

On top of the text messaging feature we implemented previously, we have implemented an image uploading feature. Users can choose an image from their device and send it.**![](media/d6f3be1317c82b008015bd2b11e42d71.png)**

Image sent using the upload button on the left

### Report user feature

We have implemented a report user feature where users can report other users that they are chatting with. For example, if someone is suffering from harassment, they can report the user to the admin and explain the issue to the admin. The admin will be notified and are able to report these perpetrators to the relevant authorities if necessary,

![](media/33218e6a10652afb9993a4099cd14dc4.png)![](media/dcf28f707abd43fa5926b6008a436fbb.png)

**→**

After tapping top-right menu After report, chat with admin

### Block/unblock user feature

Users can block/unblock other users. Blocked users will not be able to send messages

![](media/780bdfa3305bfaa413cc053838c556f8.png)![](media/c42c885e0da74d35096e09aa009b7285.png)

**→**

After tapping top-right menu Alert appears to inform user

![](media/a5e2be8abf783749d1034be919da8ffc.png)![](media/58b45f9370b59243124a2316713b4b79.png)

If blocked user tries to send a message If blocked user tries to unblock

### Feedback/report bugs feature

Users can report any bugs/problems with the app or any feedback in general using the report a bug button in the home page.

![](media/112a68d04fc28b64025df307f5050760.png)![](media/07761600def9161642f7787ede480c52.png)

**→**

Report/feedback on top right Submit feedback form

### Delete chat feature

Users are able to delete chats by touching and holding a chat until an alert pops up that allows them to delete the chat. This will help to smoothen their user experience. For example, if a user has been reported to the admin and the issue has been solved, they can delete and close the chat with the admin.![](media/d629da3ba293dd322901040c0fd45146.png)

![](media/3aae83c2be5406843203b47961002c4e.png)

**→**

After tapping delete on top-right After deleting

# Challenges Faced

## Future-proofing of Code

Throughout our journey during orbital, we implemented many different features, that all build upon the previous features. Because of this, we had to make sure that the code we write is future proof, such that our **future features do not break or cause our previous features to break.** In addition, it proves difficult to change any data structures that we have chosen previously to store our information. An example of this would be our Multi-Select Form Field, to store lists of interests.

Changing the implementation for this particular widget was challenging, as **many other widgets depend on this widget and it required a List\<String\> to work**. This made it difficult to change the implementation of an interest selector during Milestone 3, even though we received feedback that users would like to key in their own interests.

![](media/fd5ce97447e221567f60c086227d67b1.png)

Multi-select Form Field

## Asynchronous Programming

We realised the importance of asynchronous programming. Throughout the software development, we ran into **many issues that would have been easily solved with a good understanding of asynchronous programming**. We had to learn the syntax in Dart, and learning how to make use of asynchronous calls to assist us. This was difficult as many of our widgets required some sort of asynchronous programming. In this same respect, **Firebase methods are all asynchronous calls as well**.

With a mastery of this, we were able to create widgets that are well integrated with the firebase backend. An **example of this is the swipe card, which builds a list using a series of asynchronous snapshots**.

## Real time updates

We managed to implement most of the features without too much difficulty, however **implementing it with real time updates was much more difficult**. For example, when a user is in a chat and the other user decides to block the current user, the blocked user must immediately be unable to send messages without the need to refresh or re-render the chats page. If not, the purpose of the block feature would be much less meaningful if the user did not want to receive any more messages immediately. We **used a listener for this problem to listen to state changes and update the block status accordingly**.

Other less important but still good to have examples include **real time updates for when a chat request is sent while the user is on the chat requests page, or when a user accepts your chat request when you are on the chats home page**. Without the user deliberately refreshing or re-rendering the page, it was a challenge to implement the features that work in real time.

## Implementation of specific features

The implementation of specific features, particularly the swipe card feature and the chatting feature, which are core features of our app, were extremely difficult for us due to the **complexity of the features and the lack of any prior development experience** with Dart in our team.

The chatting feature was incredibly complex because there are many parts to it and we must be very clear about each part. We had to **implement a message model, database methods for reading and writing data, and plan on the organisation and storage of the messages and chat rooms in Firestore, while handling messages sent with real-time updates for both users, as well as the correct ordering and frontend display of the chat messages.**

The swipe feature was very challenging because it was a **key component that was required very early** and had to be implemented before the chatting feature. It was complex as it **consisted of gesture detection of swiping and it is the only place in our app where animations are used when users swipe left or right**. The action also sends a chat request to the other user so backend support was required to organise the information. Later on, we also had to make it such that swiped users do not appear again and users are also ordered based on the similarity of their interests, as well as filtered profiles to improve the user experience.

# 

# Bugs Squashed

This section covers the bugs we have encountered during the implementation of the features above, and how we managed to squash them.

## Chatting feature timestamp

In the database, the messages in a chat room are ordered chronologically, so that we are able to display the latest message first and the chat page has the correct order of messages shown as expected in a chatting feature. However, the way we retrieve the timestamp is using the user’s device time, and we **noticed not all users have the same accurate time on their devices**. This also affects users from other timezones, and causes messages to be ordered incorrectly (for example new messages shown on top instead of at the bottom of the chat).

In order to squash this bug, we **made use of the Network Time Protocol (NTP) package, which is able to get the precise time from NTP. We use the NTP to get the offset from the current device time to the real precise time**, and simply add the offset to the device time to get the real time. In this way, all messages sent will be standardised to precise time from NTP. The following shows the code implementation in Dart:

![](media/00f87bab3b45af7913373bf96869b261.png)

## Block/unblock users

The way we implemented the block user feature is to find the chat room that the user initiated the block in, and block out the chat room so that no messages can be sent by either user once a block has been initiated. However, **this resulted in the blocked user being able to unblock the chat and send messages, which is not intended**.

To solve this, we created an initiator field in the database for each chat room on top of the isBlocked field, and **if there is an initiator that is not the current user, the current user will not be able to unblock the chat**. Once unblocked, the initiator field becomes empty and either user can block again.

After we solved this bug, we noticed that the blocking does not work in **real time chat when the blocked user stays on the chat page since there is no re-rendering of the chats page**. Therefore we do not retrieve the updated blocked status from the database. The blocked user is still able to send messages if he stays on the chats page without refreshing. To solve this issue, we added a listener to assign the block state correctly in real time so that blocking will immediately take effect even when the blocked user stays on the page. The following shows the code implementation in Dart:

![](media/cce0fc09c5358e0c943927ea95edc4c3.png)

The listener that was added in order to enact real time changes

## Swiping and chat requests

There is a bug where there can be **multiple chat requests from the same user**, because the card stack does not keep track of the profiles that the current user has already swiped on. To fix this bug, we created a list of profiles in the database that each user has seen and swiped on, so that there will not be repeated swiping on the same profiles.

![](media/17c6096dc12d0305d76d7f10d3da6cef.png)

The list of seen users

## Added interests causing overflow

In the home page, we display each user’s interests on their profile card. With the addition of more interests to accommodate more user interests, there is **a possibility of overflow if all interests are selected** which causes the profile card to allocate a huge amount of space to place all the interests. We simply decided to limit the number of interests shown in the home page to improve the user interface. We only show the first 4 interests on the home page, but their full interests can still be seen in their profile info by the user they have swiped right on.

![](media/0181a51e35a034c372441cd8c1f07845.png)![](media/29639c3e261fe968f38d1c7e87b6ff3a.png)

Overflow due to too many interests

## Automated Testing

When writing our test cases for automated testing, we encountered difficulty in getting tests cases to run correctly, and it would almost always return in failure, with the screen turning black before it loads the next screen correctly, even though testing it manually would demonstrate that our app does, indeed, work as intended. This was puzzling to us and it was difficult to tell whether it was an error in the test cases that were written or it was a bug in our program. **Our initial diagnosis was that the package we used was unable to track navigations made by the user, however, this was proven false once we did more research and looked at more online guides**.

After some time of trying out methods in the package, we realised that by implementing a manual gap of a few seconds, the test almost always passes and the dialog we anticipated will load correctly. This bug was extremely elusive as there were not much signs we had to accurately diagnose the origin of the bug, and **due to us always carrying out manual testing, we did not account for the time required for backend processes to take place before seeing the dialog.** However, when the machine input the fields automatically, there was a noticeable pause before the dialog is shown, and without the few seconds gap, the WidgetTester had already determined that it had failed.

**![](media/36d856fb4f58604ef06b2c3eb79a08f1.png)**

The necessary line of code for the test case to pass.

The above are just 5 of the bugs that we were able to catch and fix by Milestone 3. Through this, we also realised the **importance of writing good code**, and communicating in the event where we needed to debug each other’s code. Furthermore, we learnt the **importance of version control**, to ensure that our main branch is always stable.

# 

# Program Flow

**Activity Diagram**

**![](media/adda6b373c3fe9d58b96f3fe0ca60972.png)**

The above diagram seeks to provide a brief overview of the interactions between the components of our app.

Upon opening the app, the user is able to login/register with the assistance of Firebase Auth. After successfully logging in, the user will be able to see a **Home Page, with a swiping system**, and also includes **navigation to other screens including a Profile Page and Chat Screen**.

The **Home Page** has a Swipe System that **allows the user to swipe left or right** on the other users registered on the application. After each swipe, the swipe card is then removed from the stack. This is the **key feature that allows chat requests to be sent to other users**.

The **Profile Page** has fields that the user can edit, including a p**rofile photo, a biography box, lists for interests, year as well as faculty** to select from. This information can then be saved and updated accordingly.

The **Chat Page** has a list of all the chats that the current user is in, either due to an outgoing request being accepted, or accepting an incoming request. **Clicking a particular chat will bring them to a messaging screen**, where users are able to send messages to each other. The chat page **also supports navigation to the Chat Requests Screen**, where all incoming requests are displayed. Accepting this request will add the respective user as a Close Contact and will show up in the Chat Page.

**Flutter Frontend Widget Tree Diagram**

**![](media/87b80512f6ee566c3189a1e2159519e6.png)**

The above diagram is a Flutter Frontend Widget Tree, which shows in detail all the Flutter widgets that we have made use of during the development of our application. The frontend components shown here are a **mixture of Flutter widgets and screens that we have created by using existing packages or lower level built-in widgets**.

In particular, note that the central component that the application is built upon is the “Persistent bottom navigation bar”, which acts as a central piece that brings all other screens and widgets together.

For simplicity and clarity, we have chosen to omit low level widgets such as Text, Buttons, Scaffold etc, and instead seek to convey the general structure of our frontend layout.

**Cloud Firestore Backend Tree Diagram**

**![](media/4ad969a5ba9a6b081ea48170e1d95daf.png)**As for our backend, we have opted for a **document store, noSQL database** known as Cloud Firestore. This database makes use of collections, which can store documents, which can then contain information as fields, or even sub-collections.

We have exported our collections as JSON due to their similar data structures, and with the help of a JSON tree visualizer, we have generated a tree that contains all the documents under the “users” collection. The above is an example of one of the user documents within Cloud Firestore.

The root node, **“data”, represents the root collection “users”**, and a line connects between it and a **user document, which contains the various fields**. Below it, **sub-collections are represented with “_collections_”** and it contains a document “requests”, with a field “incoming”.

Through the above diagrams and explanations, we hope that readers are able to gain some insight on how we coded both the frontend and backend components, and how they work together to function.

# Quality Assurance

Before implementing new features, we carried out regular testing to ensure that existing features continue to work well, and that new features added integrate well with existing features. This is mostly done in the form of **system testing**, **automated user interface testing** as well as **user testing**.

## System testing: Smoke Tests, followed by Regression Tests

A set of smoke test cases have been selected from a greater list of regression test cases. The objective of these smoke tests are to ensure that major features are not broken according to the user stories it is intended to achieve.

After smoke tests have been passed, we will carry out the full set of regression tests, to ensure that the entire system works in its entirety after implementing the new features.

**Smoke Tests**

| Test ID | Key Feature                      | Test Objective                                                                           | Steps                                                                                                                                                                                                                                                                              | Expected Outcome                                                                                      | Test result | Date tested |
|---------|----------------------------------|------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|-------------|-------------|
| 1       | Register and Login               | Test that a user can successfully register                                               | 1. In the register page, key in a name, NUS email and a password. 2. Verify that an alert that reads “Email verification sent!” appears.                                                                                                                                           | User can successfully register, see an alert and receive a verification email.                        | PASS        | 24/07/2022  |
| 4       |                                  | Test that a registered user can successfully login after email verification is complete. | 1. In the login page, key in our personal NUS email as email and our registered email as password. 2. Verify that we can see the Home Page (Swipe card)                                                                                                                            | After completing email verification, the user will be able to login to the application.               | PASS        | 24/07/2022  |
| 6       | Creating and Customizing Profile | Test that a user can navigate to their profile page.                                     | 1. Login to the application and navigate to the profile page. 2. Verify that the profile page renders correctly.                                                                                                                                                                   | User can view their profile page.                                                                     | PASS        | 24/07/2022  |
| 8       | Request Handling                 | Test that upon swiping right on a user, a chat request is sent.                          | 1. Login to the application, and navigate to the swipe card. 2. Swipe right on a user named “test4”. 3. Verify that this action can be completed successfully.                                                                                                                     | User is able to complete swipe animation, which automatically sends a chat request to the other user. | PASS        | 24/07/2022  |
| 9       |                                  | Test that a user can view all their incoming requests under the Chat Requests page.      | 1. After completing the previous test, login to the application with the email: [test4@u.nus.edu](mailto:test4@u.nus.edu) and password: 123456. 2. Navigate to the chats page and click on the Chat requests button.  3. Verify that the chat requests page has updated correctly. | User is able to view incoming chat requests.                                                          | PASS        | 24/07/2022  |
| 12      | Matchmaking System               | Test that a user can view other registered users on the card stack                       | 1. Login to the application and navigate to the swipe card. 2. Verify that there is a swipe card with a user’s name, display picture and interests present.                                                                                                                        | Users are able to view all other registered users on the card stack everytime upon login.             | PASS        | 24/07/2022  |
| 13      |                                  | Test that a user can swipe both left and right                                           | 1. Login to the application and navigate to the swipe card. 2. Swipe right on the first user. 3. Logout, then log back into the application. 4. Swipe left on the next user again. 5. Verify that the action can be completed successfully.                                        | Users are able to make use of the swipe system to swipe both right and left.                          | PASS        | 24/07/2022  |
| 15      | Messaging System                 | Test that the user can display their current chats.                                      | 1. Login to the application and navigate to the chats page. 2. Verify that a list of current users that they are chatting with appears.                                                                                                                                            | User can see all their available chats, and a blank screen if there are no chats.                     | PASS        | 24/07/2022  |

**Regression Tests**

| Test ID | Key Feature                      | Test Objective                                                                                                                                                        | Steps                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Expected Outcome                                                                                                              | Test result                                                                                                                                                                                                                                         | Date tested |
|---------|----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| 1       | Register and Login               | Test that a user can successfully register. (AUTOMATED)                                                                                                               | 1. In the register page, key in a name, NUS email and a password. 2. Verify that an alert that reads “Email verification sent!” appears.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | User can successfully register, see an alert and receive a verification email.                                                | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 2       |                                  | Test that a user with an invalid NUS email cannot register                                                                                                            | 1. In the register page, key in a name, an email that does not end with “@u.nus.edu” 2. Verify that the form cannot be submitted.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | User will not be able to register without an email ending with “@u.nus.edu”.                                                  | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 3       |                                  | Test that a user cannot re-register an existing email.                                                                                                                | 1. In the register page, key in a name, an email “[test4@u.nus.edu](mailto:test1@u.nus.edu)”, and a password. 2. Verify that an alert that reads ”Failed to add user: Account already exists!” appears.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | User will not be able to register an email that already exists in the database.                                               | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 4       |                                  | Test that a registered user can successfully login after email verification is complete. (AUTOMATED)                                                                  | 1. In the login page, key in our personal NUS email as email and our registered email as password. 2. Verify that we can see the Home Page (Swipe card)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | After completing email verification, the user will be able to login to the application.                                       | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 5       | Password Reset                   | Test that a user can reset their password. (AUTOMATED)                                                                                                                | 1. In the login page, click on the “Forgot Password” button. 2. Key in a registered NUS email. 3. Verify that an alert appears.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | After requesting to reset the password to an account, an alert appears, signifying that a password reset email has been sent. | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 6       | Creating and Customizing Profile | Test that a user can navigate to their profile page.                                                                                                                  | 1. Login to the application and navigate to the profile page. 2. Verify that the profile page renders correctly.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | User can view their profile page.                                                                                             | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 7       |                                  | Test that a user can select their bio, interested activities, faculty, year of study, display photo and the info is saved.                                            | 1. Login to the application, and navigate to the profile page.  2. Under the bio section, edit the box into a custom bio. 3. Under the interests section, select certain interests that are not the default values. 4. Under the faculty section, select a different faculty. 5. Under the year section, select a different year. 6. Click the red camera button to choose a different photo. 7. Click “Save info”. 8. Logout and log back in and verify the new information has been saved.                                                                                                                                                                                                                                                                                                                                      | User can edit and save the fields on their profile page.                                                                      | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 8       | Request Handling                 | Test that upon swiping right on a user, a chat request is sent.                                                                                                       | 1. Login to the application, and navigate to the swipe card. 2. Swipe right on a user named “test4”. 3. Verify that this action can be completed successfully.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | User is able to complete swipe animation, which automatically sends a chat request to the other user.                         | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 9       |                                  | Test that a user can view all their incoming requests under the Chat Requests page.                                                                                   | 1. After completing the previous test, login to the application with the email: [test4@u.nus.edu](mailto:test4@u.nus.edu) and password: 123456. 2. Navigate to the chats page and click on the Chat requests button.  3. Verify that the chat requests page has updated correctly.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | User is able to view incoming chat requests.                                                                                  | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 10      |                                  | Test that a user can accept/decline their incoming chat requests                                                                                                      | 1. Login to the application with the email: [test4@u.nus.edu](mailto:test4@u.nus.edu) and password: 123456. 2. Navigate to the chats page and click on the Chat requests button.  3. Click on an existing request. 4. Press the “+” icon. 5. Verify that upon accepting, the chat request disappears.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | User is able to accept incoming chat requests.                                                                                | FAIL  (In the event that someone accepts the user’s outgoing chat request while the user is at the chat home page, there is a chance that the chat shows up incorrectly.) This is one of the bugs we were unable to fix regarding realtime updates. | 24/07/2022  |
| 11      |                                  | Test that there will not be duplicate requests. This test is no longer required, since each user will only be able to swipe once on every other user in the database. | 1. Login to the application and navigate to the swipe card.  2. Swipe right on the user “test4”. 3. Logout 4. Repeat steps 1-3. 5. Login to the application with the email: [test4@u.nus.edu](mailto:test4@u.nus.edu) and password: 123456. 6. Navigate to the chats page and click on the Chat requests button.  7. Verify that there are no duplicate incoming requests.                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Users will not receive duplicate chat requests from users that swipe right multiple times on the same person.                 | PASS                                                                                                                                                                                                                                                | 24/06/2022  |
| 11      | Matchmaking System               | Test that a user can view other registered users on the card stack                                                                                                    | 1. Login to the application and navigate to the swipe card. 2. Verify that there is a swipe card with a user’s name, display picture and interests present.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Users are able to view all other registered users on the card stack everytime upon login.                                     | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 12      |                                  | Test that a user can swipe both left and right                                                                                                                        | 1. Login to the application and navigate to the swipe card. 2. Swipe right on the first user. 3. Logout, then log back into the application. 4. Swipe left on the first user again. 5. Verify that the action can be completed successfully.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Users are able to make use of the swipe system to swipe both right and left.                                                  | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 13      |                                  | Test that a user cannot swipe while not having completed their profile.                                                                                               | 1. Login to the application with an email: “incomplete@u.nus.edu” and a password: “123456”.  2. Navigate to the swipe card.  3. Try to swipe right on the first user. 4. Verify that an alert that reads “Please complete your profile before swiping! ” pops up. 5. Repeat steps 3 and 4 while swiping left.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | A user with incomplete fields will not be allowed to swipe.                                                                   | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 14      |                                  | Test that a user will not see the same user after swiping on them.                                                                                                    | 1. Login to the application and navigate to the swipe card. 2. Swipe left on the first user. 3. Logout, then log back in. 4. Without changing any settings, verify that the user previously swiped on no longer shows up on the swipe card.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | User can only swipe once on another user.                                                                                     | PASS                                                                                                                                                                                                                                                | 24/07/22    |
| 15      | Messaging System                 | Test that the user can display their current chats.                                                                                                                   | 1. Login to the application and navigate to the chats page. 2. Verify that a list of current users that they are chatting with appears.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | User can see all their available chats, and a blank screen if there are no chats.                                             | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 16      |                                  | Test that upon accepting another user’s chat request, they appear on the chats page.                                                                                  | 1. Login to the application and navigate to the chats page. 2. Click on the Chat requests button.  3. Click on an existing request. 4. Press the “+” icon. 4. Navigate to the chats page. 5. Verify that the chats page is updated to show the accepted user.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | User can accept an incoming request and view the changes in their chats page.                                                 | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 17      |                                  | Test that previous messages can be retrieved.                                                                                                                         | 1. Login to the application and navigate to the chats page. 2. Click on an existing chat. 3. Verify that previous messages exchanged appear.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | User can view messages that have been sent previously.                                                                        | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 18      |                                  | Test that messages can be sent and received in real time.                                                                                                             | **This test requires the assistance of an additional user.** 1. Both users to login to the application and navigate to the chats page. 2. Click on each other as an existing chat. 3. Verify that messages can be sent and received by both users.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | User can make use of the messaging system to chat in real time.                                                               | PASS                                                                                                                                                                                                                                                | 24/06/2022  |
| 19      | Filter System                    | Test that Users can set basic filters.                                                                                                                                | 1. Login to the application and navigate to the profile page. 2. Scroll to the bottom and click on “Set Your Preferences”. 3. Verify click on buttons on the filter screen turns the colour from orange to grey and vice versa.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Users can click on buttons that set their preferences.                                                                        | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 20      |                                  | Test that upon updating the filters, the swipe card changes accordingly                                                                                               | 1. Login to the application and navigate to the profile page. 2. Scroll to the bottom and click on “Set Your Preferences”. 3. Ensure that all the buttons are selected (orange). 4. Alternate between De-selecting Male and Female under the Gender category, and click on “Save Info”. 5. Navigate to the swipe card. 6. Verify that the swipe card has changed after each selection.                                                                                                                                                                                                                                                                                                                                                                                                                                            | Users can set their preferences and view the corresponding changes to the swipe card.                                         | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 21      |                                  | Test that empty selections for any one category will result in an empty swipe card.                                                                                   | 1. Login to the application and navigate to the profile page. 2. Scroll to the bottom and click on “Set Your Preferences”. 3. De-select all the buttons under the “Gender” Category. 4. Navigate to the swipe card. 5. Verify that the swipe card is now empty. 6. Repeat steps 1 to 5 for each of the other categories.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Users will need to select at least one option from each category in order to view a valid swipe card.                         | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 22      | Recommendation Algorithm         | Test that the recommendation algorithm arranges the swipe card in order of “similarity”                                                                               | 1. Login to the application and navigate to the profile page. 2. Select all the interests, and click “Save Info”. 3. Navigate to the swipe card. 4. For each user, take note of the number of interests displayed, then swipe. 5. Verify that the number of interests the user has decreases.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Users can view the profiles with higher “similarity” at the front of the swipe card.                                          | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 23      | Feedback System                  | Test that feedback and bugs can be reported.                                                                                                                          | 1. Login to the application and navigate to the swipe card.  2. Click on “Report a bug” on the top right hand corner. 3. Choose “Bug” from the drop down menu, and enter a description. 4. Click on “Submit form”. 5. Verify that an alert that says “Thank you for your feedback!” appears. 6. Repeat steps 3 - 6 for each feedback category.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Users can send their feedback/ report bugs they find on the app.                                                              | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 24      | Report Abuse                     | Test that once a user has been reported, an automated message will be sent to the admin in a chat room.                                                               | 1. Login to the application and navigate to the chats page. 2. Click on an existing chat.  3. On the top right hand corner, click on the 3 dots. 4. Click on “Report user” under the dropdown menu. 5. Verify that an automated message has been sent to the admin in a chatroom with the admin.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Users can report another user, and thus start a chatroom with the admin.                                                      | PASS                                                                                                                                                                                                                                                | 24/07/2022  |
| 25      |                                  | Test that once a user has been blocked, messages cannot be sent or received.                                                                                          | 1. Login to the application with the email: [test4@u.nus.edu](mailto:test4@u.nus.edu) and password: 123456 and navigate to the chats page. 2. Click on the existing chat with the user Test2. 3. On the top right hand corner, click on the 3 dots. 4. Click on “Block user” under the dropdown menu. 5. Verify that an alert that says “Blocked/unblocked successfully” appears. 6. Try to send a message to the blocked user. 7. Verify that the message cannot be sent, and an alert that says “Unable to send message: Blocked” appears. 8. Logout, and login to the application with the email: [test2@u.nus.edu](mailto:test4@u.nus.edu) and password: 123456. 9. Click on the existing chat with user test4. 10. Verify that the message cannot be sent, and an alert that says “Unable to send message: Blocked” appears. | Users can block another user. No messages will be allowed to be exchanged in the event of such a block.                       | FAIL (After “Block user” has been clicked, there is a chance where messages are still allowed to be sent by the initiator. However, after reloading, they can no longer do so) This is another bug relating realtime updates we were unable to fix. | 24/07/2022  |
| 26      |                                  | Test that once a chat has been deleted, it can no longer be seen by the user                                                                                          | 1. Login to the application and navigate to the chats page. 2. Click on an existing chat. 3. On the top right hand corner, click on the 3 dots. 4. Click on “Delete chat” under the dropdown menu. 5. Click on “OK”. 6. Verify that the chat has been deleted.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Users can delete the chat, and after which, both parties will be unable to continue chatting.                                 | PASS                                                                                                                                                                                                                                                | 24/07/2022  |

## Automated User Interface Testing:

Flutter SDK provides developers with tools that can help them conduct testing for their applications. One example of this is the **Integration Test** package. This package allows us to write test cases for the machine to run, thus automating our testing processes. Due to limited time constraints, and a heavy focus put into developing our core features, **we were only able to explore using this Testing technique for basic features, including Login, Register, and Password Reset.**

A detailed explanation of how this test was conducted can be found in the following Test Demo Video: [Testing Demo.mp4](https://drive.google.com/file/d/18WWzPDzxVAh1MD4BbAU0Cz5a2eqwlE8D/view?usp=sharing)

Unfortunately, after conducting these automated tests, **we realised that while this tool has great potential, making use of it to test a social app such as ours is a non-trivial endeavour**. For example, it will prove difficult to verify that our filter system or recommendation algorithm is working by making use of Flutter’s Integration Test package, which can be automated. With the addition of the time spent trying to fix bugs related to this test procedure (which did not add value to our product), we decided to abandon this idea.

## User Testing:

Due to our product being a social app in nature, we also believe that user testing is essential to ensuring that the application is viable and in good working condition for users.

We recruited several of our personal friends to try out a version of the application that has **passed our system testing and automated testing**. We gave them minimal instructions, to simulate the new user experience, and to gauge the intuitiveness of our application. They tried out each of the features implemented for Milestone 2, and consequently gave their rating (out of 10) on the various aspects of our application. The average results collected, as well as the general feedback are as such:

Main Features and their limitations

-   Profile Customization: 7
    -   Limited list of interests, and unable to enter unique interests as text.
    -   Unable to select no interests
    -   Could include gender, whether the user is living on campus, major, NUS CCAs etc
-   Swipe System: 7
    -   After every login, the same swipe card reappears regardless of whether the user has been swiped on previously.
-   Request Handling: 6
    -   Swiping left and right on a chat request is unintuitive, and would prefer to have an accept/decline button
-   Messaging System: 7
    -   Messages would be bugged when one of the users involved in the chats are in a different time-zone, or have their time set to an earlier/later time intentionally (this is discovered as one of the testers had set their device’s time later by 5 minutes on purpose) .
    -   Unable to send photos, videos and other types of media.

Overall application

-   User Interface: 6
-   User Experience: 6

Date of user tests: 24/06/2022 - 25/06/2022

Overall, the feedback we obtained informed us that the features that we have implemented thus far are limited, and might not be able to provide an enjoyable user experience. Through user testing, we have discovered some limitations in our implemented features. We will thus focus on improving and refining these features further for Milestone 3, in order to create a product that is viable and pleasant to use.

For Milestone 3, we have conducted similar user tests but with more features this time.

The average rating for each feature with some feedback are as such:

Main Features rating with feedback:

-   Profile Customization: 7
    -   Font used on buttons quite thin + orange colour makes it hard to read, maybe experiment with using the “Medium” versions of fonts to make it easier to read
    -   Placeholder texts like the one in the “About me” field should be set as actual placeholder values, not preset values in the bio
    -   Buttons and option bars not centralised, can have more options
    -   Can have more hobby options
-   Swipe System: 8
    -   The animation can be quite quick to disappear which makes it easy to miss what action you performed if done accidentally.
-   Request Handling: 8
    -   Works well as intended
    -   Could use live notifications
-   Messaging System: 8
    -   Faster loading would better
    -   Live notifications would be good
    -   Good that images can be sent
-   Filter System: 8
    -   Works as intended
    -   Unintuitive as default is all selected instead of all unselected
-   Feedback and report abusers system: 9
    -   Good to have confirmation that feedback was sent
    -   Works as intended, can have preset options for reasons

Overall application with feedback

-   User Interface: 7
    -   Overall quite straightforward and has a pleasant to look at UI, aside from minor adjustments, very nice.
-   User Experience: 8
    -   Not very intuitive to setup profile after creating the account, might be better to perform profile setup while creating the account
    -   Have a toast for when user actions are performed so it signals to users that an action was done, otherwise, they might keep pressing the same button thinking it failed (especially when selecting preferences)
    -   But in general, easy to navigate and does not have too many overly complicated UI elements disrupting visual focus

Date of user tests: 24/07/2022 - 25/07/2022

# Software Engineering Principles

This section denotes the Software Engineering Principles that we have incorporated into our work over the course of Orbital.

## Version Control using Git:

We made use of branching to organize our respective work. Whenever we implemented a new feature (i.e. Firebase Backend or Adding a Home Page), we make sure to create a new branch that corresponds to that additional feature. This way, we ensure that the main branch is not affected whenever we add the feature.

![](media/99c343c9710b21e4521ddb4925ead4da.png)

The branches within the red rectangle are active branches that we have created and worked on in the past.

## Pull Requests:

Before each member pushes their work onto the main branch, we made use of the pull requests feature on Git to ensure that both parties are well informed on the changes that have been made. After reviewing the code and testing on their own end, the other party will be the one to merge changes onto the main branch. This ensures that both members are on the same page.

**![](media/9da98cd1f64db67f20383d16dc5e8600.png)**

# Project Log

| S/N         | Task                                                                                                                                                                                  | Date              | Chen Guanzhou | Alvin Jiang | Remarks                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|-------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|---------------|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1           | Liftoff Submission                                                                                                                                                                    | 12 May            | 3             | 3           | Initial Meeting + Poster Design and Video Filming                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| 2           | Mission Control 1                                                                                                                                                                     | 14 May            | 4             | 4           | React Native + Git Workshop                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| 3           | Self-Learning of Tech Stack                                                                                                                                                           | 14 May - 31 May   | 25            | 25          | Both:  React Native Basics Flutter Basics Firebase Basics  Frontend (Orbitee 1): Making use of existing packages and widgets Learning from online guides to create card stack Learning from online guides to create profile page Backend (Orbitee 2): Integrating of firebase into Flutter App Firebase Auth                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| 4           | Business Idea Validation Workshop                                                                                                                                                     | 20 May            | 1             | 1           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 5           | Git + GitHub setup and first commit                                                                                                                                                   | 23 May            | 2             | 2           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 6           | Individual Programming                                                                                                                                                                | 23 May - 31 May   | 9             | 9           | Frontend: Design and implement basic Login, Register Page and Home Page using Flutter Widgets, with text editing and password hiding  Backend:  Set up Firebase backend, user authentication using Firebase Auth, validation logic, navigation between screens                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| 7           | Check-in Meeting                                                                                                                                                                      | 26 May            | 2             | 2           | Corroborate work, merge pending pull requests, ideation for future features.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| 8           | Work on MS1 Submission                                                                                                                                                                | 26 May - 31 May   | 6             | 6           | Writing of Readme document, creating program flow chart, packaging app, demo video filming, project log.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| 9           | Final Team Meeting before MS1                                                                                                                                                         | 28 May            | 2             | 2           | Finalise deliverables: poster, video, ensure app is available for trying.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Milestone 1 |                                                                                                                                                                                       |                   |               |             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 10          | Writing of Peer Review for other teams                                                                                                                                                | 3 June - 6 June   | 5             | 5           | Review other teams’ materials, testing technical proof of concept and writing peer evaluations.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 11          | Team Meeting to discuss Peer Evaluation feedback                                                                                                                                      | 7 June            | 1             | 1           | Discussed feedback from peer evaluation and created a work plan for Milestone 2.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 12          | Self-Learning of Tech Stack                                                                                                                                                           | 7 June - 23 June  | 10            | 10          | Both:  Cloud Firestore Software Testing Techniques Frontend:  Online guide on creating profile page. Online guide on creating chat system Using Flutter packages Backend: Integrating email verification Integrating password reset Read and Write to Cloud Firestore and Firebase Storage                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| 13          | Individual Programming (Profile Page)                                                                                                                                                 | 7 June - 15 June  | 15            | 15          | Both: Debugging after backend integration  Frontend:  Creating Profile Page user interface Coding and debugging Multi-Select Form Field Backend: Email Verification integration Backend support for Profile Page                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 14          | Individual Programming (Chat Page, Chat Request Page, Swipe System)                                                                                                                   | 15 June - 23 June | 18            | 18          | Both:  Debugging and testing after backend integration Frontend: Design and coding of chats page, chat request page, and user information page Routing of chats page and coding of messaging system Give assistance regarding backend related debugging  Backend: Backend support for swipe system, password reset page. Backend routing for chats home page, chat request page. Read and Write data after chat request acceptance. Debug backend related bugs regarding asynchronous calls.                                                                                                                                                                                                                                                                                                  |
| 15          | Tidy code, improve UI, conduct Smoke and Regression Tests                                                                                                                             | 24 June           | 4             | 4           | Resolving poor syntax, and simplifying code, write out smoke test cases and regression test cases and conducting them.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| 16          | User Testing                                                                                                                                                                          | 24 June - 25 June | 2             | 2           | Packaging the app and sending it to a few of our close friends for user testing.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 17          | Work on MS2 Submission                                                                                                                                                                | 25 June - 27 June | 9             | 9           | Writing of readme, creating frontend and backend tree diagrams, updating poster and video, project log.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Milestone 2 |                                                                                                                                                                                       |                   |               |             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 18          | Peer review on other teams’ projects                                                                                                                                                  | 28 June - 4 July  | 4             | 4           | Review other teams’ materials, testing app features and writing peer evaluations.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| 19          | Team Meeting to discuss Peer Evaluation feedback                                                                                                                                      | 4 July            | 1             | 1           | Discussed feedback from peer evaluation and created a work plan for Milestone 3.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 20          | Bug fixes and individual learning of how to implement required features                                                                                                               | 5-8 July          | 6             | 6           | Fixed a bug regarding device date time inconsistencies, changed chat request decision implementation to be in profile info page, small improvements to profile fields (adding more options and fields).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| 21          | Mission Control 5 (Poster and Video Workshop)                                                                                                                                         | 8 July            | 2             | 2           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 22          | Individual Programming (Report user, block/unblock user, image sending features, filter system, delete chat, recommendation algorithm implementation, feedback system, and bug fixes) | 9- 20 July        | 18            | 18          | Full stack implementation (Dart with Firestore Database support) , testing, and debugging of: Report user feature to the administrator. Blocking/ unblocking user feature to prevent further chatting. Delete chat feature to remove the chat room and smoothen chat experience once chat is no longer needed.  Image sending feature (on top of text, emotes, and other language support). Filter system to set and save preferences (filter out profiles to be shown in the home page). Recommendation algorithm to order the profile cards so the profiles with similar interests are shown first in the home page. Feedback system for users to provide feedback or report bugs. Fixed a bug where users could swipe on a profile more than once. (Each profile can only be swiped once)  |
| 23          | Automated Testing                                                                                                                                                                     | 20 - 21 July      | 4             | 4           | Learned about automated testing and implemented test cases for automated testing                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 24          | Team Meeting                                                                                                                                                                          | 22 July           | 3             | 3           | Consolidated work done for both Orbitee, testing of features and debugging, as well as discussed UI improvements and minor bug fixes.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| 25          | UI Improvements                                                                                                                                                                       | 22 - 23 July      | 2             | 2           | UI Improvements on set your preference screen, as well as improved alignment and formatting in profile page, home page, profile info page in chat requests and feedback page.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| 26          | Team Meeting, Software Testing and tidying up code                                                                                                                                    | 24 July           | 6             | 6           | Conducted smoke, regression and user tests. 7 users tested the app and gave feedback on each feature with minimal instructions. Cleaned up some code and minor bug fixes.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| 27          | Working on Milestone 3 Submission                                                                                                                                                     | 24 - 25 July      | 8             | 8           | Documentation of software testing, problems encountered, features developed, bugs squashed, making of video demo and poster.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| Milestone 3 |                                                                                                                                                                                       |                   |               |             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

| **Total Hours** | **Orbitee 1** | **Orbitee 2** |
|-----------------|---------------|---------------|
| **172**         | **172**       | **172**       |
