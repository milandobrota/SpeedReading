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
//= require twitter/bootstrap
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
      shortened += ' <a href="#" class="show_more">more</a>';
    }
    return shortened;
  }

  this.full_text = function() {
    var full_text = this.config.text;
    full_text += ' <a href="#" class="show_less">less</a>';
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

        // rebuild the carousel
        var carousel_div = selector.config.carousel_container
        carousel_div.html('');
        carousel_div.removeClass('ui-carousel');
        carousel_div.attr('style', '');
        for(var i = 0; i < data.length; i++) {
          var content = data[i];
          var image_container = $("<div />").addClass("image_container");
          var link = $("<a href='#'></a>");
          var image = $("<img />").attr("src", content.photo_url).attr("width", 70).attr("height", 100).attr("data-content-id", content.id).addClass('content_image');

          link.append(image);
          image_container.append(link);

          var title_container = $("<div />").addClass("title");
          title_container.text(content.name);
          image_container.append(title_container);

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
          carousel_div.html("<br /><br /><br />No results for this criteria");
        }
      }
    );
  };

  this.update_content();

  this.config.show_popup_button.click(function() {
    selector.config.popup_container.show();
    selector.config.grayout.css("visibility", "visible");
  });

  this.config.close_popup_button.click(function() {
    selector.config.popup_container.hide();
    selector.config.grayout.css("visibility", "hidden");
  });

  this.config.language_select.change(selector.update_content);
  this.config.category_select.change(selector.update_content);

  this.config.category_select.change(function() {
    var category_id = $(this).val();
  });

  // regular on click handler wouldn't work
  // because the element can be created after
  // the handler
  this.config.carousel_container.on('click', 'img.content_image', function() {
    var clicked_image = $(this);

    var image_to_change = $("#selected_image");
    var content_name_container = $("#content_name");
    var content_credit_link = $("#content_credit");
    var content_language_container = $("#content_language");

    var selected_content_id = clicked_image.attr('data-content-id');
    var selected_content;
    for(var i = 0; i < selector.contents.length; i++) {
      var temp = selector.contents[i];
      if(temp.id == selected_content_id) {
        selected_content = temp;
        break;
      }
    }

    image_to_change.attr('src', selected_content.photo_url);
    content_name_container.text(selected_content.name);
    content_credit_link.text(selected_content.source_name);
    content_credit_link.attr('href', selected_content.source_link);
    content_language_container.text(selected_content.language_name);

    // selector.config.current_test.words = selected_content.body.split(" ").reverse();
    selector.config.current_test.text = selected_content.body;
    selector.config.current_test.content_id = selected_content.id;
    return false;
  });
}

var Countdown = new Object({
  start: function() {
    Countdown.container = $("#countdown");
    Countdown.container.show();
    Countdown.count = 3;
    Countdown.countdown();
  },

  countdown: function() {
    if(Countdown.count <= 0) {
      Countdown.container.text('');
      Countdown.container.hide();
      if(Countdown.callback) Countdown.callback();
    } else {
      Countdown.container.text(Countdown.count);
      Countdown.count = Countdown.count - 1;
      setTimeout(Countdown.countdown, 1000);
    }
  }
});
