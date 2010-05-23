// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function toggleChannels(feed) {
    target = $F('disabler_for_' + feed);
    $('feed_' + feed + '_channels').disabled = target;
    $('all_channels_for_' + feed).disabled = target;
    $('to_feed_' + feed).disabled = target;
    $('from_feed_' + feed).disabled = target;
    $('filter_' + feed + '_field').disabled = target;
}

function selectAll(feed) {
    if (!$F('disabler_for_' + feed)) {
        for(var i = 0;i < $('feed_' + feed + '_channels').length;i++){
            $('feed_' + feed + '_channels').options[i].selected = true;
        }
    }
}