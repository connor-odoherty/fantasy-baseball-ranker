document.addEventListener("turbolinks:load", function () {
    $('#rankings-table').sortable({
        items: '.player-ranking-row',
        // containment: 'document',
        // cursorAt: { right: 100 },
        handle: ".fa-sort",
        // revert: true,
        change: function(event, ui) {
            // updateOVRRankingValuesAfterReorder();
            // $('.ranking-tab:visible').each(function (index, elem) {
            //     $(elem).text((index + 1).toString());
            // });
            // var numBefore = $('.ui-sortable-placeholder').prevAll('.ranking-row').length;
            // $('.ui-sortable-placeholder').text(numBefore);
        },
        update: function(e, ui) {
            // updateOVRRankingValuesAfterReorder();
            // $.ajax({
            //     url: $(this).data("url"),
            //     type: "PATCH",
            //     data: $(this).sortable('serialize')
            // });
            // console.log($(this).sortable('serialize'));

        },
        stop: function(e, ui) {
            // updateOVRRankingValuesAfterReorder();
            // $.ajax({
            //     url: $(this).data("url"),
            //     type: "PATCH",
            //     data: $(this).sortable('serialize')
            // });
            // console.log($(this).sortable('serialize'));

        }
    });
});

// document.addEventListener("turbolinks:load", function () {
//     $('.draggable-player-list').sortable({
//         items: '.ranking-row',
//         // containment: 'document',
//         cursorAt: { right: 100 },
//         handle: ".fa-sort",
//         // revert: true,
//         change: function(event, ui) {
//             updateOVRRankingValuesAfterReorder();
//             $('.ranking-tab:visible').each(function (index, elem) {
//                 $(elem).text((index + 1).toString());
//             });
//             var numBefore = $('.ui-sortable-placeholder').prevAll('.ranking-row').length;
//             $('.ui-sortable-placeholder').text(numBefore);
//         },
//         update: function(e, ui) {
//             updateOVRRankingValuesAfterReorder();
//             // $.ajax({
//             //     url: $(this).data("url"),
//             //     type: "PATCH",
//             //     data: $(this).sortable('serialize')
//             // });
//             // console.log($(this).sortable('serialize'));
//
//         },
//         stop: function(e, ui) {
//             updateOVRRankingValuesAfterReorder();
//             // $.ajax({
//             //     url: $(this).data("url"),
//             //     type: "PATCH",
//             //     data: $(this).sortable('serialize')
//             // });
//             // console.log($(this).sortable('serialize'));
//
//         }
//     });
// });
//
// function updateOVRRankingValuesAfterReorder() {
//     $('.player-ranking-form').each(function (index, elem) {
//         var rank = index + 1;
//         var playerRankingForm = $(elem);
//         playerRankingForm.find('.ranking-tab').text((rank).toString());
//         // playerRankingForm.find('.ovr-rank-field').val(rank);
//         // playerRankingForm.find('.position-field').val(rank);
//         // var formElem  = $(elem);
//         // console.log('ELEM:', formElem);
//         // console.log('ELEM VALUE BEFORE:', formElem.val());
//         // console.log('SET TO:', index);
//         // formElem.val(index);
//         // console.log('ELEM VALUE AFTER:', formElem.val());
//
//     })
// }

// document.addEventListener("turbolinks:load", function () {
//     $('.draggable-player-list').sortable({
//         items: '.ranking-row',
//         // containment: 'document',
//         cursorAt: { right: 10 },
//         handle: ".fa-sort",
//         // revert: true,
//         change: function(event, ui) {
//             updateOVRRankingValuesAfterReorder();
//             // var modder = 1;
//             // $('.ranking-col:visible').each(function (index, elem) {
//             //     if ($(elem).hasClass('ui-sortable-helper')) {
//             //         modder = 0
//             //     }
//             //     $(elem).text((index + modder).toString());
//             // });
//             var numBefore = $('.ui-sortable-placeholder').prevAll('.ranking-row').length;
//             $('.ui-sortable-helper > .ranking-col').text(numBefore + 1 - $('.ui-sortable-placeholder').prevAll('.ui-sortable-helper').length);
//             // $('.ui-sortable-placeholder').nextAll('.ranking-row').each(function (index, elem) {
//             //     $(elem).find('ranking-col').text(numBefore + index + 1);
//             // });
//         },
//         update: function(event, ui) {
//             updateOVRRankingValuesAfterReorder();
//             var item = ui.item;
//             $(item).after($('#' + item.attr('aria-controls')))
//         },
//         stop: function(e, ui) {
//             updateOVRRankingValuesAfterReorder();
//             // $.ajax({
//             //     url: $(this).data("url"),
//             //     type: "PATCH",
//             //     data: $(this).sortable('serialize')
//             // });
//             // console.log($(this).sortable('serialize'));
//
//         }
//     });
// });
//
// function updateOVRRankingValuesAfterReorder() {
//     $('.ranking-col:visible').each(function (index, elem) {
//         var rank = index + 1;
//         // $(elem).text(rank - $(elem).prevAll('.ui-sortable-helper').length);
//         $(elem).text(rank);
//         // playerRankingForm.find('.ovr-rank-field').val(rank);
//         // playerRankingForm.find('.position-field').val(rank);
//         // var formElem  = $(elem);
//         // console.log('ELEM:', formElem);
//         // console.log('ELEM VALUE BEFORE:', formElem.val());
//         // console.log('SET TO:', index);
//         // formElem.val(index);
//         // console.log('ELEM VALUE AFTER:', formElem.val());
//
//     })
// }
