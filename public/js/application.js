$(document).ready(function() {
  bindEvents();
});

var randomArrayElement = function(array) {
  return array[Math.floor(Math.random()*array.length)];
};

ImageResizer = {
  shrinkImage: function(clone) {
    var dogImage = clone[0].getElementsByTagName("img")[0];
    var currW = dogImage.width;
    var currH = dogImage.height;

    var newSize = scaleSize(130, 130, currW, currH);

    function scaleSize(maxW, maxH, currW, currH){

      var ratio = currH / currW;

      if(currW >= maxW && ratio <= 1){
        currW = maxW;
        currH = currW * ratio;
      } else if(currH >= maxH){
        currH = maxH;
        currW = currH / ratio;
      }

      return [currW, currH];
    }

    dogImage.setAttribute("style", "width:"+ newSize[0] + "px;" + "height:" + newSize[1]+"px;");

    return dogImage;
  }
};




function bindEvents() {
  // $('.crazy_section').on('click', addRandomDogToPage);
  $('.crazy_section').on('click', useDogGifs);

  $('#search_form').on('submit', getSearchResults);

  $('#login_form').hide(function(){
    $('.login_section button').on('click', function(){
      $('#login_form').slideToggle();
    });
  });

  $('#register_form').hide(function(){
    $('.register_section button').on('click', function(){
      $('#register_form').slideToggle();
    });
  });

  $('.rate_form').hide(function(){
    $('.rate_section button').on('click', function() {
      $('.rate_form').slideToggle();
    });
  });

  $('.drag-dog-container').draggable({helper: 'clone'});


  $('.playground_section').droppable({
    accept: '.drag-dog-container',
    drop: function(event, ui){
      var clone = $(ui.draggable).clone();
      $(this).append(ImageResizer.shrinkImage(clone));
      var id = $('.playground_section img').last().data('dog-id')
      var button = "<button class='remove-button' id='" + id +"'>Remove</button>"
      $(this).append(button)
      $('.favorite-button').css('display','block').show();
    }
  });

  $('.favorite-button').on('click', function() {
    var favoriteIds = getFavoriteIds();
    var data = { favorite_ids: favoriteIds };
    var ajaxFave = $.ajax ({
      url: '/favorites',
      type: 'post',
      data: data
    });
    ajaxFave.done(function(){
      window.location.href='/favorites';
    })
  });

  function getFavoriteIds() {
    var $dogImgs = $('.playground_section').find('.browse_dog_pic');

    return $dogImgs.map(function() {
      return this.getAttribute('data-dog-id');
    }).toArray();
  }

// REMOVE FROM FAVORITES
  $('.playground_section').on('click', 'button.remove-button', removeDogFave)

  $('#hide').click(function(){
    $('.playground_section').hide();
    $('#show').show();
  });

  $('#show').click(function(){
    $('.playground_section').show();
  });

  $('.playground_section').on('click', 'img', pullUpProfile);

  $('button#show_browse').on('click', function(){
    alert('clicked');
    $('.browse_list').css("display", "inline");
  });

  // FAVORITES PAGE - REMOVE
  $('.whole_profile .remove-button').on('click', deleteFaveDog)

}


var deleteFaveDog = function(event){
  event.preventDefault();
  $this = $(this)
  var dog_id = $this.closest('div').attr('data-dog-id');
  $.ajax({
    url: '/favorites',
    type: 'delete',
    data: {dog_id: dog_id}
  })
  .done(function() {
    console.log("success");
    $("div[data-dog-id='" + dog_id + "']").remove();
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });

};

var pullUpProfile = function(event){
  event.preventDefault();
  var id = $(this).data('dog-id');

  var ajaxProfile = $.ajax({
    url: '/dogs/' + id,
    type: 'get'
  });
  ajaxProfile.done(function(data){
    $('.list').remove();
    $('.profile_show').append(data);
    // $('.blacken').attr("background", "black")
    // $('.blacken').attr("opacity", ".7")
    // $('.ui-dialog').css('z-index', 9999);
    // $('.browse_list').hide();
    $('.profile_show').dialog({width:'1240', height: '700'});
      });
    $('.profile_show').dialog( "moveToTop" );
    // $('.ui-dialog').first().css('z-index', '9999');      // $('.profile_show').css('z-index', '9999');
};

var getSearchResults = function(event){
  event.preventDefault();
  var formData = $(this).serialize();
  console.log(formData);
  var request = $.ajax({
    url: '/search',
    type: 'post',
    data: formData,
  });

  request.done(function(dogs) {
    if(dogs.length === 0){
      $('.search_section').empty();
      // $('.playground_section').hide();
      $('.search_section').append("<p>No results. Please try again.</p>");
      $('.search_section').css("padding-top", "100px");
      $('.search_section').css("text-align", "center");
      $('.search_section p').addClass("error_red");
    }else {
      var dogNodes = dogs.map(dogToHTML);
      $('.search_section').empty();
      // $('.playground_section').hide();
      // $('.browse_list').hide();
      $('.search_section').html(dogNodes);
      // $('.search_section').append("<button id='show_browse'>Browse</button>");
    }
    });

  request.fail(function() {
    console.log("error");
  });

  request.always(function() {
    console.log("complete");
  });

};

