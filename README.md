Bimblis
=======

This gem is a collection of reusable steps and methods for web browsing automation, using cucumber, page-objects gem and Watir.

While doing web browser automation, I realiced that I had to write again and again the same methods to do the same operations (click this button, fill that field, check this text is correct, navigate to that URL, check the URL is correct, etc), so the idea of having general methods that were able to do the usual operations in most circunstances was born.

Basically, to write a new Scenario with this gem, the tester should only fill the elements in a page_object.rb, and write the cucumber steps. To write new code should only be done when you need something special.

Installing
----------
```bash
gem install bimblis
```
