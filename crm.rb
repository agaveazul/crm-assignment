require_relative 'contact'

class CRM

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def main_menu
    while true
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then abort("Goodbye!")
    end
  end

  def add_new_contact
    print "Enter First Name: "
    first_name = gets.chomp

    print "Enter Last Name: "
    last_name = gets.chomp

    print "Enter Email Address: "
    email = gets.chomp

    print "Enter Note: "
    note = gets.chomp

    contact = Contact.create(first_name, last_name, email, note)
    return contact
  end

  def modify_existing_contact
    contact = search_by_attribute
    #if contact.count == 0 use this if you want to search for an array of contacts
    if contact == nil
      return "I could not find a contact to modify."
    else
      puts "What field would you like to modify"
      puts "[1] First Name"
      puts "[2] Last Name"
      puts "[3] E-mail"
      puts "[4] Note"
      field = gets.chomp.to_i
        case field
        when 1
          puts "What would you like to change the first name to?"
          first_name_new = gets.chomp
          #contact[0].first_name= first_name_new, use this if you want to work with a group of contacts
          contact.first_name= first_name_new
        when 2
          puts "What would you like to change the last name to?"
          last_name_new = gets.chomp
          #contact[0].last_name= last_name_new, use this if you want to work with a group of contacts
          contact.last_name= last_name_new
        when 3
          puts "What would you like to change the e-mail to?"
          email_new = gets.chomp
          #contact[0].email= email_new, use this if you want to work with a group of contacts
          contact.email= email_new
        when 4
          puts "What would you like to change the note to?"
          note_new = gets.chomp
          #contact[0].note= note_new, use this if you want to work with a group of contacts
          contact.note= note_new
        else
          return "Sorry, that is not an option."
        end
    end
  end

  def delete_contact
    to_be_deleted = search_by_attribute
    if to_be_deleted == nil
      return "There was no contact found with a #{attribute} of #{value}."
    else
      to_be_deleted.delete
    end
    #to_be_deleted = Contact.find_by(attribute, value) - use when wanting to return multiple contacts
    # case to_be_deleted.count
    # when 0
    #   return "There was no contact found with a #{attribute} of #{value}."
    # when 1
    #   to_be_deleted[0].delete
    # else
    #   puts "There are multiple contacts with a #{attribute} of #{value}. Please narrow your selection further."
    #   to_be_deleted
    # end
  end

  def display_all_contacts
    return Contact.all
  end

  def search_by_attribute
    puts "How would you like to find the contact by"
    puts "[1] First Name"
    puts "[2] Last Name"
    puts "[3] E-mail"
    puts "[4] Note"
    method = gets.to_i
    case method
    when 1 then
      print "What is the first name of the contact you'd like to find?"
      first_name = gets.chomp
      return Contact.find_by("first_name",first_name)
    when 2 then
      print "What is the last name of the contact you'd like to find?"
      last_name = gets.chomp
      return Contact.find_by("last_name",last_name)
    when 3 then
      print "What is the e-mail of the contact you'd like to find?"
      email = gets.chomp
      return Contact.find_by("email",email)
    when 4 then
      print "What is the note of the contact you'd like to find?"
      note = gets.chomp
      return Contact.find_by("note",note)
    else
      print "Sorry that is not a valid option."
      contact = nil
    end
  end

end
