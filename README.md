#Bimblis

This gem is a collection of reusable steps and methods for web browsing automation, using cucumber, page-objects gem and Watir.

While doing web browser automation, I realiced that I had to write again and again the same methods to do the same operations (click this button, fill that field, check this text is correct, navigate to that URL, check the URL is correct, etc), so the idea of having general methods that were able to do the usual operations in most circunstances was born.

Basically, to write a new Scenario with this gem, the tester should only identify the html elements in page_object documents, and write the cucumber steps. To write new code should only be done when you need something special. 

##Installing

```bash
gem install bimblis
```
I use RubyMine as IDE. In version 6.3, RubyMine is not able to find scenario steps contained inside gems (even if the scenarios work when launched throught terminal). To ammend this, the easiest solution is to create a link of the gem inside the proyect.

Type in terminal:
```bash
ln -s [route of the bimblis gem web_shared_steps.rb file] [route of the proyect features/steps folder]
 ```
It should be something like this (example):
```bash
ln -s /Users/[User name]/.rvm/gems/ruby-2.1.1/gems/bimblis-0.0.93/lib/features/step_definitions/web_shared_steps.rb /Users/[User name]/Documents/Git/qa-automation/features/step_definitions
 ```
If done correctly, for a scenario in which you use a Bimblis gem step, you can click in the step and be redirected to the step definition. If done incorrectly or not done, RubyMine should return a warning of "Undefined Step" (everything should work, thought).

```ruby
Before do |scenario|
$text_info = []
```
In your proyects hooks.rb file, in the Before area, you need to add this hash. It is expected for several steps of the gem when making checks of expected text.

In my projects, I store the url of the tested pages in a path.rb file that looks like this:
```ruby
class UrlPaths

$home_web                   = 'https://develop.homepage.com/'
$another_web                = 'https://develop.homepage.com/something'
$yet_another_web            = 'https://develop.homepage.com/place/example'
```
If you store your URL with this system, you can use one of the Bimblis steps to navigate to the different URLs, if not, you will have to build your own scenario and method.


Usage
----------
If you are doing browser automation with page_objects gem (shame on you if you not), you should have a page.rb document for each tested web. Those documents should look like this (I use Ids just for simplicity, you can use xpath, or any kind of identificator that works for page objects):

```ruby
 class HomePage
 
  link (:add_profile,                                     id: 'test0')
  text_field(:name_data,                                  id: 'validate_field_of_study')
  button(:return,                                         id: 'return')
  div(:information,                                       id: 'results')
``` 

Now, lets construct a simple Scenario using the Bimblis steps. It will consist in navigating to an URL, click a link, fill some random data in a field, click a button, and check that the written data is now present as text inside a div. I expect that the browser is open with Before in hooks.rb, and that everything is happening in the HomePage url.

These is ALL you need to write to make ready the scenario:

```cucumber
Given I navigate to 'home_web'
  And In "Home", I click the element of "add_profile"
  And In "Home", I fill 'lorem name' in text field "name_data"
  And In "Home", I click the element of "return"
 Then In "Home", I check if element "information" contains the info of element "name_data"
``` 

The test is done. Now you can relax, or start with the next test. As long as you keep using the Bimblis steps, and they should cover about 90% of the tipical automation job, you dont have to write more code.

FAQ
----------
