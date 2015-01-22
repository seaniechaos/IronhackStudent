# OC4. IronhackLIST

# Oh, man. We are so proud of our Student class. Validated, short, compact. Is it love?

# Anyway, the thing you probably missed from SL12 is having some web in between. Some routes, some Sinatra, some ERB… so let’s do it, why
# not?

# You will now implement a Ironhack directory of students, that shows a list of everyone’s name, surname, birthday, a clickable link to
# their website, if they have programming experience or not (Yes/No) and, more importantly, ¡the number of dogs they have!

# Apart from that, you should be able to create new students through the interface, and also delete the ones which have 0 dogs (we cannot
# kick the others out, they have dogs!).

# Go for it!


require 'sinatra'
require 'sinatra/reloader'
require_relative 'Students.rb'

set :port, 3004
set :bind, "0.0.0.0"

get '/' do

	@err_message = nil

	unless(params[:name].nil?)
		student = Student.new

		student.name = params[:name]
		student.surnames = params[:surnames]
		student.website = params[:website]
		student.number_of_dogs = params[:number_of_dogs]

		begin
			student.birthday = Date.new(params[:birth_year].to_i, params[:birth_month].to_i, params[:birth_day].to_i)

			if student.valid?
				student.save
			else
				@err_message = "Invalid Data Entered"
			end
		rescue
			@err_message = "#{$!}"
		end
	end

	@student_list = Student.all

	erb :ironstudent
end






