Welcome to the Immmr test project.
This project demonstrates a simple way of showing currently playing movies in cinemas around you
and some details about those movies.
As a final result, you should be able to see a list of movie posters and details with description and cast members.
The exercise shouldn't take longer than an hour. Don't worry if you can't finish it in this timespan, the way you work is more important than actually completing it.

If you have questions regarding your tasks, ask away - we're there to help.

Ready? Let's go!

Exercise 1: MVC

Implement `IMRMovieViewController` to show a collectionView with movie posters of currently playing movies.
To get those movies, we will use themoviedb.org and its public APIs.
A client class, to talk to these APIs, has been already implemented for you.
Your task is to use this client and its methods to get movie data and fill the collectionView with it.
All necessary methods to achieve this goal are already stubbed for you.
Try to use as little code as possible.
The collectionView should show these images in a grid. An appropriate layout has been implemented for you already.
Please use MVC as your design pattern. Model and view classes are made available for you and should not be changed.

Exercise 2: MVVM

Refactoring plays a big role in modern software development. So does proper architecture.
Using your implementations from exercise 1, please refactor `IMRMovieViewController` to use `IMRMovieViewModel`
as its source of data. The less code you use in your controller, the better.
The interface will provide all information you need to get your task done.
Please take care of proper visibility, meaning you should always program methods and variables to be private first and make them public only when you really need to access them from outside your class.

Disclaimer 1:
If you're not fluent with Reactive Cocoa, please use another form to notify your controller about changes.

Exercise 3: It's all about the details

Connect your `IMRMovieViewController` with the `IMRMovieDetailsViewController` to show movie details.
Make sure to use `IMRMovieDetailsViewModel` as its source of data in the MVVM fashion.
The API client provides a way to get the information you need.
All needed methods have already been stubbed for you and you should not need more to complete the task.
The used collectionView should make use of the provided tableLayout.
While using the API client, have you noticed a potential problem? Can we refactor it and use dependency injection?

When complete, this task will show us all details about a movie - title, poster picture, director(s) and all the cast members.

Exercise 4: Pretty is cool

Now that we have a working application, let's make it cooler.
Have you noticed that the cast pictures are oddly stretched? Using provided code, can you make them fit the posterImageView?
Using simple imageView APIs, can you make the cast images round?
Some cast members don't have a provided picture, not showing anything is not pretty.
Using provided methods, let's show a decent grey background with the cast members initials as a placeholder image.
For that, you can now adjust the given view classes.

Exercise 5*: Adjusting cell size

The plot cell does not always show the full movie description.
Using provided methods in your `IMRMovieDetailsViewController` implement a way to resize the plot cell dynamically, based on the movies description.

Exercise 6*: Too much information

The way the app shows a movies details is bloating our view. On some movies the cast list is just too long.
Using hints in `IMRMovieDetailsViewModel`'s interface, can you implement a way to show a much shorter list?
Can you think of a way how the controller could use its viewModel to show the full cast list on demand?
All the model and view classes needed to achieve this task are already implemented and you should not need new ones.

Exercise 7*: Bugs are bad, mkay?

Bug fixing is another important thing in our lives. We will introduce them no matter how hard we try not to. There just is no bug free software and the sooner we learn that, the better for our health.
Spotting bugs in our own implementations is also very important.
Have you spotted a bug after Exercise 5*?
What is it?
How did it come to that?
Can we fix it?

To fix it, use methods provided by UIKit. You're now allowed to modify your views, but let's not create new ones. The less code we write, the less bugs we introduce.

