
$(document).ready(function() {
  $('.nav li.dropdown').hover(function() {
    $(this).addClass('open');
  }, function() {
    $(this).removeClass('open');
  });
});

$.typeahead(function(){
    if($(".js-typeahead").data().enable == "on") {
        return {
            input: ".js-typeahead",
            order: "asc",
            dynamic: true,
            minLength: 1,
            filter: true,
            maxItemPerGroup: 5,
            maxItem: 10,
            group:true,
            source: {
                suggestions: {
                    ajax: function (query) {
                        return {
                            type: "GET",
                            url: $(".js-typeahead").data().autosuggesturl,
                            path: "",
                            data: {
                                _sq: query
                            },
                            callback: {
                                done: function (data) {
                                    $(".js-typeahead").trigger("loaded", data);
                                    return data.suggestions;
                                }
                            }
                        }
                    },
                    href: $(".js-typeahead").data().searchurl + "?_sq={{display}}"
                },
                products: {
                    filter: false,
                    template: '<table><tr><td><img height=auto width="75px" src="{{image}}"/></td>' +
                        '<td><div style="padding-left:5px">{{title}}</div>' +
                        '<div style="padding-left:5px">{{price}}</div></td></tr></table>',
                    data: function (query) {
                        var deferred = $.Deferred();
                        $(".js-typeahead").on("loaded", function (event, data) {
                            if (data.products != null) {
                                deferred.resolve(data.products);
                            } else {
                                deferred.resolve([]);
                            }
                        });

                        return deferred;
                    },
                    href: $(".js-typeahead").data().producturl + "/{{pid}}"
                }
            }
        }
    }
  }()
);
