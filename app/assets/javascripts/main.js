var ready = function(scope) {
    scope.find('.autocomplete-text-field').on("autocompleteresponse", function (event, ui) {
        if (!$(event.target).is(':focus') && ui.content.length > 0) {
            $(event.target).val(ui.content[0].value);
            $($(event.target).attr('data-id-element')).val(ui.content[0].id);
            if (ui.content[0].id) {
                $($(event.target).attr('data-id-element')).trigger('change');
            }
        }
    });

    scope.find('.autocomplete-text-field').bind('railsAutocomplete.select', function (event, data) {
        $($(this).attr('data-id-element')).val(data.item.id);
        if (data.item.id) {
            $($(this).attr('data-id-element')).trigger('change');
        }
    });
// attempt to deal with autofocus problem for rails 3 autocomplete gem
// bug is trigged by a fresh reload of the page with an autocomplete with autofocus
// https://github.com/crowdint/rails3-jquery-autocomplete/issues/185
    scope.find('input[data-autocomplete][autofocus]').focus();
};


$(document).on('turbolinks:load', ready);

$(document).on('railsAutocomplete.select', '.autocomplete-navigate-to', function(event, data) {
    Turbolinks.visit(data.item.navigate_to);
});

$(document).on('railsAutocomplete.select', '.autocomplete-xhr-navigate-to', function(event, data) {
    if(data.item.navigate_to)
        $.ajax({url: data.item.navigate_to});
});