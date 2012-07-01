// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_tree .

function count_words(text) {
  return text.match(/\b/g).length / 2;
}

function random_number_with_digits(number_of_digits) {
  var min = Math.pow(10, number_of_digits - 1);
  var max = Math.pow(10, number_of_digits) - 1;
  return random_number_between(min, max);
}

function random_number_between(x, y) {
  var rand = x + (Math.random() * (y - x));
  return Math.round(rand);
}

function TextFormatter(settings) {
  this.config = {
    text: '',
    limit: 500,
    container: null
  }

  // provide for custom configuration
  if (settings && typeof(settings) == 'object') {
    $.extend(this.config, settings);
  }

  this.config.text = this.config.container.html();

  // regular on click handler wouldn't work
  // because the element can be created after
  // the handler
  // to preserve the reference to `this` within the function
  // we need to bind it.
  this.config.container.on('click', 'a.show_more', function() {
    this.config.container.html(this.full_text());
  }.bind(this));

  this.config.container.on('click', 'a.show_less', function() {
    this.config.container.html(this.shortened_text());
  }.bind(this));

  this.shortened_text = function() {
    var text = this.config.text;
    var limit = this.config.limit;
    shortened = text.substring(0, limit);
    if(text.length > limit) {
      shortened += "... ";
      shortened += '<a href="#" class="show_more">more</a>';
    }
    return shortened;
  }

  this.full_text = function() {
    var full_text = this.config.text;
    full_text += '<a href="#" class="show_less">less</a>';
    return full_text;
  }

  this.shorten = function() {
    this.config.container.html(this.shortened_text());
  }
}

function ContentSelector(settings) {
  this.config = {}

  // provide for custom configuration
  if (settings && typeof(settings) == 'object') {
    $.extend(this.config, settings);
  }

  var selector = this;

  this.update_content = function() {
    var language_id = selector.config.language_select.val();
    var category_id = selector.config.category_select.val();
    $.get("/contents.json", {
        language_id: language_id,
        category_id: category_id
      },
      function(data) {
        selector.contents = data;
        var carousel_div = selector.config.carousel_container
        carousel_div.html('');
        carousel_div.removeClass('ui-carousel');
        carousel_div.attr('style', '');
        for(var i = 0; i < data.length; i++) {
          var content = data[i];
          var image_container = $("<div />").addClass("image_container");
          var image = $("<img />").attr("src", content.photo_url).attr("width", 70).attr("height", 100).addClass('content_image');
          image_container.append(image);
          carousel_div.append(image_container);
        }
        var widget = $.data(carousel_div[0], "rcarousel")
        if(widget) widget.destroy();

        var visible = data.length > 2 ? 3 : data.length;
        var step = data.length > 2 ? 3 : 1;
        if(visible > 0) {
          carousel_div.rcarousel({
            visible: visible,
            width: 200,
            height: 300,
            step: step 
          });
        } else {
          alert('No results');
        }
      }
    );
  };

  this.config.language_select.change(selector.update_content);
  this.config.category_select.change(selector.update_content);

  this.config.category_select.change(function() {
    var category_id = $(this).val();
  });

  // regular on click handler wouldn't work
  // because the element can be created after
  // the handler
  this.config.carousel_container.on('click', 'img.content_image', function() {
    var image_to_change = selector.config.selected_content_container.find('img.content_image');
    var text_to_change = selector.config.selected_content_container.find('div.title')

    var clicked_image = $(this);
    var new_src = clicked_image.attr('src')
    var new_text = clicked_image.parent().parent().find("div.title").text();

    image_to_change.attr('src', new_src);
    text_to_change.text(new_text);
    return false;
  });

  //this.shortened_text = function() {
  //}
}
