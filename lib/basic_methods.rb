# encoding : utf-8
module BasicMethods

  include PageObject
  include PageObject::PageFactory

  # page object of example:

  # class ExamplePage
  #
  # link (:test_link,                                       id: 'test0')
  # select_list (:test_select,                              id: 'test1')
  # checkbox (:test_checkbox,                               id: 'test2')
  # text_field(:field_study_field,                          id: 'validate_field_of_study')

  # -------------------------------------------------------------------------------------------------------------------

  ### INTERACTIVE METHODS
  
  # Clicks in a page element. Works with links, buttons, divs, and most html elements.
  # Checkboxes, radiobuttons and selects have their own method.
  # Example: on_page('ExamplePage').click_element('test_link')
  # @param element [String] Page element to be clicked
  # @param internally [Boolean] determines if javascript will be used to interact with the element. The value of the parameter is 'false' by default.
  def click_element (element, internally = false)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}?")}

    select = send("#{element}_element")

    if internally
      script = <<-JS
            arguments[0].click();
      JS
      self.execute_script(script, select)
    else
      wait_until{select.visible?}
      select.click
    end
  end

  # Hovers the mouse over a page element.
  # Example: on_page('ExamplePage').hover_element('test_link')
  # @param element [String] Page element to be mouse hover
  def hover_element (element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}?")}

    select = send("#{element}_element")
    wait_until{select.visible?}

    select.hover
  end
  
  # Checks or unchecks a checkbox
  # Example: on_page('ExamplePage').check_checkbox('check', 'test_checkbox')
  # Example: on_page('ExamplePage').check_checkbox('uncheck', 'test_checkbox')
  # @param check [String] Indicates if the checkbox has to be checked or unchecked
  # @param element [String] Page element of the checkbox
  # @param internally [Boolean] determines if javascript will be used to interact with the element. The value of the parameter is 'false' by default.
  def check_checkbox (check, element, internally = false)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}?")}

    select = send("#{element}_element")

    if check.downcase == 'check'
      if internally
        script = <<-JS
            arguments[0].checked = true;
        JS
        self.execute_script(script, select)
      else
        wait_until{select.visible?}
        send("check_#{element}")
      end

    elsif check.downcase == 'uncheck'
      if internally
        script = <<-JS
            arguments[0].checked = false;
        JS
        self.execute_script(script, select)
      else
        wait_until{select.visible?}
        send("uncheck_#{element}")
      end
    else
      raise 'invalid option for step definition selected!'
    end
  end

  # Chooses an option in a select. The option is recorded in a hash, with a key equal to the @param element.
  # Example for a test_select with these options: "Spain, France, Italy",
  # Example: on_page('ExamplePage').test_select('France', 'test_select')
  # @param option [String] Option to be selected (the text the user sees)
  # @param element [String] Page element of the select
  # @param internally [Boolean] determines if javascript will be used to interact with the element. The value of the parameter is 'false' by default.
  def select_element (option, element, internally = false)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}?")}
    object = send("#{element}_element")

    if internally
      script = <<-JS
          for (var i = 0; i < arguments[0].options.length; i++) {
            if (arguments[0].options[i].text === #{option}) {
                arguments[0].selectedIndex = i;
                break;
            }
          }
      JS
      self.execute_script(script, select)
    else
      wait_until{object.visible?}
      wait_until{object.enabled?}
      object.select(option)
    end

    $advanced_text_info[element] = option
  end

  # Clicks a radiobutton
  # Example: on_page('ExamplePage').click_radiobutton
  # @param element [String] Page element of the radiobutton
  def click_radiobutton(element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}?")}

    button = send("#{element}_element")
    wait_until{button.enabled?}
    wait_until{button.visible?}

    send("select_#{element}")
  end

  # Writes text in a text field. The text is recorded in a hash, with a key equal to the @param element.
  # Example: on_page('ExamplePage').input_text_field('lorem name', 'test_select')
  # @param faker [String] Indicates the kind of text to be written. If faker input coincides with an element of the faker
  # gem, it will generate a random string. If it doesnt coincides, the faker input will be written.
  # @param element [String] Page element of the text field
  # @param internally [Boolean] determines if javascript will be used to interact with the element. The value of the parameter is 'false' by default.  
  def input_text_field (element, faker = 'lorem paragraph', internally = false)
    element = element.downcase.gsub(' ', '_')

    case faker.downcase
      when 'lorem paragraph'
        sample_text = Faker::Lorem.paragraph
      when 'lorem name'
        sample_text = Faker::Name.name
      when 'lorem street'
        sample_text = Faker::Address.street_address
      when 'lorem zip'
        sample_text = Faker::Address.zip_code
      when 'lorem phone'
        sample_text = Faker::PhoneNumber.phone_number
      when 'lorem email'
        sample_text = Faker::Internet.email
      when 'lorem url'
        sample_text = Faker::Internet.url
      else
        if $advanced_text_info[faker] != nil
          sample_text = $advanced_text_info[faker]
        else
          sample_text = faker.to_s
        end
    end
    $advanced_text_info[element] = sample_text

    wait_until{send("#{element}?")}
    select = send("#{element}_element")

    if internally
      script = <<-JS
            arguments[0].value = '#{sample_text}'
      JS
      self.execute_script(script, select)
    else
      wait_until{select.visible?}
      send("#{element}=", sample_text)
  end

  # -------------------------------------------------------------------------------------------------------------------

  ### CHECK INFORMATION METHODS

  # Checks if an html element exists, or not exists.
  # Example: on_page('ExamplePage').check_element_exists('exist', 'test_link')
  # @param exist [String] Indicates if we are checking for the existence or nor existence of the element
  # @param element [String] Page element of the element we want to check.
  def check_element_exists(exist, element)
    element = element.downcase.gsub(' ', '_')

    if exist == 'exist'
      unless wait_until{send("#{element}?")}
        raise "#{element} was not found!"
      end

    elsif exist == 'not exist'
      if send("#{element}?")
        raise "#{element} was found!"
      end

    else 'Incorrect option selected'
    end
  end

  # Checks if an html element contains the text inputted before in a text_field or an option chosen in a select
  # Example: on_page('ExamplePage').check_element_contains('test_link', 'field_study_field')
  # @param element_objective [String] Page element that we want to check
  # @param element_memory [String] Page element in which we previously wrote the data
  def check_element_contains(element_objective, element_memory)
    element_objective = element_objective.downcase.gsub(' ', '_')
    element_memory = element_memory.downcase.gsub(' ', '_')

    select_primary = send("#{element_objective}")

    wait_until{send("#{element_objective}?")}

    unless select_primary.downcase.include? $advanced_text_info[element_memory].downcase
      raise 'Not found'
    end
  end

  def check_url (url)
    if eval(url) != nil
      unless $browser.url.include? eval(url)
        p $browser.url
        p eval(url)
        raise 'Incorrect URL!'
      end
    else
      unless $browser.url.include? url
        p $browser.url
        p url
        raise 'Incorrect URL!'
      end
    end
  end

  def record_element_text(element)
    select = send("#{element}_element")
    $advanced_text_info[element] = select.text
  end

  def refresh_until_element_exists (times, seconds, element)
    element = element.downcase.gsub(' ', '_')
    exists = send("#{element}?")
    visible = send("#{element}_element")
    times.to_i.times do
      if exists && visible.visible?
        return true
      else
        sleep seconds.to_i
        $browser.refresh
      end
    end
  end

  def refresh_until_element_not_exists (times, seconds, element)
    element = element.downcase.gsub(' ', '_')
    exists = send("#{element}?")
    visible = send("#{element}_element")
    times.to_i.times do
      if exists && visible.visible?
        sleep seconds.to_i
        $browser.refresh
      else
        return true
      end
    end
  end

  def browser_alert (option)
    option = option.downcase
    case option
      when 'ok'
        $browser.alert.ok
      when 'cancel'
        $browser.alert.close
      else
        raise 'invalid option for step definition selected!'
    end
  end
end
