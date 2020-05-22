require 'mail'
require 'pony'


class Enquiry 

  def self.create(subject:, body:, to:, from:)
    Mail.deliver do
      to "#{to}"
      from "#{from}"
      subject "#{subject}"
      body "#{body}"
    end
  
    mail.deliver!
    p "I have delievered a mail"
  end 
end 

# Mail.deliver do
#   to "collj035@gmail.com"
#   from "collj035@gmail.com"
#   subject "Testing"
#   body "Hello"
# end