$(function() {
    const modal_holder_selector = '#modal-holder';
    const modal_selector = '.modal';

    $(document).on('click', 'a[data-modal]', function() {
        const location = $(this).attr('href');
        // Load modal dialog from server
        $.get(
            location,
            function(data){ $(modal_holder_selector).html(data).find(modal_selector).modal() }
    );
        return false;
    });

    $(document).on('ajax:success', 'form[data-modal]', function(event, peep, status, meep){
        // console.log(event)
        // console.log(peep)
        // console.log(status)
        // console.log(meep)
        //
        // const [data, _status, xhr] = event.detail;
        // const url = xhr.getResponseHeader('Location');
        // if (url) {
        //     // Redirect to url
        //     window.location = url;
        // } else {
        //     // Remove old modal backdrop
        //     $('.modal-backdrop').remove();
        //     // Update modal content
        //     const modal = $(data).find('body').html();
        //     $(modal_holder_selector).html(modal).find(modal_selector).modal();
        // }

        return false;
    });
});