var dogToHTML = function(dog){
  var html = $('.search-result-template').clone().removeClass('search-result-template').show();
  var aTag = "<a href='/dogs/" + dog["id"] + "'>Click here to see their ratings</a>";
  html.find('img').attr('src', dog["image_link"]);
  html.find('.search_results').text(dog["name"] + " | " + dog["breed"] + " | " + dog["gender"] + "  " );
  html.find('.search_results').append(aTag);
  return html;
  // var id = dog["id"];
  // var name = dog["name"];
  // var breed = dog["breed"];
  // var gender = dog["gender"];
  // var image_link = dog["image_link"];
  // var imgTag = "<img src=' "+ image_link + "'style='padding-top: 90px; max-width: 350px; max-height: 400px'>"
  // var infoTag = "<p class='search_results'>"+ name +
  // "&nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp; " + breed +
  // "&nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp; " + gender + aTag +
  // "</p><br><br>";
  // return $('<div>').append(imgTag, infoTag);
};



// crazy dog random gifs

var useDogGifs = function(){
  var dogGifs = ['http://tobystereo.com/wp-content/uploads/2014/05/VVBatchExportergiphy_dog.gif', 'http://24.media.tumblr.com/tumblr_ma2dhq2hsu1qkb04po1_500.gif', 'https://31.media.tumblr.com/d59648a7c875658955dbf9aeab7a8059/tumblr_inline_n0rlqc38vl1s0subn.gif', 'https://33.media.tumblr.com/d2c8354c4159407804910207dc13c9eb/tumblr_n3hgaa9wmz1so0ukuo1_500.gif', 'https://31.media.tumblr.com/25ec1da1ceb3d8c59ff61abda466e66d/tumblr_mqpocpPXk01rtd1nko2_500.gif', 'https://33.media.tumblr.com/4fbb61f48f4c5cfa451a88e14f6579e7/tumblr_mwwh9w2vJf1s6294bo1_400.gif', 'http://24.media.tumblr.com/6c964b25e6e545e116d7062278979b65/tumblr_msy9f60uGy1qcdozto1_r3_500.gif', 'http://media.giphy.com/media/cdnHZOmT7y1Jm/giphy.gif', 'http://media.giphy.com/media/omuVatiGBMBIQ/giphy.gif', 'http://media.giphy.com/media/1snUe9sDi9R2U/giphy.gif', 'http://media.giphy.com/media/2EJRTwQPrYju0/giphy.gif'];
   var randomImage = dogGifs[Math.floor(Math.random()*dogGifs.length)]

   var randomAxis = Math.floor(Math.random()*1500)
   var marginTopRandom = Math.floor(Math.random()*500)
   $('.crazy_section').append("<img src='" + randomImage + "' width='200'>");
   $('.crazy_section img').last().css('left', randomAxis +'px')
   $('.crazy_section img').last().css('margin-top', marginTopRandom + 'px')
 };




// using google api
// var loadRandomDogGifUrls = function(callback) {
//   $.ajax({
//     url: 'https://www.googleapis.com/customsearch/v1?cx=016871532285775593244%3Ahitwjirk3ac&q=dog%20transparent%20gif&searchType=image&num=10&start=11&key=AIzaSyAy1FwWb_llGer7CJZk65r63ZidHFqdJ9Q',
//     type: 'get',
//     dataType: 'json',
//   })
//   .done(function(response) {
//     var searchResultObjects = response.items
//     var gifLinks = [];
//     for(var object in searchResultObjects) {
//       gifLinks.push(searchResultObjects[object]['link']);
//     }
//     useDogGifs(gifLinks);
//     saveDogGifs(gifLinks);
//     callback(gifLinks);
//   })
//   .fail(function(response) {
//     console.log("response is: ", response);
//     loadGifs().done(function(gifs){
//       var gifUrls = gifs.map(function(gif){ return gif.url; });
//       callback(gifUrls);
//     });
//   })
// }

// var addRandomDogToPage = function(callback) {

//   loadRandomDogGifUrls(function(dogGifUrls){
//     useDogGifs(dogGifUrls);
//   })
// };

// var loadGifs = function(){
//   return $.getJSON('/gifs');
// };




// //function - for success where we get the dog gifs from the api, there will be an ajax call
// var useDogGifs = function(dogGifArray){
//   var randomImage = randomArrayElement(dogGifArray);

//   var randomAxis = Math.floor(Math.random()*1500)
//   var marginTopRandom = Math.floor(Math.random()*500)
//   var $crazyImgs = $('.crazy_section img')
//   $('.crazy_section').append("<img src='" + randomImage + "' width='200' onerror='imgError(this)';> ");
//   $crazyImgs.last().css('left', randomAxis +'px')
//   $crazyImgs.last().css('margin-top', marginTopRandom + 'px')
//   $crazyImgs.error(function(){
//     $(this).unbind("error").attr("src", "http://25.media.tumblr.com/3274a78bd1ea4d67ca54b03c70771f2c/tumblr_miavcw7PIn1rj3x28o1_500.gif");
//     // $(this).unbind("error").attr("src", "http://media.giphy.com/media/MCtZL1YFcZthS/giphy.gif");
//   })
// }

// var saveDogGifs = function(dogGifs){
//   return $.ajax({
//     url: '/crazydogs',
//     type: 'post',
//     data: {
//       gifArray: dogGifs
//     }
//   });

// }

// function imgError(image) {
//     image.onerror = "";
//     image.src = "http://media.giphy.com/media/5xtDarniHFmiZuCoW40/giphy.gif";
//     return true;
// }

var removeDogFave = function(){
  var id = $(this).attr('id')
  $(".playground_section img[data-dog-id='" + id +"']").remove();
  $("button[id='" + id +"']").remove();
}


