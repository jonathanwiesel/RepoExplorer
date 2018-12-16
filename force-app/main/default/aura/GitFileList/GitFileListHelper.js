({
    fetchFiles : function(component) {

        this.toggleSpinner(component);

        var getFilesAction = component.get('c.getFileTree');
        getFilesAction.setParams({
            'hostingService': component.get('v.hostingService'),
            'ownerName': component.get('v.owner'),
            'repoSlug': component.get('v.repoPath'),
            'path': component.get('v.filesPath'),
            'branch': component.get('v.branch')
        });
        
        var _this = this;

        getFilesAction.setCallback(this, function(response) {
            
            _this.toggleSpinner(component);
            var state = response.getState();
            
            if (state === 'SUCCESS') {
                
                var res = response.getReturnValue();
                
                if (res.error) {
                    _this.showError(component, res.error);
                    return;
                }

                component.set('v.files', res.tree);

            } else if (state === "ERROR") {

                var errors = response.getError();
                
                if (errors && errors[0] && errors[0].message) {
                    
                    _this.showError(component, errors[0].message);

                } else {

                    _this.showError(component, 'Unknown error');
                }
            }
        });

        $A.enqueueAction(getFilesAction);
    },

    showError: function(component, err) {
        component.find('alertLib').showErrorAlert(err);
    },

    toggleSpinner: function (component) {
        
        var spinner = component.find('loadingSpinner');
        $A.util.toggleClass(spinner, 'slds-hide');

        var working = component.get('v.working');
        component.set('v.working', !working);
    },
})
