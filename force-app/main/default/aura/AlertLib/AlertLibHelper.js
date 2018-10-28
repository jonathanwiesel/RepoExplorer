({
    toggleVisible : function(component) {

        var notifier = component.find('notifier');
        var variant = component.get('v.variant');

        $A.util.toggleClass(notifier, 'slds-hide');
        $A.util.toggleClass(notifier, variant);
    },

    showMessage: function (component, event, variant) {
        
        var params = event.getParam('arguments');

        component.set('v.msg', params.message);
        component.set('v.variant', variant);

        this.toggleVisible(component);
    }
})
