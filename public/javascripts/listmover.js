var ChannelMover = Class.create();

ChannelMover.prototype = {
    initialize: function(feed) {
        this.feed = feed
    },

    addToFeed: function() {
        filter = eval('filter_' + this.feed);
        all = $('all_channels_for_' + this.feed);
        selected = $('feed_' + this.feed + '_channels');
        
        options = $A(all.options).findAll(function(o) {return o.selected});
        options.each(function(option) {
            element = document.createElement('option');
            text = document.createTextNode(option.text);
            element.value = option.value;
            selected.appendChild(element.appendChild(text).parentNode);
        });
        filter.reset();
        all.selectedIndex = -1;
        selected.selectedIndex = -1;
        options2 = $A(all.options).findAll(function(o) {
            return options.find(function(p) {
                return p.text == o.text;
            })
        });
        
        options2.each(function(option) {
            all.removeChild(option);
        });
        filter.init();
        $('filter_' + this.feed + '_field').value = '';
    },
    
    removeFromFeed: function() {
        filter = eval('filter_' + this.feed);
        filter.reset();
        
        all = $('all_channels_for_' + this.feed);
        selected = $('feed_' + this.feed + '_channels');

        $A(selected.options).findAll(function(o) {return o.selected}).each(function(option) {
            element = document.createElement('option');
            text = document.createTextNode(option.text);
            element.value = option.value;
            all.appendChild(element.appendChild(text).parentNode);
            selected.removeChild(option);
        });

        all.selectedIndex = -1;
        selected.selectedIndex = -1;
        filter.init();
        $('filter_' + this.feed + '_field').value = '';
    }
}