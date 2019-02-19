({
    getFileContent : function(component) {
        
        var action = component.get('c.getFileContent');
        var repo = component.get('v.repo');
        var filePath = component.get('v.filePath');

        action.setParams({
            'stringifiedRepo': JSON.stringify(repo),
            'path': filePath
        });
        
        var _this = this;

        _this.toggleSpinner(component);
        action.setCallback(this, function(response) {
            
            _this.toggleSpinner(component);
            var state = response.getState();
            
            if (state === 'SUCCESS') {
                
                var res = response.getReturnValue();
                
                if (res.error) {
                    _this.showError(component, res.error);
                    return;
                }

                component.set('v.rawData', res.raw);

                //Using a timeout since if calling sincronously the data has not yet been injected into the DOM
                setTimeout(function() {

                    var block = component.find('highlightme').getElement();

                    hljs.highlightBlock(block);

                }, 1);
                

            } else if (state === "ERROR") {

                var errors = response.getError();
                
                if (errors && errors[0] && errors[0].message) {
                    
                    _this.showError(component, errors[0].message);

                } else {

                    _this.showError(component, 'Unknown error');
                }
            }
        });

        $A.enqueueAction(action);
    },


    toggleSpinner: function (component) {
        
        var spinner = component.find('loadingSpinner');
        $A.util.toggleClass(spinner, 'slds-hide');
    },


    showError: function(component, err) {
        component.find('alertLib').showErrorAlert(err);
    },
})
