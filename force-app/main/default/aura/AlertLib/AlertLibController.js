({
    dismiss: function(component, event, helper) {
        helper.toggleVisible(component, false);
    },

    showError: function (component, event, helper) {
        helper.showMessage(component, event, 'slds-theme_error');
    },

    showInfo: function (component, event, helper) {
        helper.showMessage(component, event, 'slds-theme_info');
    },

    showWarning: function (component, event, helper) {
        helper.showMessage(component, event, 'slds-theme_warning');
    }
})
