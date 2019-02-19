({
    executeAction: function(component) {
        
        var file = component.get('v.file');

        switch (file.type) {
            case 'FILE':

                this.renderFileConent(component, file.path);
                break;
                
            case 'DIRECTORY':

                var dirSelected = component.getEvent('dirSelected');
                dirSelected.setParams({'selectedPath' : file.path});
                dirSelected.fire();
                break;

            default:
                break;
        }
    },

    renderFileConent: function(component, path) {
        
        $A.createComponent(
            'c:GitFileRenderer',
            {
                "repo": component.get('v.repository'),
                "filePath": path
            },
            function(msgBox, status) {    
                
                if (status === "SUCCESS") {

                    component.find('overlayLib').showCustomModal({
                        header: path,
                        body: msgBox, 
                        showCloseButton: true,
                        cssClass: 'slds-modal_large'
                    })
                }
            }
        );
    }
})