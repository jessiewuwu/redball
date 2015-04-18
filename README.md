
### Purpose
red ball is an online community that encourages adoption and fostering with a social aspect. Similarly to product reviews by users on Amazon, volunteers that have interacted with available dogs can leave ratings so that potential adopters can gain a better gauge of the dog's personality.

### Quickstart

1.  `bundle install`
2.  `be rake db:create`
3.  `be rake db:migrate`
4.  `be rake db:seed`
5.  `be shotgun`


6. Log in as a volunteer to rate dogs: username: mish, password: michelle
7. Log in as an admin to create, edit, delete a dog's profile: username: admin, password: amadou
8. If both fail, the login info is in my seeds file.


### AHA Moments

1. When you click on a checkbox form, the params value gets passed as "on". I spent a long time trying convert "on" to return a true value so that it could meet the t.boolean value for personality attributes Rating table. In the end, I decided to change t.boolean to be t.string so that it'd accept and update_attributes to "on".

By doing this, we can count how many personality attributes that volunteers had voted for a dog.

2. Using sessions[:id] or having input type="hidden" name="name" value="<% some sort of value %>" allows you to take that value/variable from the view erb file to another route in our controller.

3. I had a lot more but I can't think of any right now because it is getting late.


### Challenging Points (If I had more time, I'd fix all of these:)
**IT WORKS NOW!** 1. My delete route isn't working and I am not sure why. It may be because the user has to first search for the ID#, which then goes through the post method, but then we'd have to go to the delete method with the same ID# from the post method.

2. With randomize, it directs you to the profile of a random dog_id, however if you had deleted the dog's profile from the database, the current randomize route doens't take this into consideration. If Dog id 3 is deleted and the random number is 3, then it'll redirect the user to a broken page. Maybe I have to include some if conditions.

3. All my routes are in the index.rb file. It would be better to spend a few minutes to put them in the appropriate category files. Since I am out of time, I am paranoid that if I start moving things around, it will break all the routes, even though technically it shouldn't, I think, maybe.

**IT WORKS NOW! NOT DRY, BUT IT WORKS!** 4. I was unable to successfully have access levels for Volunteers and Admin. If the user isn't logged in, then they shouldn't have access to the dog rating route (/dogs/:id/new). If the user is logged in, the log-out link will appear in the nav bar and they wouldn't have to see the same index options: sign in, register, view as a guest. Right now any volunteer can create, edit, and delete a profile page, but really only the Admin should have access to these routes.

5. Instead of having both an Admin model (which I ended up not using due to time) and a Volunteer model, I should add an attribute: t.boolean :admin since both the Volunteer and Admin share the same keys: name, email, username, password.

6. My password validation min length isn't working. Is it because of bcrypt?

**IT WORKS NOW! I had given it the wrong params name** 7. When I had my original code, it would allow me to see the options page, which you can only see if you're logged in. But then when I clicked to go rate a dog, it'd think I am no longer logged in and asked me to log in. My logout feature might not be working.

**I SHOULD ASK SOREN SINCE HE HAS IT IN HIS PROJECT** 8. I would like to figure out a way to store images in a database and have it show up based on an photo id or dog id. Right now pictures are inside the public/imgs folder and saved by the dog's id number. I have to manually name the photo based on the dog's id. It works for the /browse page, with the iteration, it shows the dog's picture. However if you go to the dog's profile, the picture link no longer works. I can't figure out why. The image link is exactly the same and both files are in the same folder.

9. Add a comments section that iterates through @all_comments_for_dog = Rating.where(dog_id: #) and it'll post all the volunteers' comments on the dog's profile.

10. Give error message when you entered the wrong password or username.



