# Assignment - Recipe Hunter

## Background

You happen to come across the [Recipe Puppy website](http://www.recipepuppy.com/), which is an ingredient based recipe search engine and discover that they offer an API that returns recipes in JSON format.

You get excited about creating your own website that would

1. Fetch the recipe information based on a search term entered in the address bar
2. Display the information in an HTML table - specifically, the **recipe photo**, the **recipe title** (both of which would be links that can take you to the actual recipe) and the **ingredients** required for the recipe.

Something like below...

![image](https://user-images.githubusercontent.com/869312/74001510-e90b0b00-4939-11ea-9f2b-a5a12b5e22dc.png)

## Getting Started

#### Prerequisites

This template was tested with Ruby **2.6.3** and Ruby on Rails **4.2.11**.

#### Bootstrapping

1. Clone this repo - `git clone https://github.com/jhu-ep-coursera/recipe_puppy_bootstrap.git`
2. Switch into the newly-cloned directory`cd recipe_puppy_bootstrap`
3. Run `bundle install` to install all the necessary gems

## Mocks first strategy

Your application needs to pull data from recipepuppy.com, which means that you will need to be connected to the internet when developing the app. But what if you want to go to a place where there is no internet? Or what if recipepuppy.com happens to be broken for a couple of days? Will this mean that you will not be able to work on your app any longer?

Well... What if you had _mock_ responses available to you? I.e. a built-in mechanism that is able to service a very limited set of your requests for recipe data even when recipepuppy.com is broken or even when you are not connected to the internet.

[webmock](https://github.com/bblimke/webmock) is a ruby gem that can facilitate setting up mock behavior for your application and in this bootstrap you have been set up for mocks to work by default, right away (in as few as ~10 lines of code)

![image](https://user-images.githubusercontent.com/869312/74405863-2a009500-4dfc-11ea-870b-1f279ce6d3f7.png)

When using the mocks mode, the only 3 foods you can request recipes for are **chocolate**, **bread** and **amarula** - as you can see under the **mocks** folder.

![image](https://user-images.githubusercontent.com/869312/74406012-8c599580-4dfc-11ea-881d-2867261546dc.png)

(You can, of course, add your own .json files following the example of the files under the mocks folder and your mock requests will work for those as well...)

When you feel like you would like to try out your application for real (and not in the mock mode), all you need to do is switch to non-mock mode by specifying `false` instead of `true` in the `config/application.rb` file

![image](https://user-images.githubusercontent.com/869312/74406423-9d56d680-4dfd-11ea-8d78-9238b9946052.png)
and restart your Rails server. (The key is called `use_mocks_please`)

## Requirements

1. The _model_ has been written for you - take a look under `app/models/recipe.rb`
2. Generate a `recipes` controller that has an `index` action
3. Inside the `index` action, you will need to create 2 instance variables:
   a. **`@search`**- this is the value of the query parameter `search` (see the screenshot above) if one is provided or `chocolate` if no `search` query parameter is present (default).
   b. **`@recipes`** - this is an array of recipes that you will get by calling the class method `for` of the `Recipe` class (_model_) available to you under `app/models/recipe.rb` with the `@search` variable you created right above.
4. Make sure that your `config/routes.rb` is able to successfully route you to `RecipesController`'s `index` action when `recipes/index` is requested. (This should already be the case if you used `rails generate controller` command to create your controller.)
5. We now have the `controller` and the `model` implemented! We are so close! All we need is the `view`. The view, `app/views/recipes/index.html.erb`, should contain the following:
   a. An `<h1>` element with "Recipes for X" (where 'X' would be replaced with the actual search term used). Look back at your `controller` implementation for what you can use to insert a search term here.
   b. A `<table>` element
6. The `<table>` element from the previous list item should contain the following:
   a. `<tr>` element with 3 `<th>` elements for `Photo`, `Title` and `Ingredients` respectively.
   b. `<tr>` element for each `recipe` in the `recipes` array with 3 `<td>` elements (columns) as described below.
7. 1st column should contain an image of the recipe (`thumbnail` property of the `recipe`) hyperlinked to the recipe's URL (`href` property of the `recipe`). You can use [link_to](https://api.rubyonrails.org/v4.2.11/classes/ActionView/Helpers/UrlHelper.html#method-i-link_to) and [image_tag](https://api.rubyonrails.org/v4.2.11/classes/ActionView/Helpers/AssetTagHelper.html#method-i-image_tag) view helpers to accomplish this task.
8. 2nd column should contain the title of the recipe (`title` property of the `recipe`). Again, you can use `link_to` view helper to accomplish this task.
9. 3rd column should contain the ingredients required for the recipe (`ingredients` property of the `recipe`).

After implementing the above, you should be able to start the rails server in one tab (`rails s`) and run the bundled tests in the other tab by running `rspec` on the command-line.

![image](https://user-images.githubusercontent.com/869312/74399445-d8024400-4de8-11ea-9f07-dfec15e77cc0.png)

![image](https://user-images.githubusercontent.com/869312/74111128-4c768200-4b60-11ea-9b0e-f308b6046565.png)

This will run the tests in the Headless mode using Chrome Headless driver for Capybara. If you want to see the tests running inside the Chrome browser, you can uncomment the following 2 lines inside the `spec/spec_helper.rb` file:

![image](https://user-images.githubusercontent.com/869312/74401216-983e5b00-4dee-11ea-9d27-ff83f4456a6d.png)

and then run `rspec` again.

## More requirements

As you can see, if you have implemented the requirements so far correctly, all but 2 of your tests should now be passing. What about the last 2 tests?

1. Right now, the only way to get to the `index` action of the `recipes` controller is to actually type in `recipes/index` in the browser URL. It would be nice if the **root** route of the application automatically took us to the `index` action of the `recipes` controller. For this to happen, you will need to do something in the `config/routes.rb`

2. Some characters come back from the API as [HTML entities](https://developer.mozilla.org/en-US/docs/Glossary/Entity), but should be displayed correctly on the page. Let's assume that we only want to fix this issue in the **title** of the listing. For example,

![image](https://user-images.githubusercontent.com/869312/74402047-1f8cce00-4df1-11ea-9505-b45b77f75359.png)

\&Eacute; should be showing up as &Eacute;

![image](https://user-images.githubusercontent.com/869312/74402770-3af8d880-4df3-11ea-8b88-b2c24d62ed23.png)

Take a look at the [sanitize](https://api.rubyonrails.org/v4.2.11/classes/ActionView/Helpers/SanitizeHelper.html#method-i-sanitize) view helper to see how to easily accomplish this task

After implementing the final requirements in your app, all the tests should pass when running `rspec`:

![image](https://user-images.githubusercontent.com/869312/74499985-7955cc80-4eb3-11ea-8758-45010b753e39.png)

## Submission

Now that your local tests are passing - you are ready to submit your assignment!!

#### What needs to be submitted

The automated grader is looking for 3 files:

1.  `config/routes.rb`
2.  `app/controllers/recipes_controller.rb`
3.  `app/views/recipes/index.html.erb`

#### 2 ways to create the zip file

I recommend using `git` to create your zip file for submission. Below are the necessary steps:

1.  Create your `git` repo with`git init`
2.  Add all the files to it with `git add .`
3.  Commit the files to the repo with `git commit -m 'YAY - my tests are passing'`
4.  Create the zip file with `git archive -o mysubmission.zip HEAD app config`

The `git archive` command above basically tells `git` to create a zip file from your latest `commit` and to only include the `app` and `config` folder in that zip file. The zip file will be found in the directory where you ran the `git archive` command.

At this point you are ready to submit your newly created zip file!!!

If the submission fails and you need to make tweaks to your code - remember to commit your changes to the repo and create another zip file...

Of course, if you don't want to create the zip file using `git archive`, you can just create the zip file the way you know how - just make sure that the `app` and `config` folders are in there.

Good luck!!!

-Kalman Hazins
