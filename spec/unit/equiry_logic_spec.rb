require './lib/equiry_logic'
require 'pony'
require 'mail'
require 'spec_helper'

describe Enquiry do 

  before do
    Mail::TestMailer.deliveries.clear
  end

  describe (".create") do 
    it "Sends an enquiry to user" do 
      listing_owner = User.create(email: "lizzieturney@gmail.com", username: "LTURNS", password: "Hello").email
      enquiry_user = User.create(email: "collj035@gmail.com", username: "Unicorn", password: "1234").email
      body_test = "This is a body test"
      subject_test = "Test email"
      
      Enquiry.create(subject: subject_test, body: body_test, to: listing_owner, from: enquiry_user)

      mail = Mail::TestMailer.deliveries.last
      expect(mail.to).to eql enquiry_user
      expect(mail.from).to eql listing_owner
      expect(mail.body).to eql body_test
      expect(mail.subject).to eql subject_test
    end
  end 
end       




# describe Enquiry do 
#   describe "sending an email" do
#     include Mail::Matchers

#     before(:each) do
#       Mail::TestMailer.deliveries.clear

#       Mail.deliver do
#         to ['mikel@me.com', 'mike2@me.com']
#         from 'you@you.com'
#         subject 'testing'
#         body 'hello'
#       end
#     end

#     it { is_expected.to have_sent_email } # passes if any email at all was sent

#     it { is_expected.to have_sent_email.from('you@you.com') }
#     it { is_expected.to have_sent_email.to('mike1@me.com') }
#   end 



        