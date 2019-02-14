document.addEventListener("turbolinks:load", function () {
    $('#player-list').sortable({
        update: function(e, ui) {
            $.ajax({
                url: $(this).data("url"),
                type: "PATCH",
                data: $(this).sortable('serialize')
            });
            console.log($(this).sortable('serialize'));
        }
    });
});
