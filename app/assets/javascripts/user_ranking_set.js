document.addEventListener("turbolinks:load", function () {
    $('.draggable-player-list').sortable({
        items: '.ranking-row',
        // revert: true,
        change: function(event, ui) {
            // updateOVRRankingValuesAfterReorder();
            $('.ranking-tab:visible').each(function (index, elem) {
                $(elem).text((index + 1).toString());
            });
            var numBefore = $('.ui-sortable-placeholder').prevAll('.ranking-row').length;
            $('.ui-sortable-placeholder').text(numBefore);
        },
        update: function(e, ui) {
            updateOVRRankingValuesAfterReorder();
            // $.ajax({
            //     url: $(this).data("url"),
            //     type: "PATCH",
            //     data: $(this).sortable('serialize')
            // });
            // console.log($(this).sortable('serialize'));

        }
    });
});

function updateOVRRankingValuesAfterReorder() {
    $('.player-ranking-form').each(function (index, elem) {
        var rank = index + 1;
        var playerRankingForm = $(elem);
        playerRankingForm.find('.ranking-tab').text((rank).toString());
        // playerRankingForm.find('.ovr-rank-field').val(rank);
        // playerRankingForm.find('.position-field').val(rank);
        // var formElem  = $(elem);
        // console.log('ELEM:', formElem);
        // console.log('ELEM VALUE BEFORE:', formElem.val());
        // console.log('SET TO:', index);
        // formElem.val(index);
        // console.log('ELEM VALUE AFTER:', formElem.val());

    })
}
