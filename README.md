Bimblis
=======

This gem is a collection of reusable steps and methods for web browsing automation, using cucumber, page-objects gem and Watir.

While doing web browser automation, I realiced that I had to write again and again the same methods to do the same operations (click this button, fill that field, check this text is correct, navigate to that URL, check the URL is correct, etc), so the idea of having general methods that were able to do the usual operations in most circunstances was born.

Basically, to write a new Scenario with this gem, the tester should only identify the html elements in page_object documents, and write the cucumber steps. To write new code should only be done when you need something special. 

Installing
----------
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
