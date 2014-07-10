# encoding : utf-8

module BasicMethods

  include PageObject
  include PageObject::PageFactory

  #
  # METHODS SECTION
  #

  def refresh_until_element_present (times, seconds, element)
    element = element.downcase.gsub(' ', '_')
    exists = send("#{element}?")
    visible = send("#{element}_element")
    times.to_i.times do |count|
      if exists && visible.visible?
        return true
      else
        sleep seconds.to_i
        $browser.refresh
      end
    end
  end

  def refresh_until_element_not_present (times, seconds, element)
    element = element.downcase.gsub(' ', '_')
    exists = send("#{element}?")
    visible = send("#{element}_element")
    times.to_i.times do |count|
      if exists && visible.visible?
        sleep seconds.to_i
        $browser.refresh
      else
        return true
      end
    end
  end

  def check_actual_url (url)
    unless $browser.url.include? eval(url)
      p $browser.url
      p eval(url)
      raise 'Incorrect URL!'
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
        raise 'no valid option selected'
    end
  end

  #work in progress
  # def click_all_links(element)
  #   element = element.downcase.gsub(' ', '_')
  #   wait_until{send("#{element}?")}
  #   select = send("#{element}_element")
  #
  #   links_array = []
  #   $browser.links(xpath: ".//*[@title='Delete Ad']").take(total_results).each do |link|
  #     links_array << link.title
  #   end
  #   links_array.each do |link_number|
  #     $browser.link(:title, link_number).click
  #
  #     wait_until{close_window_button?}
  #     close_window_button
  #   end
  #
  #   if  select.visible?
  #     select.click
  #     element = element.downcase.gsub(' ', '_')
  #     wait_until{send("#{element}?")}
  #     select = send("#{element}_element")
  #   end
  #   select = send("#{element}_element")
  # end

  def select_element (option, element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}_select?")}
    object = send("#{element}_select_element")
    wait_until{object.visible?}
    wait_until{object.enabled?}
    object.select(option)

    $advanced_text_info[element] = option
  end

  def hover_element (element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}?")}

    select = send("#{element}_element")
    wait_until{select.visible?}

    select.hover
  end

  def click_element (element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}?")}

    select = send("#{element}_element")
    wait_until{select.visible?}

    select.click
  end

  def click_link (element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}_link?")}

    select = send("#{element}_link_element")
    wait_until{select.visible?}

    send("#{element}_link")
  end

  def check_checkbox (check, element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}_checkbox?")}

    select = send("#{element}_checkbox_element")
    wait_until{select.visible?}

    if check.downcase == 'check'
      send("check_#{element}_checkbox")
    elsif check.downcase == 'uncheck'
      send("uncheck_#{element}_checkbox")
    else
      raise 'check unselected!'
    end
  end

  def click_button(element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}_button?")}

    button = send("#{element}_button_element")
    wait_until{button.enabled?}
    wait_until{button.visible?}

    send("#{element}_button")
  end

  def check_exist_element(element)
    element = element.downcase.gsub(' ', '_')
    unless wait_until{send("#{element}?")}
      raise "#{element} was not found!"
    end
  end

  def check_element_not_exist(element)
    element = element.downcase.gsub(' ', '_')
    exists = send("#{element}?")
    if exists
      raise "#{element} was found!"
    end
  end

  def record_element_text(element)
    select = send("#{element}_element")
    $advanced_text_info[element] = select.text
  end

  def input_text_field (element, faker = 'lorem paragraph')
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
    $text_info.push(sample_text)
    $advanced_text_info[element] = sample_text

    wait_until{send("#{element}_field?")}

    select = send("#{element}_field_element")
    wait_until{select.visible?}

    send("#{element}_field=", sample_text)
  end

  def check_element_content(element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}?")}
    value = "false"
    select = send("#{element}")

    $text_info.each { |x|
      if select.downcase.include? x.downcase
        value = "true"
      end
    }
    unless value == "true"
      p select.downcase
      p $text_info
      raise 'Not found'
    end
  end

  def check_element_not_contains(element)
    element = element.downcase.gsub(' ', '_')
    wait_until{send("#{element}?")}
    value = "false"
    select = send("#{element}")

    $text_info.each { |x|
      if select.downcase.include? x.downcase
        value = "true"
      end
    }
    unless value == "false"
      raise 'Found!'
    end
  end

  def adv_check_element_contains(element_objective, element_memory)
    element_objective = element_objective.downcase.gsub(' ', '_')
    element_memory = element_memory.downcase.gsub(' ', '_')
    wait_until{send("#{element_objective}?")}
    value = "false"
    select_primary = send("#{element_objective}")
    if select_primary.downcase.include? $advanced_text_info[element_memory].downcase
      value = "true"
    end

    unless value == "true"
      raise 'Not found'
    end
  end
end
