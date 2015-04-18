BROWSE/PLAYGROUND

Create a playground div section that is fixed.

Make the image draggable to the playground div.
  - the image has to store information like the id
  - clone the image and drag the cloned image to the playground div

Make the image clickable with dog.id saved so that the profile pops up in the right column.
  - create a two column layout
  - when clicked inside the div, partial shows up
  - scroll up to see the profile

BROKEN
  - new rating
  - only volunteers can leave ratings


Media
  - Watch the video
  - Volunteers can upload a picture at the profile page
  - Rating form:
    - Video url link - create an attribute for rating with video url
  - iterate through with
  <iframe width="460" height="315" src="rating's video url" frameborder="0" allowfullscreen></iframe>



/////////////// THINGS TO DO - THURSDAY /////////////////////////

INDEX:
  - make sure it looks the same on different browsers
  - SEARCH: regex or ilike

BROWSE: DONE!!!!!!!!!!!!!!!!!!!
  - slide up the playground section
  - in playground section, after clicking, it scrolls up to the profile partial section

PROFILE: DONE!!!!!!!!!!!!!!!!!!!
  - fix video url post route to not include nil values
  - include direct FDR link
  - if there are no comments in the rating form, there should not be an empty box
  - fix

MIGRATIONS -- DONE!!!!!!!!!!!!!!!!!!!!!!
  - convert into four migration tables
  - Dog table: include direct FDR link


DOUBLECHECK
  - all routes

JAVASCRIPT
  - organize!
  - ajax when there is a new rating - no refresh

EXTRA FEATURES
  - picture uploader
  - comment generator - array & randomize
  - implement feedback


<!--   <div class="comments_section">
    <% if !@valid_comments.blank? %>
      <% @valid_comments.each do |rating| %>
      <div class="bubble">
        <p><%= rating.comments %></p>
      </div>
    <% else %>
      <h1> NO COMMENTS!!!!!!!!!!</h1>
    <% end %>
      <% end %>
      <% end %>
  </div> -->




   <div class="share_feed">
    <h1>Volunteer Share Feed</h1>
      <% if !@valid_videos.blank? %>
      <% @valid_videos.each do |rating| %>

      <iframe width="460" height="315" src="https://www.youtube.com/embed/" + <%= rating.video_url.split('=')[-1] %> frameborder="0" allowfullscreen></iframe>
      <% end %>
    <% end %>



$('.rate_form input')
iterate through this where when "$('#checkbox_independent').is(":checked")" gives us true, we will add that parameter to "on" in the post route.




 <p>Name: <%= dog.name%> </p>
            <p>Breed: <%= dog.breed%> </p>
            <p>Gender: <%= dog.gender%> </p><br>










//// P10 v.2 ////

*HAS MANY
  - FAVORITES:
    ? what if the user is not logged in?

*STYLIZED SITE
  - INDEX - Add icons & descriptions
  - BROWSE - hover effect w/ info (javascript?); dialog box;
  - SEARCH: ilike or autocomplete
  - FAVORITES page - compares all the ones you favorited

*API
  - Instagram tagged photo?
  - Rescue Orgs api?

*AJAX
  - PLAYGROUND - remove a dog from the playground with ajax

*JAVASCRIPT EFFECTS - BROWSE
  - hover effect with javascript
  - during drag, thumbnail becomes smaller
  -



