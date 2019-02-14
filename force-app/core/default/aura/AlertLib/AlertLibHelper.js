({
    toggleVisible : function(component, visible) {

        var notifier = component.find('notifier');
        var variant = component.get('v.variant');

        if (visible) {
            $A.util.removeClass(notifier, 'slds-hide');
            $A.util.addClass(notifier, variant);
        } else {
            $A.util.addClass(notifier, 'slds-hide');
            $A.util.removeClass(notifier, variant);
        }
    },

    showMessage: function (component, event, variant) {
        
        var params = event.getParam('arguments');

        component.set('v.msg', params.message);
        component.set('v.variant', variant);

        this.toggleVisible(component, true);
    }
})
