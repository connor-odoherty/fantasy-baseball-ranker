$('.autocomplete-text-field').on("autocompleteresponse", function (event, ui) {
    if (!$(event.target).is(':focus') && ui.content.length > 0) {
        $(event.target).val(ui.content[0].value);
        $($(event.target).attr('data-id-element')).val(ui.content[0].id);
        if (ui.content[0].id) {
            $($(event.target).attr('data-id-element')).trigger('change');
        }
    }
});

$('.autocomplete-text-field').bind('railsAutocomplete.select', function (event, data) {
    $($(this).attr('data-id-element')).val(data.item.id);
    if (data.item.id) {
        $($(this).attr('data-id-element')).trigger('change');
    }
});
// attempt to deal with autofocus problem for rails 3 autocomplete gem
// bug is trigged by a fresh reload of the page with an autocomplete with autofocus
// https://github.com/crowdint/rails3-jquery-autocomplete/issues/185
$('input[data-autocomplete][autofocus]').focus();


// $(document).on('turbolinks:load', ready);

$(document).on('railsAutocomplete.select', '.autocomplete-navigate-to', function(event, data) {
    Turbolinks.visit(data.item.navigate_to);
});

$(document).on('railsAutocomplete.select', '.autocomplete-xhr-navigate-to', function(event, data) {
    if(data.item.navigate_to)
        $.ajax({url: data.item.navigate_to});
});

$(document).ready(function(){

    $(document).bind('ajaxError', 'form.edit_user_player', function(event, jqxhr, settings, exception){

        // note: jqxhr.responseJSON undefined, parsing responseText instead
        $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

    });

});

(function($) {

    $.fn.modal_success = function(){
        // close modal
        // this.modal('hide');
        //
        // // clear form input elements
        // // todo/note: handle textarea, select, etc
        // this.find('form input[type="text"]').val('');
        //
        // // clear error state
        // this.clear_previous_errors();
    };

    $.fn.render_form_errors = function(errors){

        $form = this;
        this.clear_previous_errors();
        model = this.data('model');

        // show error messages in input form-group help-block
        $('#modal-error-handler').show();
        // $.each(errors, function(field, messages){
        //     console.log('Model:', model)
        //     console.log(field)
        //     console.log(messages)
        //     $input = $('input[name="' + model + '[' + field + ']"]');
        //     $('#modal-error-handler ul').append('<li>' + messages.join(' & ') + '</li>');
        //     $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
        // });
        $.each(errors, function(index, message){
            $('#modal-error-handler ul').append('<li>' + message + '</li>');
        });

    };

    $.fn.clear_previous_errors = function(){
        $('.form-group.has-error', this).each(function(){
            $('.help-block', $(this)).html('');
            $(this).removeClass('has-error');
        });
    }

}(jQuery));